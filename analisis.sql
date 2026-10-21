-- PROYECTO FINAL: ANALISIS DE VENTAS E-COMMERCE
-- ETAPA 1: LIMPIEZA Y VALIDACION DE DATOS

-- Identificamos valores faltantes en campos criticos
-- para evitar errores en el calculo de ingresos.

SELECT
    COUNT(*) FILTER (WHERE fecha_pedido IS NULL)
        AS fechas_nulas,
    COUNT(*) FILTER (WHERE precio_unitario IS NULL)
        AS precios_nulos,
    COUNT(*) FILTER (WHERE cantidad IS NULL)
        AS cantidades_nulas
FROM pedidos;

-- Revisamos precios faltantes en el catalogo.

SELECT
    COUNT(*) FILTER (WHERE precio IS NULL)
        AS precios_productos_nulos
FROM productos;



-- ETAPA 2: TRATAMIENTO DE VALORES NULOS

-- Recuperamos el precio del catalogo cuando falta
-- en el pedido. Si ambos valores son desconocidos,
-- mantenemos NULL para evitar ingresos ficticios.

SELECT
    pe.id_pedido,
    pr.nombre_producto,
    pe.cantidad,
    COALESCE(pe.precio_unitario, pr.precio)
        AS precio_corregido,
    pe.cantidad *
        COALESCE(pe.precio_unitario, pr.precio)
        AS total_venta
FROM pedidos pe
JOIN productos pr
    ON pe.id_producto = pr.id_producto
ORDER BY pe.id_pedido;



-- ETAPA 3: VALIDACION DE TIPOS DE DATOS

-- Verificamos que las fechas y los precios tengan
-- tipos adecuados para realizar calculos confiables.

SELECT
    table_name,
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('clientes', 'productos', 'pedidos')
  AND column_name IN (
      'fecha_registro',
      'fecha_pedido',
      'precio',
      'precio_unitario'
  )
ORDER BY table_name, column_name;



-- ETAPA 4: ANALISIS DE NEGOCIO
-- CONSULTA 1: TOP 5 CLIENTES POR GASTO TOTAL

-- Identificamos a los clientes que generan mayores ingresos para orientar estrategias de fidelizacion.
-- Excluimos operaciones sin precio conocido para evitar considerar importes desconocidos como cero.

SELECT
    c.id_cliente,
    c.nombre,
    c.ciudad,
    COUNT(p.id_pedido) AS cantidad_pedidos,
    SUM(
        p.cantidad *
        COALESCE(p.precio_unitario, pr.precio)
    ) AS gasto_total
FROM clientes c
JOIN pedidos p
    ON c.id_cliente = p.id_cliente
JOIN productos pr
    ON p.id_producto = pr.id_producto
WHERE p.cantidad > 0
  AND COALESCE(p.precio_unitario, pr.precio) IS NOT NULL
GROUP BY c.id_cliente, c.nombre, c.ciudad
ORDER BY gasto_total DESC, c.id_cliente
LIMIT 5;



-- Analizamos la evolucion mensual de los ingresos para identificar periodos de mayor facturacion y posibles oportunidades comerciales.
-- Excluimos pedidos sin precio conocido.

SELECT
    TO_CHAR(p.fecha_pedido, 'YYYY-MM') AS mes,
    COUNT(p.id_pedido) AS cantidad_pedidos,
    SUM(
        p.cantidad *
        COALESCE(p.precio_unitario, pr.precio)
    ) AS ventas_totales
FROM pedidos p
JOIN productos pr
    ON p.id_producto = pr.id_producto
WHERE p.fecha_pedido IS NOT NULL
  AND p.cantidad > 0
  AND COALESCE(p.precio_unitario, pr.precio) IS NOT NULL
GROUP BY TO_CHAR(p.fecha_pedido, 'YYYY-MM')
ORDER BY mes;



-- CONSULTA 3: PRODUCTOS MENOS VENDIDOS

-- Identificamos los productos con menor rotacion para evaluar oportunidades de promocion.
-- LEFT JOIN permite incluir productos sin ventas.
-- No excluimos pedidos sin precio porque la cantidad vendida puede conocerse aunque el importe no.

SELECT
    pr.id_producto,
    pr.nombre_producto,
    pr.categoria,
    COALESCE(SUM(pe.cantidad), 0) AS unidades_vendidas,
    COUNT(pe.id_pedido) AS cantidad_pedidos
FROM productos pr
LEFT JOIN pedidos pe
    ON pr.id_producto = pe.id_producto
GROUP BY
    pr.id_producto,
    pr.nombre_producto,
    pr.categoria
ORDER BY unidades_vendidas ASC, pr.id_producto
LIMIT 3;



-- CONSULTA 4: RANKING DE PEDIDOS POR CATEGORIA

-- Clasificamos los pedidos segun su valor economico dentro de cada categoria para identificar las operaciones de mayor impacto en la facturacion.
-- Excluimos pedidos sin precio conocido.

SELECT
    pe.id_pedido,
    pr.categoria,
    pr.nombre_producto,
    pe.cantidad,
    pe.cantidad *
        COALESCE(pe.precio_unitario, pr.precio)
        AS total_pedido,
    RANK() OVER (
        PARTITION BY pr.categoria
        ORDER BY pe.cantidad *
            COALESCE(pe.precio_unitario, pr.precio) DESC
    ) AS ranking_categoria
FROM pedidos pe
JOIN productos pr
    ON pe.id_producto = pr.id_producto
WHERE pe.cantidad > 0
  AND COALESCE(pe.precio_unitario, pr.precio) IS NOT NULL
ORDER BY pr.categoria, ranking_categoria, pe.id_pedido;



-- CONSULTA 5: INGRESOS POR CATEGORIA

-- Comparamos la facturacion de las categorias para identificar cuales tienen mayor peso economico dentro del negocio.

SELECT
    pr.categoria,
    COUNT(pe.id_pedido) AS cantidad_pedidos,
    SUM(pe.cantidad) AS unidades_vendidas,
    SUM(
        pe.cantidad *
        COALESCE(pe.precio_unitario, pr.precio)
    ) AS ingresos_totales
FROM pedidos pe
JOIN productos pr
    ON pe.id_producto = pr.id_producto
WHERE pe.cantidad > 0
  AND COALESCE(pe.precio_unitario, pr.precio) IS NOT NULL
GROUP BY pr.categoria
ORDER BY ingresos_totales DESC;



-- CONSULTA 6: CLIENTES RECURRENTES

-- Identificamos clientes con mas de una compra para analizar su contribucion a los ingresos y detectar oportunidades de fidelizacion.
-- Contamos todos los pedidos, pero calculamos ingresos solo cuando conocemos el precio.

SELECT
    c.id_cliente,
    c.nombre,
    COUNT(pe.id_pedido) AS total_pedidos,
    COUNT(pe.id_pedido) FILTER (
        WHERE pe.cantidad > 0
          AND COALESCE(pe.precio_unitario, pr.precio)
              IS NOT NULL
    ) AS pedidos_valorizados,
    SUM(
        CASE
            WHEN pe.cantidad > 0
            THEN pe.cantidad *
                COALESCE(pe.precio_unitario, pr.precio)
            ELSE NULL
        END
    ) AS gasto_total_conocido
FROM clientes c
JOIN pedidos pe
    ON c.id_cliente = pe.id_cliente
JOIN productos pr
    ON pe.id_producto = pr.id_producto
GROUP BY c.id_cliente, c.nombre
HAVING COUNT(pe.id_pedido) > 1
ORDER BY total_pedidos DESC,
         gasto_total_conocido DESC;



-- VALIDACION ADICIONAL: COHERENCIA DE FECHAS

-- Detectamos pedidos anteriores al registro del cliente para identificar inconsistencias temporales que puedan afectar la calidad del analisis.

SELECT
    pe.id_pedido,
    c.nombre,
    c.fecha_registro,
    pe.fecha_pedido
FROM pedidos pe
JOIN clientes c
    ON pe.id_cliente = c.id_cliente
WHERE pe.fecha_pedido < c.fecha_registro
ORDER BY pe.id_pedido;
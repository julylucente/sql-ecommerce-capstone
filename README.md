# Proyecto Final: Análisis de Ventas de un E-commerce con PostgreSQL



## 1. Descripción del proyecto



Este proyecto tiene como objetivo realizar un análisis exploratorio de datos (EDA) sobre las ventas de un e-commerce ficticio dedicado a la comercialización de productos tecnológicos.



A través de PostgreSQL, se busca transformar los registros de clientes, productos y pedidos en información útil para la toma de decisiones comerciales.



El proyecto simula el flujo de trabajo de un analista de datos, incluyendo la creación de una base de datos, carga de información, limpieza, validación, análisis e interpretación de resultados.





## 2. Problema de negocio



Una tienda online necesita comprender el comportamiento de compra de sus clientes, identificar los productos y categorías con mejor desempeño y analizar la evolución de sus ingresos.



Para responder a estas necesidades se plantearon seis preguntas:



¿Cuáles son los cinco clientes con mayor gasto total?



¿Cómo evolucionaron las ventas mensuales?



¿Cuáles son los tres productos menos vendidos?



¿Cómo se posicionan los pedidos según su importe dentro de cada categoría?



¿Qué categorías generan mayores ingresos?



¿Qué clientes realizan compras recurrentes?





## 3. Herramientas utilizadas



PostgreSQL: creación y gestión de la base de datos.



DBeaver: ejecución y validación de consultas SQL.



GitHub: publicación y documentación del proyecto.





## 4. Dataset y estructura



Se utilizó un conjunto de datos ficticio, creado específicamente para este proyecto, que simula operaciones comerciales realizadas entre enero y junio de 2026.



La base de datos se denomina capstone\_project y contiene tres tablas relacionadas:



clientes: 15 registros con información de los compradores.



productos: 12 registros con información del catálogo.



pedidos: 30 registros de operaciones comerciales.



Las tablas se relacionan mediante identificadores de clientes y productos, utilizando claves primarias y foráneas.





## 5. Limpieza y validación de datos



Antes de realizar el análisis se verificaron los valores nulos en columnas críticas, los tipos de datos y la coherencia de las fechas.



Se identificó un precio faltante en la tabla productos y otro en la tabla pedidos, correspondientes al mismo producto.



Se aplicó COALESCE para utilizar el precio del catálogo cuando no estuviera disponible el precio del pedido.



Cuando ambos valores eran desconocidos, se mantuvo NULL para evitar asignar un ingreso ficticio.



Por este motivo, los análisis monetarios consideran 29 pedidos con precios conocidos, mientras que los análisis de cantidades pueden incluir los 30 pedidos.



También se verificó que las fechas utilizaran el tipo DATE, los precios el tipo NUMERIC y que no existieran pedidos anteriores a la fecha de registro de sus clientes.





## 6. Resultados del análisis



**###6.1.** Top 5 clientes por gasto total



Lucía Fernández fue la clienta con mayor gasto registrado, alcanzando $1.695.000 en cuatro pedidos valorizados.



Camila López ocupó el segundo lugar con $1.170.000 en dos pedidos.



Este resultado permite distinguir entre clientes de mayor frecuencia de compra y clientes con operaciones de mayor valor, ofreciendo oportunidades para desarrollar estrategias de fidelización diferenciadas.





###6.2. Evolución de ventas mensuales



La facturación total conocida entre enero y junio de 2026 fue de $7.181.000.



Abril registró la mayor facturación, con $2.035.000, mientras que mayo presentó el menor ingreso, con $621.000.



Marzo registró seis pedidos valorizados y abril cinco, pero abril generó más ingresos. Esto demuestra que la cantidad de pedidos no determina por sí sola la facturación.





###6.3. Productos menos vendidos



Los productos con menor volumen de ventas fueron:



Webcam Logitech: 1 unidad.



Funda para Tablet: 1 unidad.



Notebook Lenovo: 2 unidades.



Estos resultados permiten identificar productos de baja rotación y posibles oportunidades de promoción.



Sin embargo, es importante considerar el valor económico de cada producto antes de tomar decisiones comerciales.





###6.4. Ranking de pedidos por categoría



Se utilizó la función de ventana RANK() para ordenar los pedidos según su importe dentro de cada categoría.



En Accesorios, cuatro pedidos compartieron el primer puesto con un importe de $75.000 cada uno.



Este resultado demuestra que diferentes combinaciones de productos y cantidades pueden generar un mismo valor de venta.





###6.5. Ingresos por categoría



Computación fue la categoría con mayor facturación, alcanzando $2.900.000, seguida por Celulares con $2.600.000.



Ambas categorías concentraron aproximadamente el 76,6% de los ingresos conocidos.



Accesorios registró un mayor volumen de unidades vendidas, pero una facturación inferior, evidenciando la importancia del precio de los productos en los ingresos del negocio.




###6.6. Clientes recurrentes



Se identificaron nueve clientes con más de un pedido.



Lucía Fernández registró cinco pedidos en total, de los cuales cuatro tenían un importe conocido, acumulando $1.695.000.



El análisis permite reconocer clientes recurrentes y estudiar su contribución económica, diferenciando la frecuencia de compra del gasto total conocido.





## 7. Conclusiones y recomendaciones



El análisis permitió identificar oportunidades comerciales relevantes:



Desarrollar estrategias de fidelización para los clientes de mayor valor y frecuencia.



Investigar las variaciones mensuales de facturación para comprender posibles factores comerciales o estacionales.



Evaluar promociones para productos de baja rotación, considerando también su rentabilidad.



Priorizar el seguimiento de las categorías Computación y Celulares por su elevada participación en los ingresos.



Mejorar los controles de calidad de datos para evitar registros comerciales con precios faltantes.



Los resultados corresponden a un dataset ficticio y deben interpretarse como un ejercicio de análisis, no como evidencia de comportamiento real del mercado.





## 8. Instrucciones de ejecución



Para reproducir el proyecto:



Tener PostgreSQL instalado y una herramienta de ejecución SQL, como DBeaver.



Crear una base de datos denominada capstone\_project mediante la instrucción CREATE DATABASE capstone\_project;.



Conectarse a la nueva base de datos.



Ejecutar estructura.sql para crear las tablas e insertar los registros.



Ejecutar analisis.sql para realizar las validaciones, limpieza y consultas comerciales.



Revisar los resultados y conclusiones del análisis.



Los scripts están diseñados para ejecutarse sobre una base de datos nueva, sin las tablas del proyecto previamente creadas.





## 9. Archivos del repositorio



estructura.sql: creación de tablas y carga de datos.



analisis.sql: consultas de limpieza, validación y análisis.



README.md: documentación, resultados y conclusiones del proyecto.





## 10. Alcance y limitaciones



El análisis se realizó sobre una muestra simulada de 15 clientes, 12 productos y 30 pedidos.



Los ingresos se calcularon utilizando los precios registrados en cada pedido o, cuando correspondiera, los precios disponibles en el catálogo.



Un pedido carecía de información suficiente para calcular su importe y fue excluido de los análisis monetarios.



Por tratarse de un dataset ficticio y de tamaño reducido, las conclusiones tienen fines académicos y no permiten realizar generalizaciones sobre el comportamiento de un mercado real.




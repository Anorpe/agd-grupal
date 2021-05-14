/*Consultas de olist_geolocation*/

    /*Conteo cantidad total de registros*/
    SELECT COUNT(*)
    FROM olist_geolocation;

    /*Conteo cantidad total de estados diferentes*/
    SELECT COUNT(*)
    FROM (
        SELECT DISTINCT geolocation_state
        FROM olist_geolocation
    );

    /*Conteo cantidad total de registros por ciudad*/
    SELECT geolocation_city,
    COUNT(*)
    FROM olist_geolocation 
    GROUP BY geolocation_city;

    /*Conteo cantidad total de registros por estado*/
    SELECT geolocation_state,
    COUNT(*)
    FROM olist_geolocation 
    GROUP BY geolocation_state;

    /*Ciudad con mayor numero de registros*/
    SELECT geolocation_city, 
    MAX(cnt)
    FROM (
        SELECT geolocation_city,
        COUNT(geolocation_city) AS cnt
        FROM olist_geolocation
        GROUP BY geolocation_city
    );

    /*Ciudad con menor numero de registros*/
    SELECT geolocation_city, 
    MIN(cnt)
    FROM (
        SELECT geolocation_city,
        COUNT(geolocation_city) AS cnt
        FROM olist_geolocation
        GROUP BY geolocation_city
    );

    /*Estado con mayor numero de registros*/
    SELECT geolocation_state, 
    MAX(cnt)
    FROM (
        SELECT geolocation_state,
        COUNT(geolocation_state) AS cnt
        FROM olist_geolocation
        GROUP BY geolocation_state
    );

    /*Ciudad con menor numero de registros*/
    SELECT geolocation_state, 
    MIN(cnt)
    FROM (
        SELECT geolocation_state,
        COUNT(geolocation_state) AS cnt
        FROM olist_geolocation
        GROUP BY geolocation_state
    );

    /*Numero promedio de registros por ciudad*/
    SELECT AVG(cnt)
    FROM (
        SELECT geolocation_city,
        COUNT(geolocation_city) AS cnt
        FROM olist_geolocation
        GROUP BY geolocation_city
    );

    /*Numero promedio de registros por estado*/
    SELECT AVG(cnt)
    FROM (
        SELECT geolocation_state,
        COUNT(geolocation_state) AS cnt
        FROM olist_geolocation
        GROUP BY geolocation_state
    );

/* Consultas de olist_customers */

    /* Cantidad total de registros */
    SELECT COUNT(customer_id) AS total_registros
    FROM olist_customers;

    /* Cantidad de clientes registrados por código postal */
    SELECT customer_zip_code_prefix, COUNT(customer_unique_id)
    FROM olist_customers
    GROUP BY customer_zip_code_prefix;

    /* Código postal en donde hay la mayor cantidad de clientes registrados */
    SELECT customer_zip_code_prefix, MAX(cnt)
    FROM (
        SELECT customer_zip_code_prefix, COUNT(customer_unique_id) AS cnt
        FROM olist_customers
        GROUP BY customer_zip_code_prefix
    );

    /* Código postal en donde hay la menor cantidad de clientes registrados */
    SELECT customer_zip_code_prefix, MIN(cnt)
    FROM (
        SELECT customer_zip_code_prefix, COUNT(customer_unique_id) AS cnt
        FROM olist_customers
        GROUP BY customer_zip_code_prefix
    );

/* Consultas de olist_sellers */

    /* Cantidad total de vendedores registrados */
    SELECT COUNT(seller_id) AS total_registros
    FROM olist_sellers;

    /* Cantidad de vendedores registrados por código postal */
    SELECT seller_zip_code_prefix, COUNT(seller_id)
    FROM olist_sellers
    GROUP BY seller_zip_code_prefix;

    /* Código postal en donde hay la mayor cantidad de vendedores registrados */
    SELECT seller_zip_code_prefix, MAX(cnt)
    FROM (
        SELECT seller_zip_code_prefix, COUNT(seller_id) AS cnt
        FROM olist_sellers
        GROUP BY seller_zip_code_prefix
    );

    /* Código postal en donde hay la menor cantidad de clientes registrados */
    SELECT seller_zip_code_prefix, MIN(cnt)
    FROM (
        SELECT seller_zip_code_prefix, COUNT(seller_id) AS cnt
        FROM olist_sellers
        GROUP BY seller_zip_code_prefix
    );

/*Consultas de olist_orders*/

    /* Cantidad total de registros */
    SELECT COUNT(*)
    FROM olist_orders;

    /* Número de pedidos realizados por un cliente */
    SELECT customer_unique_id, COUNT(order_id)
    FROM olist_orders AS orders
    INNER JOIN olist_customers AS customers ON (orders.customer_id = customers.customer_id)
    GROUP BY customer_unique_id;

    /* Mayor cantidad de pedidos realizados por un cliente */
    SELECT customer_unique_id, MAX(cnt)
    FROM (
        SELECT customer_unique_id, COUNT(order_id) AS cnt
        FROM olist_orders AS orders
        INNER JOIN olist_customers AS customers ON (orders.customer_id = customers.customer_id)
        GROUP BY customer_unique_id
    );

    /* Menor cantidad de pedidos realizados por un cliente */
    SELECT customer_unique_id, MAX(cnt)
    FROM (
        SELECT customer_unique_id, COUNT(order_id) AS cnt
        FROM olist_orders AS orders
        INNER JOIN olist_customers AS customers ON (orders.customer_id = customers.customer_id)
        GROUP BY customer_unique_id
    );

    /* Número de pedidos que se encuentran en cada uno de los estados existentes */
    SELECT order_status, COUNT(order_id)
    FROM olist_orders
    GROUP BY order_status;

    /* El estado de pedido que tiene asociado la mayor cantidad de registros */
    SELECT order_status, MAX(cnt)
    FROM (
        SELECT order_status, COUNT(order_id) AS cnt
        FROM olist_orders
        GROUP BY order_status
    );

    /* El estado de pedido que tiene asociado la menor cantidad de registros */
    SELECT order_status, MIN(cnt)
    FROM (
        SELECT order_status, COUNT(order_id) AS cnt
        FROM olist_orders
        GROUP BY order_status
    );

    /* Promedio de tiempo (en días) que demora un pedido en ser entregado  a un cliente desde su compra por la plataforma */
    SELECT AVG(DAYSDIFF)
    FROM (
    SELECT 
        order_id, order_purchase_timestamp, order_delivered_customer_date, 
        CAST( (julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)) AS INTEGER) AS DAYSDIFF
    FROM olist_orders
    WHERE order_purchase_timestamp NOT NULL AND order_delivered_customer_date NOT NULL
    );

    /* Mayor tiempo en días que demoró un pedido en ser entregado a un cliente desde su compra por la plataforma */
    SELECT order_id, MAX(DAYSDIFF)
    FROM (
    SELECT 
        order_id, order_purchase_timestamp, order_delivered_customer_date, 
        CAST( (julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)) AS INTEGER) AS DAYSDIFF
    FROM olist_orders
    WHERE order_purchase_timestamp NOT NULL AND order_delivered_customer_date NOT NULL
    );

    /* Menor tiempo en días que demoró un pedido en ser entregado a un cliente desde su compra por la plataforma */
    SELECT order_id, MIN(DAYSDIFF)
    FROM (
    SELECT 
        order_id, order_purchase_timestamp, order_delivered_customer_date, 
        CAST( (julianday(order_delivered_customer_date) - julianday(order_purchase_timestamp)) AS INTEGER) AS DAYSDIFF
    FROM olist_orders
    WHERE order_purchase_timestamp NOT NULL AND order_delivered_customer_date NOT NULL
    );

    /* Promedio de tiempo (en días) que demora un pedido en ser entregado después de pasar la fecha estimada de entrega */
    SELECT AVG(DAYSDIFF)
    FROM (
    SELECT 
        order_id, order_estimated_delivery_date, order_delivered_customer_date, 
        CAST( (julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date)) AS INTEGER) AS DAYSDIFF
    FROM olist_orders
    WHERE 
        order_estimated_delivery_date NOT NULL AND 
        order_delivered_customer_date NOT NULL AND
        order_estimated_delivery_date < order_delivered_customer_date
    );

    /* Mayor tiempo en días que demoró un pedido en ser entregado después de pasar la fecha estimada de entrega */
    SELECT order_id, MAX(DAYSDIFF)
    FROM (
    SELECT 
        order_id, order_estimated_delivery_date, order_delivered_customer_date, 
        CAST( (julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date)) AS INTEGER) AS DAYSDIFF
    FROM olist_orders
    WHERE 
        order_estimated_delivery_date NOT NULL AND 
        order_delivered_customer_date NOT NULL AND
        order_estimated_delivery_date < order_delivered_customer_date
    );

    /* Menor tiempo en días que demoró un pedido en ser entregado después de pasar la fecha estimada de entrega */
    SELECT order_id, MIN(DAYSDIFF)
    FROM (
    SELECT 
        order_id, order_estimated_delivery_date, order_delivered_customer_date, 
        CAST( (julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date)) AS INTEGER) AS DAYSDIFF
    FROM olist_orders
    WHERE 
        order_estimated_delivery_date NOT NULL AND 
        order_delivered_customer_date NOT NULL AND
        order_estimated_delivery_date < order_delivered_customer_date
    );

    /* Promedio de tiempo en días que demora un pedido en ser entregado después de ser enviado al socio logístico */
    SELECT AVG(DAYSDIFF)
    FROM (
    SELECT 
        order_id, order_delivered_carrier_date, order_delivered_customer_date, 
        CAST( (julianday(order_delivered_customer_date) - julianday(order_delivered_carrier_date)) AS INTEGER) AS DAYSDIFF
    FROM olist_orders
    WHERE 
        order_delivered_carrier_date NOT NULL AND 
        order_delivered_customer_date NOT NULL AND
        order_delivered_carrier_date < order_delivered_customer_date
    );

/*Consultas de olist_order_reviews JULIAN*/
    /* Cantidad total de reseñas registradas  */
    SELECT COUNT(*)
    FROM olist_order_reviews;

/*Consultas de olist_order_payments JULIAN*/
    /* Cantidad total de pagos registrados  */
    SELECT COUNT(*)
    FROM olist_order_payments;

/* Consultas de olist_products */

    /* Cantidad total de productos registrados */
    SELECT COUNT(*)
    FROM olist_products;

    /* Cantidad total de productos segun su categoria */
    SELECT product_category_name,
    COUNT(*)
    FROM olist_products
    GROUP BY product_category_name;

    /* Producto con mayor cantidad de fotos */
    SELECT product_id,
    MAX(cnt)
    FROM (
        SELECT product_id,
        MAX(product_photos_qty) AS cnt
        FROM olist_products
    );

    /* Promedio de la cantidad de fotos por producto */
    SELECT AVG(product_photos_qty)
    FROM olist_products;

    /* Producto mas pesado */
    SELECT product_id,
    MAX(cnt)
    FROM (
        SELECT product_id,
        MAX(product_weight_g) AS cnt
        FROM olist_products
    );

    /* Producto mas liviano */
    SELECT product_id,
    MIN(cnt)
    FROM (
        SELECT product_id,
        MIN(product_weight_g) AS cnt
        FROM olist_products
    );

    /* Peso promedio de los productos */
    SELECT AVG(product_weight_g)
    FROM olist_products;

    /* Producto mas largo */
    SELECT product_id,
    MAX(cnt)
    FROM (
        SELECT product_id,
        MAX(product_length_cm) AS cnt
        FROM olist_products
    ); 

    /* Producto menos largo */
    SELECT product_id,
    MIN(cnt)
    FROM (
        SELECT product_id,
        MIN(product_length_cm) AS cnt
        FROM olist_products
    );

    /* Largo promedio de los productos */
    SELECT AVG(product_length_cm)
    FROM olist_products;

    /* Producto mas alto */
    SELECT product_id,
    MAX(cnt)
    FROM (
        SELECT product_id,
        MAX(product_height_cm) AS cnt
        FROM olist_products
    ); 

    /* Producto menos alto */
    SELECT product_id,
    MIN(cnt)
    FROM (
        SELECT product_id,
        MIN(product_height_cm) AS cnt
        FROM olist_products
    );

    /* Altura promedio de los productos */
    SELECT AVG(product_height_cm)
    FROM olist_products;

    /* Producto mas ancho */
    SELECT product_id,
    MAX(cnt)
    FROM (
        SELECT product_id,
        MAX(product_width_cm) AS cnt
        FROM olist_products
    ); 

    /* Producto menos ancho */
    SELECT product_id,
    MIN(cnt)
    FROM (
        SELECT product_id,
        MIN(product_width_cm) AS cnt
        FROM olist_products
    );

    /* Anchura promedio de los productos */
    SELECT AVG(product_width_cm)
    FROM olist_products;


/* Consultas de olist_order_items */

    /* Cantidad total de order items registrados  */
    SELECT COUNT(*)
    FROM olist_order_items;

    /* Orden con mayor cantidad de productos */
    SELECT order_id,
    MAX(cnt)
    FROM (
        SELECT order_id,
        MAX(order_item_id) AS cnt
        FROM olist_order_items
    );

    /* Numero promedio de productos por orden */
    SELECT AVG(order_item_id)
    FROM olist_order_items;

    /* Producto mas vendido dentro de las ordenes */
    SELECT product_id,
    MAX(cnt)
    FROM (
        SELECT product_id,
        COUNT(product_id) AS cnt
        FROM olist_order_items
    );

    /* Número promedio de productos por orden */
    SELECT AVG(cnt)
    FROM (
        SELECT order_id,
        COUNT(product_id) AS cnt
        FROM olist_order_items
        GROUP BY order_id
    );

    /* Numero total de vendedores con al menos 1 venta */
    SELECT COUNT(*)
    FROM (
        SELECT DISTINCT seller_id
        FROM olist_order_items
    );

    /* Numero total de productos distintos */
    SELECT COUNT(*)
    FROM (
        SELECT DISTINCT product_id
        FROM olist_order_items
    );

    /* Vendedor con mayor numero de productos vendidos y cantidad de productos vendidos */
    SELECT seller_id,
    MAX(cnt)
    FROM (
        SELECT seller_id,
        COUNT(product_id) AS cnt
        FROM olist_order_items
        GROUP BY seller_id
    );

    /* Vendedor con menor numero de ordenes y cantidad de ordenes asociadas */
    SELECT seller_id,
    MIN(cnt)
    FROM (
        SELECT seller_id,
        COUNT(product_id) AS cnt
        FROM olist_order_items
        GROUP BY seller_id
    );

    /* Numero promedio de productos que vende cada vendedor */
    SELECT AVG(cnt)
    FROM (
        SELECT seller_id,
        COUNT(product_id) AS cnt
        FROM olist_order_items
        GROUP BY seller_id
    );

    /* Producto mas costoso y id asociado */
    SELECT product_id,
    MAX(cnt)
    FROM (
        SELECT product_id,
        MAX(price) AS cnt
        FROM olist_order_items
    );

    /* Producto mas barato y id asociado */
    SELECT product_id,
    MIN(cnt)
    FROM (
        SELECT product_id,
        MIN(price) AS cnt
        FROM olist_order_items
    );

    /* Precio promedio de los productos */
    SELECT AVG(price)
    FROM olist_order_items;

    /* Costo de envío mas alto y orden asociada */
    SELECT product_id,
    MAX(cnt)
    FROM (
        SELECT product_id,
        MAX(freight_value) AS cnt
        FROM olist_order_items
    );

    /* Costo de envío mas bajo y orden asociada */
    SELECT product_id,
    MIN(cnt)
    FROM (
        SELECT product_id,
        MIN(freight_value) AS cnt
        FROM olist_order_items
    );

    /* Costo promedio de envío de los productos */
    SELECT AVG(freight_value)
    FROM olist_order_items;

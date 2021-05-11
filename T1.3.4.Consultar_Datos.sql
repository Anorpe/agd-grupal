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

    /* Código postal en donde hay la mayor cantidad de clientes registrados */
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

/*Consultas de olist_order_payments JULIAN*/

/*Consultas de olist_products DIEGO*/

/*Consultas de olist_order_items DIEGO*/
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

/*Consultas de olist_customers CAMILO*/

/*Consultas de olist_sellers CAMILO*/

/*Consultas de olist_orders CAMILO*/

/*Consultas de olist_order_reviews JULIAN*/

/*Consultas de olist_order_payments JULIAN*/

/*Consultas de olist_products DIEGO*/

/*Consultas de olist_order_items DIEGO*/
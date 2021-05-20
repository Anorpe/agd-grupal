/* Consultas de olist_geolocation */

/* Consultas de olist_customers */
    /* Cantidad total de registros */
    db.olist_customers_dataset.count();

    /* Cantidad de clientes registrados por código postal */
    db.olist_customers_dataset.aggregate([{
        "$group" : {
            "_id" : { "customer_zip_code_prefix" : "$customer_zip_code_prefix" },
            "cnt" : { "$sum" : 1 }
        }
    }]);

    /* Código postal en donde hay la mayor cantidad de clientes registrados */
    db.olist_customers_dataset.aggregate([
        {"$group":{_id:"$customer_zip_code_prefix",count:{$sum:1}}},
        {"$group":
            {
                _id:null,
                mayor:{'$max':'$count'}
            }
        }            
    ]);

    /* Código postal en donde hay la menor cantidad de clientes registrados */
    db.olist_customers_dataset.aggregate([
        {"$group":{_id:"$customer_zip_code_prefix",count:{$sum:1}}},
        {"$group":
            {
                _id:null,
                menor:{'$min':'$count'}
            }
        }            
    ]);

/* Consultas de olist_sellers */

    /* Cantidad total de vendedores registrados */
    db.olist_sellers_dataset.count();

    /* Cantidad de vendedores registrados por código postal */
    db.olist_sellers_dataset.aggregate([{
        "$group" : {
            "_id" : { "seller_zip_code_prefix" : "$seller_zip_code_prefix" },
            "cnt" : { "$sum" : 1 }
        }
    }]);

    /* Código postal en donde hay la mayor cantidad de vendedores registrados */
    db.olist_sellers_dataset.aggregate([
        {"$group":{_id:"$seller_zip_code_prefix",count:{$sum:1}}},
        {"$group":
            {
                _id:null,
                mayor:{'$max':'$count'}
            }
        }
    ]);

    /* Código postal en donde hay la menor cantidad de clientes registrados */
    db.olist_sellers_dataset.aggregate([
        {"$group":{_id:"$seller_zip_code_prefix",count:{$sum:1}}},
        {"$group":
            {
                _id:null,
                menor:{'$min':'$count'}
            }
        }
    ]);

/* Consultas de olist_orders */

    /* Cantidad total de registros */
    db.olist_orders_dataset.count();

    /* Número de pedidos realizados por un cliente */
    SELECT customer_unique_id, COUNT(order_id)
    FROM olist_orders AS orders
    INNER JOIN olist_customers AS customers ON (orders.customer_id = customers.customer_id)
    GROUP BY customer_unique_id;

    db.olist_orders_dataset.aggregate([{
        $lookup : {
            from: "olist_customers_dataset",
            localField: "customer_id",
            foreignField: "customer_id",
            as: "Customers"
        }
    }]);

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

/* Consultas de olist_order_reviews */
    /* Cantidad total de reseñas registradas  
        /* db.olist_order_reviews_dataset.count()

    /* Cantidad total de registros segun su puntuacion en la reseña 
        /* db.olist_order_reviews_dataset.aggregate([{
            "$group" : {
                "_id" : {"secuencia": "$review_score"},
                "cantidad_registros" : {"$sum" : 1}
            }
        },{
        "$sort": {
            "cantidad_registros": 1}}]);

    /* Promedio de puntuacion de todas las reseñas 
        /* db.olist_order_reviews_dataset.aggregate([{$group: {_id: null, promedio: {$avg: "$review_score"}}}]);
    
    /* Cantidad de registros cuya puntuación es superior al promedio de puntuacion de la tabla
    Para efectos prácticos, se redondea el promedio al entero más cercano */

/* Consultas de olist_order_payments */
    /* Cantidad total de pagos registrados 
        /* db.olist_payments_dataset.count()

    /* Promedio de valor de todos los pagos realizados */
        /* db.olist_payments_dataset.aggregate([{$group: {_id: null, promedio: {$avg: "$payment_value"}}}]);

    /* Suma de los pagos realizados agrupados por su metodo de pago */
        /* db.olist_payments_dataset.aggregate([{
            "$group" : {
                "_id" : {"tipo_pago": "$payment_type"},
                "total_valores" : {"$sum" : "$payment_value"}
            }
        }]);

    /* Conteo de los pagos realizados agrupados por su metodo de pago */
        /* db.olist_payments_dataset.aggregate([{
            "$group" : {
                "_id" : {"tipo_pago": "$payment_type"},
                "cantidad_registros" : {"$sum" : 1}
            }
        }]);

    /* Total de registros agrupados por sus secuencias de pago */
        /* db.olist_payments_dataset.aggregate([{
            "$group" : {
                "_id" : {"secuencia": "$payment_sequential"},
                "cantidad_registros" : {"$sum" : 1}
            }
        },{
        "$sort": {
            "cantidad_registros": -1}}]);

    /* Promedio de las secuencias de pago de todos los pagos realizados */
        /* db.olist_payments_dataset.aggregate([{$group: {_id: null, promedio: {$avg: "$payment_sequential"}}}]);

    /* Orden y metodo de pago de la orden que posee el valor maximo */

    /* Orden que posee el mayor número de secuencias de pago */

    /* Promedio de cuotas de todos los pagos realizados */
        /* db.olist_payments_dataset.aggregate([{$group: {_id: null, promedio: {$avg: "$payment_installments"}}}]);

    /* Metodo de pago de las ordenes que posee el mayor número de cuotas */

/* Consultas de olist_products */

/* Consultas de olist_order_items */


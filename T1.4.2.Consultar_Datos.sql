/* Consultas de olist_geolocation */

    /*Conteo cantidad total de registros*/
   
    db.olist_geolocation_dataset.count();

    /*Conteo cantidad total de estados diferentes*/

    db.olist_geolocation_dataset.distinct('geolocation_state').length;

    /*Conteo cantidad total de registros por ciudad*/
   
    db.olist_geolocation_dataset.aggregate([{"$group":{_id:"$geolocation_city",count:{$sum:1}}}]);

    /*Conteo cantidad total de registros por estado*/

    db.olist_geolocation_dataset.aggregate([{"$group":{_id:"$geolocation_state",count:{$sum:1}}}]);
    

    /*Ciudad con mayor numero de registros*/

    db.olist_geolocation_dataset.aggregate([
        {"$group":{_id:"$geolocation_city",count:{$sum:1}}}
        ,
        {"$group":{_id:null,mayor:{'$max':'$count'}}}
    ]);

    /*Ciudad con menor numero de registros*/
 
    db.olist_geolocation_dataset.aggregate([
        {"$group":{_id:"$geolocation_city",count:{$sum:1}}}
        ,
        {"$group":{_id:null,menor:{'$min':'$count'}}}
    ]);

    /*Estado con mayor numero de registros*/

    db.olist_geolocation_dataset.aggregate([
        {"$group":{_id:"$geolocation_state",count:{$sum:1}}}
        ,
        {"$group":{_id:null,mayor:{'$max':'$count'}}}
    ]);

    /*Ciudad con menor numero de registros*/


    db.olist_geolocation_dataset.aggregate([
        {"$group":{_id:"$geolocation_state",count:{$sum:1}}}
        ,
        {"$group":{_id:null,menor:{'$min':'$count'}}}
    ]);

    /*Numero promedio de registros por ciudad*/
   

    db.olist_geolocation_dataset.aggregate([
        {"$group":{_id:"$geolocation_city",count:{$sum:1}}}
        ,
        {"$group":{_id:null,avg:{'$avg':'$count'}}}
    ]);

    /*Numero promedio de registros por estado*/
    

    db.olist_geolocation_dataset.aggregate([
        {"$group":{_id:"$geolocation_state",count:{$sum:1}}}
        ,
        {"$group":{_id:null,avg:{'$avg':'$count'}}}
    ]);


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
    /* Cantidad total de reseñas registradas */ 
        db.olist_order_reviews_dataset.count()

    /* Cantidad total de registros segun su puntuacion en la reseña */
        db.olist_order_reviews_dataset.aggregate([{
            "$group" : {
                "_id" : {"puntuacion": "$review_score"},
                "cantidad_registros" : {"$sum" : 1}
            }
        },{
        "$sort": {
            "cantidad_registros": -1}}]);

    /* Promedio de puntuacion de todas las reseñas */
        db.olist_order_reviews_dataset.aggregate([{
            $group: {_id: null, promedio: {$avg: "$review_score"}}
        }]);
    
/* Consultas de olist_order_payments */
    /* Cantidad total de pagos registrados */
        db.olist_payments_dataset.count()

    /* Promedio de valor de todos los pagos realizados */
        db.olist_payments_dataset.aggregate([{
            $group: {_id: null, promedio: {$avg: "$payment_value"}}
        }]);

    /* Suma de los pagos realizados agrupados por su metodo de pago */
        db.olist_payments_dataset.aggregate([{
            "$group" : {
                "_id" : {"tipo_pago": "$payment_type"},
                "total_valores" : {"$sum" : "$payment_value"}
            }
        }]);

    /* Conteo de los pagos realizados agrupados por su metodo de pago */
        db.olist_payments_dataset.aggregate([{
            "$group" : {
                "_id" : {"tipo_pago": "$payment_type"},
                "cantidad_registros" : {"$sum" : 1}
            }
        }]);

    /* Total de registros agrupados por sus secuencias de pago */
        db.olist_payments_dataset.aggregate([{
            "$group" : {
                "_id" : {"secuencia": "$payment_sequential"},
                "cantidad_registros" : {"$sum" : 1}
            }
        },{
        "$sort": {
            "cantidad_registros": -1}}]);

    /* Promedio de las secuencias de pago de todos los pagos realizados */
        db.olist_payments_dataset.aggregate([{
            $group: {_id: null, promedio: {$avg: "$payment_sequential"}}
        }]);

    /* Promedio de cuotas de todos los pagos realizados */
        db.olist_payments_dataset.aggregate([{
            $group: {_id: null, promedio: {$avg: "$payment_installments"}}
        }]);

/* Consultas de olist_products */

    /* Cantidad total de productos registrados */
    db.olist_products_dataset.count();

    /* Cantidad total de productos segun su categoria */
    db.olist_products_dataset.aggregate([
        { "$group":
            { "_id" : {"product_category_name" : "$product_category_name" },
            "cnt" : { "$sum" : 1 } } 
        }
    ]);

    /* Mayor cantidad de fotos en un producto */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:"$product_photos_qty",count:{$max:"$product_photos_qty"}
            }
        },
        {"$group":
            {
                _id:null,
                mayor:{'$max':'$count'}
            }
        }
    ]);

    /* Promedio de la cantidad de fotos por producto */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:null, count:{$avg:"$product_photos_qty"}
            }
        }
    ]);

    /* Peso mayor de un producto */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:"$product_weight_g",count:{$max:"$product_weight_g"}
            }
        },
        {"$group":
            {
                _id:null,
                peso_mayor:{'$max':'$count'}
            }
        }
    ]);

    /* Peso menor de un producto */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:"$product_weight_g",count:{$min:"$product_weight_g"}
            }
        },
        {"$group":
            {
                _id:null,
                peso_menor:{'$min':'$count'}
            }
        }
    ]);

    /* Peso promedio de los productos (en gramos) */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:null, peso_promedio:{$avg:"$product_weight_g"}
            }
        }
    ]); 

    /* Longitud mayor de un producto (en cm) */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:"$product_length_cm",count:{$max:"$product_length_cm"}
            }
        },
        {"$group":
            {
                _id:null,
                longitud_mayor:{'$max':'$count'}
            }
        }
    ]);

    /* Longitud menor de un producto (en cm) */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:"$product_length_cm",count:{$min:"$product_length_cm"}
            }
        },
        {"$group":
            {
                _id:null,
                longitud_menor:{'$min':'$count'}
            }
        }
    ]);

    /* Longitud promedio de un producto (en cm) */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:null, longitud_promedio:{$avg:"$product_length_cm"}
            }
        }
    ]);

    /* Altura mayor de un producto (en cm) */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:"$product_height_cm",count:{$max:"$product_height_cm"}
            }
        },
        {"$group":
            {
                _id:null,
                Altura_mayor:{'$max':'$count'}
            }
        }
    ]);

    /* Altura menor de un producto (en cm) */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:"$product_height_cm",count:{$min:"$product_height_cm"}
            }
        },
        {"$group":
            {
                _id:null,
                Altura_menor:{'$min':'$count'}
            }
        }
    ]);

    /* Altura promedio de un producto (en cm) */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:null, Altura_promedio:{$avg:"$product_height_cm"}
            }
        }
    ]);

    /* Anchura mayor de un producto (en cm) */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:"$product_width_cm",count:{$max:"$product_width_cm"}
            }
        },
        {"$group":
            {
                _id:null,
                Anchura_mayor:{'$max':'$count'}
            }
        }
    ]);

    /* Anchura menor de un producto (en cm) */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:"$product_width_cm",count:{$min:"$product_width_cm"}
            }
        },
        {"$group":
            {
                _id:null,
                Anchura_menor:{'$min':'$count'}
            }
        }
    ]);

    /* Anchura promedio de un producto (en cm) */
    db.olist_products_dataset.aggregate([
        {"$group": 
            {
                _id:null, Anchura_promedio:{$avg:"$product_width_cm"}
            }
        }
    ]);

/* Consultas de olist_order_items */


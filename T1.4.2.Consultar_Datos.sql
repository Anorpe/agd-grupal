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


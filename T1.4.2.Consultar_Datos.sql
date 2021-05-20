/* Consultas de olist_geolocation */

/* Consultas de olist_customers */

/* Consultas de olist_sellers */

/* Consultas de olist_orders */

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

/* Consultas de olist_order_items */


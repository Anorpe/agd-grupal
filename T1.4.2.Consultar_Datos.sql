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

    /* Número de pedidos que se encuentran en cada uno de los estados existentes */
    db.olist_orders_dataset.aggregate([
        { "$group":
            { "_id" : {"order_status" : "$order_status" },
            "cnt" : { "$sum" : 1 } } 
        }
    ]);

    /* Mayor cantidad de registros en un estado de pedido */
    db.olist_orders_dataset.aggregate([
        {"$group":{_id:"$order_status",count:{$sum:1}}},
        {"$group":
            {
                _id:null,
                mayor:{'$max':'$count'}
            }
        }            
    ]);

    /* Menor cantidad de registros en un estado de pedido */
    db.olist_orders_dataset.aggregate([
        {"$group":{_id:"$order_status",count:{$sum:1}}},
        {"$group":
            {
                _id:null,
                menor:{'$min':'$count'}
            }
        }            
    ]);

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

    /* Cantidad total de order items registrados  */
  

    db.olist_order_items_dataset.count();

    /* Orden con mayor cantidad de productos */
  

    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:"$order_id",max:{$max:"$order_item_id"}}}
        ,
        {"$group":{_id:null,mayor:{'$max':'$max'}}}
    ]);

    /* Numero promedio de productos por orden */
   

    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:null,avg:{$avg:"$order_item_id"}}}
        
    ]);

    /* Producto mas vendido dentro de las ordenes */
  

    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:"$product_id",count:{$sum:1}}}
        ,
        {"$group":{_id:null,mayor:{'$max':'$count'}}}
    ]);

    /* Número promedio de productos por orden */
 

    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:"$order_id",count:{$sum:1}}}
        ,
        {"$group":{_id:null,avg:{'$avg':'$count'}}}
    ]);

    /* Numero total de vendedores con al menos 1 venta */
 

    db.olist_order_items_dataset.distinct('seller_id').length;

    /* Numero total de productos distintos */


    db.olist_order_items_dataset.distinct('product_id').length;

    /* Vendedor con mayor numero de productos vendidos y cantidad de productos vendidos */
 
    

    /* Vendedor con menor numero de ordenes y cantidad de ordenes asociadas */
  

    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:"$seller_id",count:{$sum:1}}}
        ,
        {"$group":{_id:null,min:{'$min':'$count'}}}
    ]);

    /* Numero promedio de productos que vende cada vendedor */


    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:"$seller_id",count:{$sum:1}}}
        ,
        {"$group":{_id:null,avg:{'$avg':'$count'}}}
    ]);

    /* Producto mas costoso y id asociado */

    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:"$product_id",max:{$max:"$price"}}}
        ,
        {"$group":{_id:null,max:{'$max':'$max'}}}
    ]);

    /* Producto mas barato y id asociado */

    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:"$product_id",max:{$min:"$price"}}}
        ,
        {"$group":{_id:null,min :{'$min':'$max'}}}
    ]);

    /* Precio promedio de los productos */


    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:null,avg:{$avg:"$price"}}}
        
    ]);

    /* Costo de envío mas alto y orden asociada */


    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:"$product_id",max:{$max:"$freight_value"}}}
        ,
        {"$group":{_id:null,max :{'$max':'$max'}}}
    ]);


    /* Costo de envío mas bajo y orden asociada */

    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:"$product_id",max:{$min:"$freight_value"}}}
        ,
        {"$group":{_id:null,min :{'$min':'$max'}}}
    ]);

    /* Costo promedio de envío de los productos */

    db.olist_order_items_dataset.aggregate([
        {"$group":{_id:null,avg:{$avg:"$freight_value"}}}
        
    ]);



/* Consultas de olist_geolocation */

/* Consultas de olist_customers */

/* Consultas de olist_sellers */

/* Consultas de olist_orders */

/* Consultas de olist_order_reviews */

/* Consultas de olist_order_payments */

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


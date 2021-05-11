CREATE TABLE IF NOT EXISTS `olist_geolocation` (
  `geolocation_zip_code_prefix` INT(11) NOT NULL,
  `geolocation_lat` FLOAT NOT NULL,
  `geolocation_lng` FLOAT NOT NULL,
  `geolocation_city` VARCHAR(100)  NOT NULL,
  `geolocation_state` CHAR(2) NOT NULL,
  PRIMARY KEY (`geolocation_zip_code_prefix`)
);

CREATE TABLE IF NOT EXISTS `olist_sellers` (
  `seller_id` VARCHAR(100)  NOT NULL,
  `seller_zip_code_prefix` INT(11) NOT NULL,
  PRIMARY KEY (`seller_id`, `seller_zip_code_prefix`),
  FOREIGN KEY (`seller_zip_code_prefix`)
  REFERENCES `olist_geolocation` (`geolocation_zip_code_prefix`)
);

CREATE TABLE IF NOT EXISTS `olist_customers` (
  `customer_id` VARCHAR(100)  NOT NULL,
  `customer_unique_id` VARCHAR(100)  NOT NULL,
  `customer_zip_code_prefix` INT(11) NOT NULL,
  PRIMARY KEY (`customer_id`, `customer_zip_code_prefix`),
  FOREIGN KEY (`customer_zip_code_prefix`)
  REFERENCES `olist_geolocation` (`geolocation_zip_code_prefix`)
);

CREATE TABLE IF NOT EXISTS `olist_orders` (
  `order_id` VARCHAR(100)  NOT NULL,
  `order_status` VARCHAR(50)  NOT NULL,
  `order_purchase_timestamp` DATETIME,
  `order_approved_at` DATETIME,
  `order_delivered_carrier_date` DATETIME,
  `order_delivered_customer_date` DATETIME,
  `order_estimated_delivery_date` DATETIME,
  `customer_id` VARCHAR(100)  NOT NULL,
  PRIMARY KEY (`order_id`, `customer_id`)
);

CREATE TABLE IF NOT EXISTS `olist_products` (
  `product_id` VARCHAR(100)  NOT NULL,
  `product_category_name` VARCHAR(100),
  `product_name_lenght` INT(11),
  `product_description_lenght` INT(11),
  `product_photos_qty` INT(11),
  `product_weight_g` FLOAT,
  `product_length_cm` FLOAT,
  `product_height_cm` FLOAT,
  `product_width_cm` FLOAT,
  PRIMARY KEY (`product_id`)
);

CREATE TABLE IF NOT EXISTS `olist_order_payments` (
  `order_id` VARCHAR(100)  NOT NULL,
  `payment_sequential` INT(11) NOT NULL,
  `payment_type` VARCHAR(30)  NOT NULL,
  `payment_installments` INT(11) NOT NULL,
  `payment_value` FLOAT NOT NULL,
  PRIMARY KEY (`order_id`, `payment_sequential`),
  FOREIGN KEY (`order_id`)
  REFERENCES `olist_orders` (`order_id`)
);

CREATE TABLE IF NOT EXISTS `olist_order_reviews` (
  `review_id` VARCHAR(100)  NOT NULL,
  `review_score` INT(11) NOT NULL,
  `review_comment_title` VARCHAR(100),
  `review_comment_message` VARCHAR(100),
  `review_creation_date` DATETIME,
  `review_answer_timestamp` DATETIME,
  `order_id` VARCHAR(100)  NOT NULL,
  PRIMARY KEY (`review_id`),
  FOREIGN KEY (`order_id`)
  REFERENCES `olist_orders` (`order_id`)
);

CREATE TABLE IF NOT EXISTS `olist_order_items` (
  `order_item_id` INT(11) NOT NULL,
  `order_id` VARCHAR(100)  NOT NULL,
  `shipping_limit_date` DATETIME,
  `price` FLOAT NOT NULL,
  `freight_value` FLOAT NOT NULL,
  `product_id` VARCHAR(100)  NOT NULL,
  `seller_id` VARCHAR(100)  NOT NULL,
  PRIMARY KEY (`order_item_id`, `order_id`),
  FOREIGN KEY (`order_id`)
  REFERENCES `olist_orders` (`order_id`),
  FOREIGN KEY (`product_id`)
  REFERENCES `olist_products` (`product_id`),
  FOREIGN KEY (`seller_id`)
  REFERENCES `olist_sellers` (`seller_id`)
);
CREATE TABLE `olist_orders` (
  `order_id` NVarchar(100),
  `customer_id` NVarchar(100),
  `order_status` NVarchar(50),
  `order_purchase_timestamp` DATETIME,
  `order_approved_at` DATETIME,
  `order_delivered_carrier_date` DATETIME,
  `order_delivered_customer_date` DATETIME,
  `order_estimated_delivery_date` DATETIME,
  PRIMARY KEY (`order_id`)
);

CREATE TABLE `olist_products` (
  `product_id` NVarchar(100),
  `product_category_name` NVarchar(100),
  `product_name_lenght` int,
  `product_description_lenght` int,
  `product_photos_qty` int,
  `product_weight_g` float,
  `product_length_cm` float,
  `product_height_cm` float,
  `product_width_cm` float,
  PRIMARY KEY (`product_id`)
);

CREATE TABLE `olist_order_reviews` (
  `review_id` NVarchar(100),
  `order_id` NVarchar(100),
  `review_score` int,
  `review_comment_title` NVarchar(100),
  `review_comment_message` NVarchar(100),
  `review_creation_date` DATETIME,
  `review_answer_timestamp` DATETIME,
  PRIMARY KEY (`review_id`, `order_id`)
);

CREATE TABLE `olist_sellers` (
  `seller_id` NVarchar(100),
  `seller_zip_code_prefix` int,
  `seller_city` NVarchar(100),
  `seller_state` CHAR(2),
  PRIMARY KEY (`seller_id`)
);

CREATE TABLE `olist_customers` (
  `customer_id` NVarchar(100),
  `customer_unique_id` NVarchar(100),
  `customer_zip_code_prefix` int,
  `customer_city` NVarchar(100),
  `customer_state` CHAR(2),
  PRIMARY KEY (`customer_id`, `customer_unique_id`)
);

CREATE TABLE `olist_order_payments` (
  `order_id` NVarchar(100),
  `payment_sequential` int,
  `payment_type` NVarchar(30),
  `payment_installments` int,
  `payment_value` float,
  PRIMARY KEY (`order_id`, `payment_sequential`)
);

CREATE TABLE `olist_geolocation` (
  `geolocation_zip_code_prefix` int,
  `geolocation_lat` float,
  `geolocation_lng` float,
  `geolocation_city` NVarchar(100),
  `geolocation_state` CHAR(2),
  PRIMARY KEY (`geolocation_zip_code_prefix`)
);

CREATE TABLE `olist_order_items` (
  `order_item_id` int,
  `order_id` NVarchar(100),
  `product_id` NVarchar(100),
  `seller_id` NVarchar(100),
  `shipping_limit_date` DATETIME,
  `price` float,
  `freight_value` float,
  PRIMARY KEY (`order_item_id`)
);
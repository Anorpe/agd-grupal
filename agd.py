import sqlite3
from sqlite3 import Error

def sql_connection(db_name):

    try:
        con = sqlite3.connect(db_name)
        return con

    except Error:
        print(Error)

def create_table_with_data(tablename, con, createSentence, sqlDataFile):
    cursorOlist = con.cursor()
    cursorOlist.execute("DROP TABLE IF EXISTS %s;" % (tablename))
    cursorOlist.execute(createSentence).fetchall()
    con.commit()
    print(cursorOlist.execute("SELECT * FROM %s;" % (tablename)).fetchall())

    sql_file = open(sqlDataFile, errors='ignore')
    sql_as_string = sql_file.read()
    cursorOlist.executescript(sql_as_string)

    print(cursorOlist.execute("SELECT * FROM %s LIMIT 5;" % (tablename)).fetchall())

con = sql_connection('olist_database.db')

create_table_geolocation = """
CREATE TABLE IF NOT EXISTS `olist`.`olist_geolocation` (
  `geolocation_zip_code_prefix` INT(11) NOT NULL,
  `geolocation_lat` FLOAT NOT NULL,
  `geolocation_lng` FLOAT NOT NULL,
  `geolocation_city` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `geolocation_state` CHAR(2) NOT NULL,
  PRIMARY KEY (`geolocation_zip_code_prefix`)
);"""

create_table_sellers = """CREATE TABLE IF NOT EXISTS `olist`.`olist_sellers` (
  `seller_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `seller_zip_code_prefix` INT(11) NOT NULL,
  PRIMARY KEY (`seller_id`, `seller_zip_code_prefix`),
  FOREIGN KEY (`seller_zip_code_prefix`)
  REFERENCES `olist`.`olist_geolocation` (`geolocation_zip_code_prefix`)
);"""

create_table_customers = """CREATE TABLE IF NOT EXISTS `olist`.`olist_customers` (
  `customer_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `customer_unique_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `customer_zip_code_prefix` INT(11) NOT NULL,
  PRIMARY KEY (`customer_id`, `customer_zip_code_prefix`),
  FOREIGN KEY (`customer_zip_code_prefix`)
  REFERENCES `olist`.`olist_geolocation` (`geolocation_zip_code_prefix`)
);"""

create_table_orders = """
CREATE TABLE IF NOT EXISTS `olist`.`olist_orders` (
  `order_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `order_status` VARCHAR(50) CHARACTER SET 'utf8' NOT NULL,
  `order_purchase_timestamp` DATETIME NOT NULL,
  `order_approved_at` DATETIME NOT NULL,
  `order_delivered_carrier_date` DATETIME NOT NULL,
  `order_delivered_customer_date` DATETIME NOT NULL,
  `order_estimated_delivery_date` DATETIME NOT NULL,
  `customers_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`order_id`, `customers_id`),
);"""

create_table_products = """CREATE TABLE IF NOT EXISTS `olist`.`olist_products` (
  `product_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `product_category_name` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `product_name_lenght` INT(11) NOT NULL,
  `product_description_lenght` INT(11) NOT NULL,
  `product_photos_qty` INT(11) NOT NULL,
  `product_weight_g` FLOAT NOT NULL,
  `product_length_cm` FLOAT NOT NULL,
  `product_height_cm` FLOAT NOT NULL,
  `product_width_cm` FLOAT NOT NULL,
  PRIMARY KEY (`product_id`)
);"""

create_table_order_reviews = """CREATE TABLE IF NOT EXISTS `olist`.`olist_order_reviews` (
  `review_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `review_score` INT(11) NOT NULL,
  `review_comment_title` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `review_comment_message` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `review_creation_date` DATETIME NOT NULL,
  `review_answer_timestamp` DATETIME NOT NULL,
  `order_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`review_id`),
  FOREIGN KEY (`order_id`)
  REFERENCES `olist`.`olist_orders` (`order_id`)
);"""

create_table_order_payments = """CREATE TABLE IF NOT EXISTS `olist`.`olist_order_payments` (
  `order_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `payment_sequential` INT(11) NOT NULL,
  `payment_type` VARCHAR(30) CHARACTER SET 'utf8' NOT NULL,
  `payment_installments` INT(11) NOT NULL,
  `payment_value` FLOAT NOT NULL,
  PRIMARY KEY (`order_id`, `payment_sequential`),
  FOREIGN KEY (`order_id`)
  REFERENCES `olist`.`olist_orders` (`order_id`)
);"""

create_table_order_items = """CREATE TABLE IF NOT EXISTS `olist`.`olist_order_items` (
  `order_item_id` INT(11) NOT NULL,
  `order_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `shipping_limit_date` DATETIME NULL DEFAULT NULL,
  `price` FLOAT NULL DEFAULT NULL,
  `freight_value` FLOAT NULL DEFAULT NULL,
  `product_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  `seller_id` VARCHAR(100) CHARACTER SET 'utf8' NOT NULL,
  PRIMARY KEY (`order_item_id`, `order_id`),
  FOREIGN KEY (`order_id`)
  REFERENCES `olist`.`olist_orders` (`order_id`),
  FOREIGN KEY (`product_id`)
  REFERENCES `olist`.`olist_products` (`product_id`),
  FOREIGN KEY (`seller_id`)
  REFERENCES `olist`.`olist_sellers` (`seller_id`)
);"""

data = [
    #{'table': 'olist_geolocation', 'file': 'insert_olist_geolocation.sql', 'create': geolocation_table_sentence},
    #{'table': 'olist_sellers', 'file': 'insert_olist_sellers.sql', 'create': create_table_sellers},
    #{'table': 'olist_customers', 'file': 'insert_olist_customers.sql', 'create': create_table_customers},
    {'table': 'olist_orders', 'file': 'insert_olist_orders.sql', 'create': create_table_orders},
    #{'table': 'olist_order_payments', 'file': 'insert_olist_order_payments.sql', 'create': create_table_order_payments},
    #{'table': 'olist_order_reviews', 'file': 'insert_olist_order_reviews.sql', 'create': create_table_order_reviews},
    #{'table': 'olist_products', 'file': 'insert_olist_products.sql', 'create': create_table_products},
    #{'table': 'olist_order_items', 'file': 'insert_olist_order_items.sql', 'create': create_table_order_items},
]

for table in data:
    create_table_with_data(table['table'], con, table['create'], table['file'])
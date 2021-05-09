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

geolocation_table_sentence = """
CREATE TABLE `olist_geolocation` (
  `geolocation_zip_code_prefix` int,
  `geolocation_lat` float,
  `geolocation_lng` float,
  `geolocation_city` NVarchar(100),
  `geolocation_state` CHAR(2),
  PRIMARY KEY (`geolocation_zip_code_prefix`)
);"""

create_table_orders = """
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
);"""

create_table_products = """CREATE TABLE `olist_products` (
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
);"""

create_table_order_reviews = """CREATE TABLE `olist_order_reviews` (
  `review_id` NVarchar(100),
  `order_id` NVarchar(100),
  `review_score` int,
  `review_comment_title` NVarchar(100),
  `review_comment_message` NVarchar(100),
  `review_creation_date` DATETIME,
  `review_answer_timestamp` DATETIME,
  PRIMARY KEY (`review_id`, `order_id`)
);"""

create_table_sellers = """CREATE TABLE `olist_sellers` (
  `seller_id` NVarchar(100),
  `seller_zip_code_prefix` int,
  `seller_city` NVarchar(100),
  `seller_state` CHAR(2),
  PRIMARY KEY (`seller_id`)
);"""

create_table_customers = """CREATE TABLE `olist_customers` (
  `customer_id` NVarchar(100),
  `customer_unique_id` NVarchar(100),
  `customer_zip_code_prefix` int,
  `customer_city` NVarchar(100),
  `customer_state` CHAR(2),
  PRIMARY KEY (`customer_id`, `customer_unique_id`)
);"""

create_table_order_payments = """CREATE TABLE `olist_order_payments` (
  `order_id` NVarchar(100),
  `payment_sequential` int,
  `payment_type` NVarchar(30),
  `payment_installments` int,
  `payment_value` float,
  PRIMARY KEY (`order_id`, `payment_sequential`)
);"""

create_table_order_items = """CREATE TABLE `olist_order_items` (
  `order_item_id` int,
  `order_id` NVarchar(100),
  `product_id` NVarchar(100),
  `seller_id` NVarchar(100),
  `shipping_limit_date` DATETIME,
  `price` float,
  `freight_value` float,
  PRIMARY KEY (`order_item_id`, `order_id`)
);"""

data = [
    #{'table': 'olist_geolocation', 'file': 'insert_olist_geolocation.sql', 'create': geolocation_table_sentence},
    {'table': 'olist_orders', 'file': 'insert_olist_orders.sql', 'create': create_table_orders},
    #{'table': 'olist_sellers', 'file': 'insert_olist_sellers.sql', 'create': create_table_sellers},
    #{'table': 'olist_customers', 'file': 'insert_olist_customers.sql', 'create': create_table_customers},
    #{'table': 'olist_order_reviews', 'file': 'insert_olist_order_reviews.sql', 'create': create_table_order_reviews},
    #{'table': 'olist_order_payments', 'file': 'insert_olist_order_payments.sql', 'create': create_table_order_payments},
    #{'table': 'olist_products', 'file': 'insert_olist_products.sql', 'create': create_table_products},
    #{'table': 'olist_order_items', 'file': 'insert_olist_order_items.sql', 'create': create_table_order_items},
]

for table in data:
    create_table_with_data(table['table'], con, table['create'], table['file'])
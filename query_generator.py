"""
    Script de ayuda realizado para el trabajo de AGD
    Grupo: Camilo Laiton, Andres Orrego, Diego Naranjo, Juan Ardila, Julian Perez
"""

import pandas as pd
import numpy as np
import re
import unicodedata

def remove_accents(input_str, regular_expression):
    nfkd_form = unicodedata.normalize('NFKD', input_str)
    only_ascii = nfkd_form.encode('ASCII', 'ignore')
    returned_value = re.sub(regular_expression, '', only_ascii.decode("utf-8").rstrip('\n\r\.'))
    return returned_value

class CreateQueries():
    
    def __init__(self, tables, datatypes):
        self.tables = tables
        self.datatypes = datatypes

    def generateInsert(self, table_name, data_pd):
        value = ''
        columns = ''
        LIMIT = len(data_pd.index)
        RGEX = '[^A-Za-z0-9 ]+'
        print("Row number: ", LIMIT)

        with open('insert_' + table_name + '.sql', 'w') as insert:
            for row_index in range(LIMIT):
                if (row_index % 5000 == 0):
                    print("Processed Rows: ", row_index)

                acum = ''
                for key, datatype in self.tables[table_name].items():
                    if not row_index:
                        if not (len(columns)):
                            columns = "'%s'" % (key)
                        else:
                            columns = columns + ', ' + "'%s'" % (key)

                    default_value = data_pd.loc[row_index][key]
                    if (key == 'review_comment_message'):
                        default_value = remove_accents(data_pd.loc[row_index][key], RGEX)

                    if datatype in self.datatypes['sin_comilla'] or data_pd.loc[row_index][key] == 'NULL':
                        value = "%s" % (default_value)
                    else:
                        value = "'%s'" % (default_value)

                    if not (len(acum)):
                        acum = '(' + value
                    else:
                        acum = acum + ', ' + value
                
                acum = acum + ')'
                print('INSERT INTO %s (%s) VALUES %s;' % (table_name, columns, acum), file=insert)
        
        print("Consulta INSERT generada para la tabla ", table_name)

# Acá va el nombre de la tabla con el tipo de dato. Verificar que este en las listas del datatype
tables = {
    "olist_orders": {
        'order_id': 'nvarchar',
        'customer_id': 'nvarchar',
        'order_status': 'nvarchar',
        'order_purchase_timestamp': 'datetime',
        'order_approved_at': 'datetime',
        'order_delivered_carrier_date'  : 'datetime',
        'order_delivered_customer_date' : 'datetime',
        'order_estimated_delivery_date' : 'datetime'
    }, 
    "olist_sellers" : {
        "seller_id" : 'nvarchar',
        'seller_zip_code_prefix' : 'int',
    },
    "olist_geolocation": {
        'geolocation_zip_code_prefix' : 'int',
        'geolocation_lat' : 'float',
        'geolocation_lng' : 'flot',
        'geolocation_city' : 'nvarchar',
        'geolocation_state' : 'char'
    },
    "olist_customers" : {
        'customer_id' : 'nvarchar',
        'customer_unique_id' : 'nvarchar',
        'customer_zip_code_prefix' : 'int',
    },
    "olist_order_reviews" : {
        'review_id' : 'nvarchar',
        'order_id' : 'nvarchar',
        'review_score' : 'int',
        'review_comment_title' : 'nvarchar',
        'review_comment_message' : 'nvarchar',
        'review_creation_date' : 'datetime',
        'review_answer_timestamp' : 'datetime',
    },
    "olist_order_payments" : {
        'order_id' : 'nvarchar',
        'payment_sequential' : 'int',
        'payment_type' : 'nvarchar',
        'payment_installments' : 'int',
        'payment_value' : 'float',
    },
    "olist_products" : {
        'product_id' : 'nvarchar',
        'product_category_name' : 'nvarchar',
        'product_name_lenght' : 'int',
        'product_description_lenght' : 'int',
        'product_photos_qty' : 'int',
        'product_weight_g' : 'float',
        'product_length_cm' : 'float',
        'product_height_cm' : 'float',
        'product_width_cm' : 'float',
    },
    "olist_order_items" : {
        'order_item_id' : 'int',
        'order_id' : 'nvarchar',
        'product_id' : 'nvarchar',
        'seller_id' : 'nvarchar',
        'shipping_limit_date' : 'datetime',
        'price' : 'float',
        'freight_value' : 'float',
    }
}

datatypes = {
    'comilla': ['nvarchar', 'datetime', 'char'],
    'sin_comilla': ['float', 'int']
}

# Revisar el PATH para cada file
PATH = './T1.2.1.Datos/olist_order_reviews_dataset.csv'
data = pd.read_csv(PATH, sep=',')
data = data.replace(np.nan, 'NULL')

if ('geolocation' in PATH):
    print("ANTES: ", len(data.index))
    data = data.drop_duplicates(subset='geolocation_zip_code_prefix', keep="last").reset_index()
    #print("DESPUÉS: ", len(data.index))
    #print(data)

# print(data.columns)

createQueries = CreateQueries(tables, datatypes)
createQueries.generateInsert('olist_order_reviews', data)
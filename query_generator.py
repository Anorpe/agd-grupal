"""
    Script de ayuda realizado para el trabajo de AGD
    Grupo: Camilo Laiton, Andres Orrego, Diego Naranjo, Juan Ardila, Julian Perez
"""

import pandas as pd
import numpy as np

class CreateQueries():
    
    def __init__(self, tables, datatypes):
        self.tables = tables
        self.datatypes = datatypes

    def generateInsert(self, table_name, data_pd):
        value = ''
        columns = ''
        LIMIT = len(data_pd.index)

        with open('insert_' + table_name + '.sql', 'w') as insert:
            for row_index in range(LIMIT):
                if (row_index % 5000 == 0):
                    print("Row: ", row_index)

                acum = ''
                for key, datatype in self.tables[table_name].items():
                    if not row_index:
                        if not (len(columns)):
                            columns = "'%s'" % (key)
                        else:
                            columns = columns + ', ' + "'%s'" % (key)

                    if datatype in self.datatypes['sin_comilla'] or data_pd.loc[row_index][key] == 'NULL':
                        value = '%s' % (data_pd.loc[row_index][key])
                    else:
                        value = "'%s'" % (data_pd.loc[row_index][key])

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
    """
        "nombre_tabla" : {
            'columna' : 'tipo_dato (sin cantidad) -> ej: CHAR(2) => char',
            ...
        }
    """
}

datatypes = {
    'comilla': ['nvarchar', 'datetime', 'char'],
    'sin_comilla': ['float', 'int']
}

# Revisar el PATH para cada file
PATH = './olist_orders_dataset.csv'
data = pd.read_csv(PATH, sep=',')
data = data.replace(np.nan, 'NULL')
# print(data.columns)

createQueries = CreateQueries(tables, datatypes)
createQueries.generateInsert('olist_orders', data)
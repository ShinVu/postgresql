import os
import psycopg
import pandas as pd
from tabulate import tabulate

import mytests
# import the data quality checks
from dataqualitychecks import check_for_nulls
from dataqualitychecks import check_for_min_max
from dataqualitychecks import check_for_valid_values
from dataqualitychecks import check_for_duplicates
from dataqualitychecks import run_data_quality_check


#Define variables from environment
pguser = os.environ.get('POSTGRESQL_USERNAME')
pgpassword = os.environ.get('POSTGRESQL_PASSWORD')
pghost = os.environ.get('POSTGRESQL_HOST')
pgport = os.environ.get('POSTGRESQL_PORT')
pgdatabase = os.environ.get('POSTGRESQL_DATABASE')

print(pguser)

conn = None

conn = psycopg.connect(
	conninfo=f"host={pghost} port={pgport} dbname={pgdatabase} user={pguser} password={pgpassword}")


#Start of data quality checks
results = []
tests = {key:value for key,value in mytests.__dict__.items() if key.startswith('test')}
for testname,test in tests.items():
    test['conn'] = conn
    results.append(run_data_quality_check(**test))

#print(results)
df=pd.DataFrame(results)
df.index+=1
df.columns = ['Test Name', 'Table','Column','Test Passed']
print(tabulate(df,headers='keys',tablefmt='psql'))
#End of data quality checks
conn.close()
print("Disconnected from data warehouse")

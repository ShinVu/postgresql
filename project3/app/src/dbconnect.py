import os
import psycopg

#Define variables from environment
pguser = os.environ.get('POSTGRESQL_USERNAME')
pgpassword = os.environ.get('POSTGRESQL_PASSWORD')
pghost = os.environ.get('POSTGRESQL_HOST')
pgport = os.environ.get('POSTGRESQL_PORT')
pgdatabase = os.environ.get('POSTGRESQL_DATABASE')

print(pguser)

conn = None
try:
	conn = psycopg.connect(
		conninfo=f"host={pghost} port={pgport} dbname={pgdatabase} user={pguser} password={pgpassword}")

except Exception as e:
	print("Error connecting to data warehouse")
	print(e)
else:
	print("Successfully connected to warehouse")
finally:
	if conn:
		conn.close()
		print("Connection closed")

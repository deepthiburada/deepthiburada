#!/usr/bin/env python
# coding: utf-8
import pandas as pd
import argparse
import os
from time import time
from sqlalchemy import create_engine

def main(params):
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db
    table_name = params.table_name
    parquet_name = 'output.parquet'  # Change to Parquet file name

    # Downloading the parquet file if needed
    # os.system(f"wget {url} -O {parquet_name}")  # Uncomment if you need to download

    # Create engine for PostgreSQL connection
    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # Read Parquet in chunks (you can specify the 'chunksize' if needed)
    df_iter = pd.read_parquet(parquet_name, chunksize=100000, iterator=True)

    # Process first chunk
    df = next(df_iter)
    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    while True:
        t_start = time()
        try:
            df = next(df_iter)
        except StopIteration:
            print("All chunks processed.")
            break  # Exit loop when no more chunks are available
        df.to_sql(name=table_name, con=engine, if_exists='append')
        t_end = time()
        
        print('Inserted another chunk, took %.3f seconds' % (t_end - t_start))

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest Parquet data to Postgres')  # Initialize ArgumentParser
    parser.add_argument('--user', required=True, help='user name for postgres')
    parser.add_argument('--password', required=True, help='password for postgres')
    parser.add_argument('--host', required=True, help='host for postgres')
    parser.add_argument('--port', required=True, help='port for postgres')
    parser.add_argument('--db', required=True, help='database for postgres')
    parser.add_argument('--table_name', required=True, help='name of the table where we will write the results to')
    parser.add_argument('--parquet_path', required=True, help='path to the parquet file')

    args = parser.parse_args()
    main(args)


    args = parser.parse_args()
    main(args)

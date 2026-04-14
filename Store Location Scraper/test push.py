
# This script loads/pushes the created store.csv file into the dbo.Stores
# For my database I used SQL Server Management Studio
# This also cleans the csv data before pushing to the database.


import pandas as pd
from sqlalchemy import create_engine
import urllib

def push_stores_to_sql(csv_path):
    server = 'localhost' 
    database = 'master' 
    driver = 'ODBC Driver 17 for SQL Server'
    

    # Create the connection string parameters
    # Trusted_Connection=yes: Uses Windows Authentication (no password needed)
    # urllib.parse.quote_plus: Safely encodes special characters (like braces) for the URL

    params = urllib.parse.quote_plus(
        f'DRIVER={{{driver}}};SERVER={server};DATABASE={database};Trusted_Connection=yes;'
    )

    # Initialize the SQLAlchemy Engine
    # This 'engine' acts as the primary interface for Pandas to talk to SQL Server
    engine = create_engine(f"mssql+pyodbc:///?odbc_connect={params}")

    try:
        df = pd.read_csv(csv_path)
        print(f"Read {len(df)} rows from {csv_path}")

        # Column mapping
        # This updates the columns from the df to match the ones found in the database
        column_mapping = {
            'store_name': 'StoreName',
            'address_line': 'StoreAddress',
            'phone': 'Phone',
            'email': 'Email',
            'facebook_url': 'FacebookURL',
            'url': 'URL',
            'country': 'Country',
            'province':'Province',
            'location': 'Location',
            'city': 'City',
            'postal_code' : 'PostalCode',
            'latitude': 'Latitude',
            'longitude' : 'Longitude'
            # 'store_id' : 'StoreID'
        }

        df = df.rename(columns=column_mapping)

        sql_cols = ['StoreName', 'StoreAddress', 'Phone', 'Email', 'FacebookURL', 'URL', 'Country', 'Province', 'Location', 'City', 'PostalCode', 'Latitude', 'Longitude', 'StoreID']
        df = df[[c for c in sql_cols if c in df.columns]]

        # CLEANING STEP (CRITICAL FIX)
        
        # Drop rows where StoreName is missing
        # You will realise that initially we extracted 79 stores then later we had 78
        # This is because the 4th store has been closed hence its details no longer exists
        # So it won't be pushed to the database
        df = df.dropna(subset=['StoreName'])

        # Replace NaN with None (for SQL NULLs)
        df = df.where(pd.notnull(df), None)   

        print(f"Rows after cleaning: {len(df)}")

        # Upload
        print(f"Uploading to {database}.dbo.Stores...")

        df.to_sql(
            name='Stores',
            con=engine,
            schema='dbo',
            if_exists='append',
            index=False,
            chunksize=50   
        )

        print("✅ Upload Successful!")

    except Exception as e:
        print(f"❌ Error during upload: {e}")


# --- EXECUTION ---
push_stores_to_sql('stores.csv')
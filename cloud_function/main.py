from google.cloud import bigquery
import os 

def load_csv_to_bq(event, context):
    file = event
    bucket_name = file['bucket']
    file_name = file['name']
    
    if not file_name.endswith(".csv"):
        print(f"Skipped non-csv file: {file_name}")
        return 
    
    uri = f"gs://{bucket_name}/{file_name}"
    print(f"Processing file: {uri}")
    
    client = bigquery.Client()
    
    table_id = os.environ["BQ_TABLE_ID"]
    
    job_config = bigquery.LoadJobConfig(
        source_format=bigquery.SourceFormat.CSV,
        skip_leading_rows=1,
        autodetect=True,
        write_disposition="WRITE_APPEND"
    )
    
    load_job = client.load_table_from_uri(
        uri, table_id, job_config=job_config
    )
    
    load_job.result()
    print(f"Loaded {file_name} into {table_id}")
    
#  PMData: Data Warehouse

## How to run

Follow the guidelines below to correctly run the ETL in your machine:

- Download [PMData from Kaggle](https://www.kaggle.com/datasets/vlbthambawita/pmdata-a-sports-logging-dataset) and unzip it.
- Download Pentaho Data Integration 9.4 and MySQL WorkBench 8.0 (or any other DBMS)
- Run ```dw_pmdata.sql``` to create the Dimensional Model schema and tables in your DBMS.
- In PDI, open the ```inputs/set_connections.ktr``` to set your local variables and connections:
    - Open <b>Data Grid</b> step and, under <b>Data</b> tab, fill with your local variables and connections.
    - Run the transformation.
- Open and run the job ```jobs/load_everything.kjb```.
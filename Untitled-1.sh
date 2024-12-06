services:
  postgres:
    image: postgres:17
    environment:
      POSTGRES_USER: airflow
      POSTGRES_PASSWORD: airflow
      POSTGRES_DB: airflow
    volumes:
      - postgres-db-volume:/var/lib/postgresql/data
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "airflow"]
      interval: 5s
      retries: 5
    restart: always
###pgcli coomands pgcli -h localhost -p 5432 -u root -d ny_taxi

    ###creating a docker image for mounting and 

    docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="cosmetics_data" \
    -v c:/Users/vamsi/Desktop/DEProject/zoomcampN/Docker_SQL/cosmetics_postgres_data:/var/lib/postgresql/data \
    -p 5432:5432 \
    postgres:17
######pgcli commands services.msc

docker pull dpage/pgadmin4
docker run -p 80:80 \
    -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com' \
    -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' \
    -d dpage/pgadmin4

  #####  connect two containers

  docker network create pgd-network

   docker run -it \
    -e POSTGRES_USER="root" \
    -e POSTGRES_PASSWORD="root" \
    -e POSTGRES_DB="ny_taxi" \
    -v c:/Users/vamsi/Desktop/DEProject/ZoomcampNew/docker_sql/ny_taxi_postgres_data:/var/lib/postgresql/data \
    -p 5432:5433 \
    --network=dv-network \
    --name pg11-database \
    postgres:17
###pg admin

docker run -it \
    -p 80:80 \
    -e 'PGADMIN_DEFAULT_EMAIL=user@domain.com' \
    -e 'PGADMIN_DEFAULT_PASSWORD=SuperSecret' \
    --network=dv-network \
    --name pgadmin \
    dpage/pgadmin4




 URL="https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2024-01.parquet"
 python health_ingest:v001 \
    --user=root \
    --password = root \
    --host = local host \
    --port = 5432 \
    --db = ny_taxi \
    --table_name =yellow_taxi_trips \
    --url = ${URL}
     python health_ingest:v001   --user=root   --password=root   --host=localhost   --port=5432   --db=health_data   --table_name=Behavioral_Risk_Factor   --url="https://data.cdc.gov/api/views/hn4x-zwk7/rows.csv?accessType=DOWNLOAD"

docker build -t health_ingest:v001
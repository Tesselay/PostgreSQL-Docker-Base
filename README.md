# PostgreSQL Docker Base
 
Either change the values inside the compose file or use this command to set them when starting a container.
```bash
docker compose -e NAME=VAL -e PORT=VAL -e DB_PASSWORD=VAL -e DB_USER=val -e DB_NAME=val -e HOST_PATH=VAL up
```

NAME = Container name
PORT = Host port
HOST_PATH = Host directory to save the db in
DB_x = Postgres specific env variables
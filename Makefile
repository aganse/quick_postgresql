# Have the following environment vars set in shell before running docker-compose
# (suggested values here but can use whatever desired):
# export DB_NAME=mydatabase
# export DB_USER=postgres
# export DB_PW=<somepassword>
# export DB_PORT=5432

# DBGWHOST assumes db container is already running first, needed for psqld:
DBGWHOST=$(shell docker inspect -f '{{ .NetworkSettings.Networks.quick_postgresql_default.Gateway }}' quick_postgresql)
DBCONNECT=postgresql://${DB_USER}:${DB_PW}@${DBGWHOST}:${DB_PORT}/${DB_NAME}


psqld:
	# WARNING: password usage is not secure here - plaintext used on cmdline
	docker run -it postgres:latest /usr/bin/psql ${DBCONNECT}

run:
	# Start and initialize database and run SchemaSpy
	docker-compose up -d

log:
	# Show tail of logs from all containers in docker-compose
	docker-compose logs -f

stop:
	# Note the --volumes arg means database gets clobbered with this command,
	# i.e. the volume containing the database gets deleted on exit.
	# Remove the --volumes arg if don't want that to happen.
	docker-compose down --volumes

show:
	# For use on Macs - open a web browser on interactive UML diagram
	open -a Safari spy_data/relationships.html

clean:
	# Should need these in regular practice but useful sometimes...
	docker system prune
	docker volume prune

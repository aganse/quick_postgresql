# quick_postgresql
## Quick-prototyping setup for Postgresql database in docker container
(With automated analysis/visualization via SchemaSpy, served via Nginx)

The key file of interest here is init.sql which contains the SQL defining the
database; this is the file you focus on filling in for your own new use-case.
The database is generated based on that, then demonstrated by quick/simple
implementation in a Dockerized Postgresql database, with an add-on of
SchemaSpy to autogenerate documentation/figures and analysis of the database
in init.sql, whose resulting website is served by nginx at
<http://localhost:99>.  The results for latest init.sql are also saved in
this repo so we can link them right in this README file too.  A Makefile
provides easy entrypoints, including psql login into the database for more
browsing.

![Compact UML diagram of database table relationships](
    spy_data/diagrams/summary/relationships.real.compact.png)

[See fuller UML diagram of tables with all columns and interactivity](
    spy_data/relationships.html)
(This is directly in the repo or update after latest `make run` so can be seen
here via README online, but additionally `make run` serves that website out of
port 99 of current host machine as well, so others can access it.)

After running SchemaSpy, the SchemaSpy container exits but the database container
continues running and is accessible on port 5432 (Postgresql default port), and
the Nginx container continues running and serves the SchemaSpy results at
<http://localhost:99>.


## To build/run

* `git clone git@github.com:aganse/quick_postgresql.git`  
* `cd quick_postgresql`  
* `make run`    # generates database and populates `spy_data` (shortcut for docker-compose up)  
* `make psqld`  # provides dockerized psql entrypoint into database  
* `make stop`   # stops the db container (shortcut for docker-compose down --volumes)  
* `make clean`  # runs `docker system prune` and `docker volume prune` which
                  might rarely be useful (but be careful!)...  
* Then point web-browser to <http://localhost:99>.

## Refs for future steps

* In addition to current setup serving SchemaSpy from this database, I plan to
  also implement automated provisioning of Metabase GUI serving this database
  out another port.  Initial steps of that are commented out in the docker-compose
  file, and below are a few links I was using to add lines to auto configure it.
* Examples of using `curl` calls to provision a Metabase installation (db connect etc):  
  https://www.metabase.com/blog/metabase-api/#set-up-users-groups-and-permissions
* More examples of json format to feed thru `curl` to provision Metabase install:  
  https://discourse.metabase.com/t/rest-api-for-initial-setup-process/3419
* Metabase API spec:  
  https://github.com/metabase/metabase/blob/master/docs/api-documentation.md


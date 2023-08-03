#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
	CREATE OR REPLACE FUNCTION public."onUpdate_timestamp"()
		RETURNS trigger
		LANGUAGE 'plpgsql'
		COST 100
		VOLATILE NOT LEAKPROOF
	AS \$BODY\$
	BEGIN
	NEW.updated_at := NOW();
	RETURN NEW;
	END;
	\$BODY\$;

	ALTER FUNCTION public."onUpdate_timestamp"()
		OWNER TO "$POSTGRES_USER";

	/* Template for schema creation
	CREATE SCHEMA IF NOT EXISTS "${SCHEMA_NAME}" AUTHORIZATION "$POSTGRES_USER";
	*/

	/* Template for table creation
	CREATE TABLE IF NOT EXISTS "${SCHEMA_NAME}"."${TABLE_NAME}"
	(
		id bigserial NOT NULL,
		...
		created_at timestamp with time zone NOT NULL DEFAULT now(),
		updated_at timestamp with time zone,
		CONSTRAINT "${TABLE_NAME}_pkey" PRIMARY KEY (id)
	)

	TABLESPACE pg_default;

	ALTER TABLE IF EXISTS "${SCHEMA_NAME}"."${TABLE_NAME}"
		OWNER to "${POSTGRES_USER}";

	CREATE TRIGGER "trigger_onUpdate"
		BEFORE UPDATE 
		ON "${SCHEMA_NAME}"."${TABLE_NAME}"
		FOR EACH ROW
		EXECUTE FUNCTION public."onUpdate_timestamp"();
	*/
EOSQL
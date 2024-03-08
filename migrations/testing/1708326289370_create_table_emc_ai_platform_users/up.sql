CREATE TABLE "emc_ai_platform"."users" ("id" serial NOT NULL, "username" text NOT NULL, "password" text NOT NULL, "firstname" text NOT NULL, "lastname" text NOT NULL, "role" text NOT NULL DEFAULT 'user', "status" text NOT NULL DEFAULT 'inactive', "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") );
CREATE OR REPLACE FUNCTION "emc_ai_platform"."set_current_timestamp_updated_at"()
RETURNS TRIGGER AS $$
DECLARE
  _new record;
BEGIN
  _new := NEW;
  _new."updated_at" = NOW();
  RETURN _new;
END;
$$ LANGUAGE plpgsql;
CREATE TRIGGER "set_emc_ai_platform_users_updated_at"
BEFORE UPDATE ON "emc_ai_platform"."users"
FOR EACH ROW
EXECUTE PROCEDURE "emc_ai_platform"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_emc_ai_platform_users_updated_at" ON "emc_ai_platform"."users"
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

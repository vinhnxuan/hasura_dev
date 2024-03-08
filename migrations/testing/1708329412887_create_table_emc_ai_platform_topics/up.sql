CREATE TABLE "emc_ai_platform"."topics" ("id" serial NOT NULL, "topic_name" text NOT NULL, "user_id" integer NOT NULL, "status" text NOT NULL DEFAULT 'active', "created_at" timestamptz NOT NULL DEFAULT now(), "updated_at" timestamptz NOT NULL DEFAULT now(), PRIMARY KEY ("id") , FOREIGN KEY ("user_id") REFERENCES "emc_ai_platform"."users"("id") ON UPDATE restrict ON DELETE restrict);
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
CREATE TRIGGER "set_emc_ai_platform_topics_updated_at"
BEFORE UPDATE ON "emc_ai_platform"."topics"
FOR EACH ROW
EXECUTE PROCEDURE "emc_ai_platform"."set_current_timestamp_updated_at"();
COMMENT ON TRIGGER "set_emc_ai_platform_topics_updated_at" ON "emc_ai_platform"."topics"
IS 'trigger to set value of column "updated_at" to current timestamp on row update';

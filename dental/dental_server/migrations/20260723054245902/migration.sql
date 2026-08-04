BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "audit_log" (
    "id" bigserial PRIMARY KEY,
    "dentistId" bigint NOT NULL,
    "adminEmail" text NOT NULL,
    "action" text NOT NULL,
    "reason" text,
    "timestamp" timestamp without time zone NOT NULL
);

--
-- ACTION ALTER TABLE
--
ALTER TABLE "dentist" ADD COLUMN "dentistCode" text;
ALTER TABLE "dentist" ADD COLUMN "suspendedAt" timestamp without time zone;
ALTER TABLE "dentist" ADD COLUMN "suspensionEndsAt" timestamp without time zone;
ALTER TABLE "dentist" ADD COLUMN "suspensionReason" text;
ALTER TABLE "dentist" ADD COLUMN "suspendedBy" text;
ALTER TABLE "dentist" ADD COLUMN "terminatedAt" timestamp without time zone;
ALTER TABLE "dentist" ADD COLUMN "terminationReason" text;
ALTER TABLE "dentist" ADD COLUMN "terminatedBy" text;
CREATE UNIQUE INDEX "dentist_code_idx" ON "dentist" USING btree ("dentistCode");

--
-- MIGRATION VERSION FOR dental
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('dental', '20260723054245902', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260723054245902', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod', '20260129180959368', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129180959368', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_idp
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_idp', '20260213194423028', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260213194423028', "timestamp" = now();

--
-- MIGRATION VERSION FOR serverpod_auth_core
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('serverpod_auth_core', '20260129181112269', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260129181112269', "timestamp" = now();


COMMIT;

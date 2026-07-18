BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "dentist" ADD COLUMN "dateOfBirth" text;
ALTER TABLE "dentist" ADD COLUMN "qualification" text;
ALTER TABLE "dentist" ADD COLUMN "registrationFileUrl" text;
ALTER TABLE "dentist" ADD COLUMN "degreeFileUrl" text;
ALTER TABLE "dentist" ADD COLUMN "idFileUrl" text;

--
-- MIGRATION VERSION FOR dental
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('dental', '20260718123036312', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260718123036312', "timestamp" = now();

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

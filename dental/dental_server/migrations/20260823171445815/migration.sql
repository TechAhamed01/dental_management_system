BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dental_image" (
    "id" bigserial PRIMARY KEY,
    "patientId" bigint NOT NULL,
    "appointmentId" bigint NOT NULL,
    "dentistId" bigint NOT NULL,
    "fileName" text NOT NULL,
    "mimeType" text NOT NULL,
    "storageKey" text NOT NULL,
    "fileSize" bigint NOT NULL,
    "uploadedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "dental_image"
    ADD CONSTRAINT "dental_image_fk_0"
    FOREIGN KEY("patientId")
    REFERENCES "patient"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "dental_image"
    ADD CONSTRAINT "dental_image_fk_1"
    FOREIGN KEY("appointmentId")
    REFERENCES "appointment"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "dental_image"
    ADD CONSTRAINT "dental_image_fk_2"
    FOREIGN KEY("dentistId")
    REFERENCES "dentist"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR dental
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('dental', '20260823171445815', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260823171445815', "timestamp" = now();

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

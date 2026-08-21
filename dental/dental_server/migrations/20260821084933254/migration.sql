BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "appointment" (
    "id" bigserial PRIMARY KEY,
    "patientId" bigint NOT NULL,
    "hospitalId" bigint NOT NULL,
    "dentistId" bigint,
    "date" timestamp without time zone NOT NULL,
    "startTime" text NOT NULL,
    "endTime" text NOT NULL,
    "reason" text NOT NULL,
    "status" text NOT NULL,
    "createdAt" timestamp without time zone NOT NULL,
    "updatedAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "appointment"
    ADD CONSTRAINT "appointment_fk_0"
    FOREIGN KEY("patientId")
    REFERENCES "patient"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "appointment"
    ADD CONSTRAINT "appointment_fk_1"
    FOREIGN KEY("hospitalId")
    REFERENCES "hospital"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
ALTER TABLE ONLY "appointment"
    ADD CONSTRAINT "appointment_fk_2"
    FOREIGN KEY("dentistId")
    REFERENCES "dentist"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR dental
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('dental', '20260821084933254', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260821084933254', "timestamp" = now();

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

BEGIN;

--
-- ACTION CREATE TABLE
--
CREATE TABLE "dentist_document" (
    "id" bigserial PRIMARY KEY,
    "dentistId" bigint NOT NULL,
    "documentType" text NOT NULL,
    "fileName" text NOT NULL,
    "mimeType" text NOT NULL,
    "storageKey" text NOT NULL,
    "fileSize" bigint NOT NULL,
    "uploadedAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE INDEX "dentist_document_dentist_id_idx" ON "dentist_document" USING btree ("dentistId");
CREATE INDEX "dentist_document_type_idx" ON "dentist_document" USING btree ("documentType");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "dentist_document"
    ADD CONSTRAINT "dentist_document_fk_0"
    FOREIGN KEY("dentistId")
    REFERENCES "dentist"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR dental
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('dental', '20260820093038710', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260820093038710', "timestamp" = now();

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

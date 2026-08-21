BEGIN;

--
-- ACTION ALTER TABLE
--
ALTER TABLE "dentist" ADD COLUMN "hospitalId" bigint;
--
-- ACTION CREATE TABLE
--
CREATE TABLE "hospital" (
    "id" bigserial PRIMARY KEY,
    "name" text NOT NULL,
    "address" text NOT NULL,
    "phone" text NOT NULL,
    "email" text NOT NULL,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

--
-- ACTION CREATE TABLE
--
CREATE TABLE "receptionist" (
    "id" bigserial PRIMARY KEY,
    "hospitalId" bigint NOT NULL,
    "fullName" text NOT NULL,
    "email" text NOT NULL,
    "passwordHash" text NOT NULL,
    "phone" text NOT NULL,
    "isActive" boolean NOT NULL,
    "createdAt" timestamp without time zone NOT NULL
);

-- Indexes
CREATE UNIQUE INDEX "receptionist_email_idx" ON "receptionist" USING btree ("email");

--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "dentist"
    ADD CONSTRAINT "dentist_fk_0"
    FOREIGN KEY("hospitalId")
    REFERENCES "hospital"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;
--
-- ACTION CREATE FOREIGN KEY
--
ALTER TABLE ONLY "receptionist"
    ADD CONSTRAINT "receptionist_fk_0"
    FOREIGN KEY("hospitalId")
    REFERENCES "hospital"("id")
    ON DELETE NO ACTION
    ON UPDATE NO ACTION;


--
-- MIGRATION VERSION FOR dental
--
INSERT INTO "serverpod_migrations" ("module", "version", "timestamp")
    VALUES ('dental', '20260819091835788', now())
    ON CONFLICT ("module")
    DO UPDATE SET "version" = '20260819091835788', "timestamp" = now();

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

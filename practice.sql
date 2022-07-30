-- states
CREATE TABLE "states" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL UNIQUE
);

-- cities
CREATE TABLE "cities" (
    "id" SERIAL PRIMARY KEY,
    "name" VARCHAR(255) NOT NULL,
    "stateId" INTEGER REFERENCES states(id)
);

-- customerAddresses
CREATE TABLE "customerAddresses" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES customers(id),
    "street" VARCHAR(255) NOT NULL,
    "number" INTEGER NOT NULL,
    "complement" VARCHAR(255),
    "postalCode" VARCHAR(8) NOT NULL,
    "cityId" INTEGER NOT NULL REFERENCES cities(id)
);

-- customerPhones
-- ENUM customerPhones TYPE
CREATE TYPE "PHONE_TYPE" AS ENUM ('landline', 'mobile');

CREATE TABLE "customerPhones" (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES customers(id),
    "number" VARCHAR(31) NOT NULL,
    "type" PHONE_TYPE NOT NULL
);

-- customers
CREATE TABLE customers (
    "id" SERIAL PRIMARY KEY,
    "fullName" VARCHAR(255) NOT NULL,
    "cpf" VARCHAR(11) NOT NULL UNIQUE,
    "email" VARCHAR(255) NOT NULL UNIQUE,
    "password" VARCHAR(255) NOT NULL
);

-- bankAccount
CREATE TABLE bankAccount (
    "id" SERIAL PRIMARY KEY,
    "customerId" INTEGER NOT NULL REFERENCES customers(id),
    "accountNumber" VARCHAR(63) NOT NULL UNIQUE,
    "agency" VARCHAR(31) NOT NULL,
    "openDate" TIMESTAMP NOT NULL DEFAULT NOW(),
    "closeDate" TIMESTAMP DEFAULT NULL
);

-- transactions
-- ENUM transactions type
CREATE TYPE "TRANSACTIONS_TYPE" AS ENUM ('deposit', 'withdraw');

CREATE TABLE transactions (
    "id" SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES bankAccount(id),
    "amount" INTEGER NOT NULL,
    "type" TRANSACTIONS_TYPE NOT NULL,
    "time" TIMESTAMP NOT NULL DEFAULT NOW(),
    "description" TEXT,
    "cancelled" BOOLEAN NOT NULL DEFAULT FALSE
);

-- creditCards
CREATE TABLE creditCards (
    "id" SERIAL PRIMARY KEY,
    "bankAccountId" INTEGER NOT NULL REFERENCES bankAccount(id),
    "name" VARCHAR(127) NOT NULL,
    "number" VARCHAR(13) NOT NULL UNIQUE,
    "securityCode" VARCHAR(3) NOT NULL,
    "expirationMonth" VARCHAR(2) NOT NULL,
    "expirationYear" VARCHAR(2) NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "limit" INTEGER NOT NULL
);
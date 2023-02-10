CREATE TABLE "customers" (
  "id" serial PRIMARY KEY,
  "first_name" varchar NOT NULL,
  "last_name" varchar NOT NULL
);

CREATE TABLE "bikes" (
  "code" varchar PRIMARY KEY,
  "name" varchar NOT NULL,
  "msrp" numeric NOT NULL
);

CREATE TABLE "orders" (
  "order_id" serial PRIMARY KEY,
  "customer_id" int NOT NULL
);

CREATE TABLE "bikes_sold" (
  "id" serial PRIMARY KEY,
  "order_id" int NOT NULL,
  "bike" varchar NOT NULL,
  "sold_for" numeric NOT NULL,
  "notes" varchar
);

ALTER TABLE "orders" ADD FOREIGN KEY ("customer_id") REFERENCES "customers" ("id");

ALTER TABLE "bikes_sold" ADD FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id");

ALTER TABLE "bikes" ADD FOREIGN KEY ("code") REFERENCES "bikes_sold" ("bike");

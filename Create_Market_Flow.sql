CREATE TABLE "clicks" (
  "click_id" text NOT NULL,
  "impression_id" text NOT NULL,
  "session_id" text NOT NULL,
  "user_id" text NOT NULL,
  "event_time" timestamp NOT NULL,
  "product_id" text NOT NULL,
  "position" int NOT NULL,
  PRIMARY KEY ("click_id")
);

CREATE TABLE "experiment_assignment" (
  "assignment_id" text NOT NULL,
  "user_id" text NOT NULL,
  "experiment_name" text NOT NULL,
  "experiment_group" text NOT NULL,
  "assignment_date" date NOT NULL,
  "assignment_source" text NOT NULL,
  PRIMARY KEY ("assignment_id")
);

CREATE TABLE "impressions" (
  "impression_id" text NOT NULL,
  "session_id" text NOT NULL,
  "user_id" text NOT NULL,
  "event_time" timestamp NOT NULL,
  "product_id" text NOT NULL,
  "position" int NOT NULL,
  "model_version" text NOT NULL,
  "is_clicked" int NOT NULL,
  "is_duplicate_event" int NOT NULL,
  PRIMARY KEY ("impression_id")
);

CREATE TABLE "orders" (
  "order_id" text NOT NULL,
  "user_id" text NOT NULL,
  "session_id" text NOT NULL,
  "click_id" text NOT NULL,
  "order_date" timestamp NOT NULL,
  "product_id" text NOT NULL,
  "gmv_rub" int NOT NULL,
  "discount_rub" int,
  "delivery_fee_rub" real,
  "payment_type" text NOT NULL,
  "is_returned" int,
  "return_date" timestamp,
  "gross_margin_rub" real NOT NULL,
  PRIMARY KEY ("order_id")
);

CREATE TABLE "products" (
  "product_id" text NOT NULL,
  "category" text NOT NULL,
  "seller_id" text NOT NULL,
  "base_price_rub" int NOT NULL,
  "gross_margin_rate" real NOT NULL,
  "product_rating" real NOT NULL,
  "is_private_label" int NOT NULL,
  "created_date" date NOT NULL,
  PRIMARY KEY ("product_id")
);

CREATE TABLE "sessions" (
  "session_id" text NOT NULL,
  "user_id" text NOT NULL,
  "session_date" timestamp NOT NULL,
  "device" text NOT NULL,
  "region" text NOT NULL,
  "session_duration_sec" int NOT NULL,
  "page_views" int NOT NULL,
  "entry_point" text NOT NULL,
  PRIMARY KEY ("session_id")
);

CREATE TABLE "support_tickets" (
  "ticket_id" text NOT NULL,
  "user_id" text NOT NULL,
  "order_id" text NOT NULL,
  "ticket_date" timestamp NOT NULL,
  "reason" text NOT NULL,
  "sentiment_score" real NOT NULL,
  "resolved_within_24h" int NOT NULL,
  PRIMARY KEY ("ticket_id")
);

CREATE TABLE "users" (
  "user_id" text NOT NULL,
  "registration_date" date NOT NULL,
  "region" text NOT NULL,
  "device" text NOT NULL,
  "age_group" text NOT NULL,
  "traffic_source" text NOT NULL,
  "is_premium" int NOT NULL,
  "is_bot_candidate" int NOT NULL,
  PRIMARY KEY ("user_id")
);

ALTER TABLE "impressions" ADD CONSTRAINT "fk_impressions_user_id_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "impressions" ADD CONSTRAINT "fk_impressions_product_id_products_product_id" FOREIGN KEY ("product_id") REFERENCES "products" ("product_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "impressions" ADD CONSTRAINT "fk_impressions_session_id_sessions_session_id" FOREIGN KEY ("session_id") REFERENCES "sessions" ("session_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "support_tickets" ADD CONSTRAINT "fk_support_tickets_user_id_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "support_tickets" ADD CONSTRAINT "fk_support_tickets_order_id_orders_order_id" FOREIGN KEY ("order_id") REFERENCES "orders" ("order_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "experiment_assignment" ADD CONSTRAINT "fk_experiment_assignment_user_id_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "sessions" ADD CONSTRAINT "fk_sessions_user_id_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clicks" ADD CONSTRAINT "fk_clicks_user_id_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "orders" ADD CONSTRAINT "fk_orders_user_id_users_user_id" FOREIGN KEY ("user_id") REFERENCES "users" ("user_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clicks" ADD CONSTRAINT "fk_clicks_product_id_products_product_id" FOREIGN KEY ("product_id") REFERENCES "products" ("product_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clicks" ADD CONSTRAINT "fk_clicks_session_id_sessions_session_id" FOREIGN KEY ("session_id") REFERENCES "sessions" ("session_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "clicks" ADD CONSTRAINT "fk_clicks_impression_id_impressions_impression_id" FOREIGN KEY ("impression_id") REFERENCES "impressions" ("impression_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "orders" ADD CONSTRAINT "fk_orders_session_id_sessions_session_id" FOREIGN KEY ("session_id") REFERENCES "sessions" ("session_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "orders" ADD CONSTRAINT "fk_orders_click_id_clicks_click_id" FOREIGN KEY ("click_id") REFERENCES "clicks" ("click_id") DEFERRABLE INITIALLY IMMEDIATE;

ALTER TABLE "orders" ADD CONSTRAINT "fk_orders_product_id_products_product_id" FOREIGN KEY ("product_id") REFERENCES "products" ("product_id") DEFERRABLE INITIALLY IMMEDIATE;

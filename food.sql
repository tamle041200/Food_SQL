SELECT current_database();

create database food;
SELECT current_database(), current_schema();



CREATE TABLE IF NOT EXISTS "user" (
"id" SERIAL PRIMARY KEY,
"full_name" VARCHAR(255),
"email" VARCHAR(255),
"passWord" VARCHAR(255),
 "createdAt" timestamp not null default CURRENT_TIMESTAMP,
 "updatedAt" timestamp not null default CURRENT_TIMESTAMP
);


CREATE TABLE "restaurant" (
"id" SERIAL PRIMARY KEY,
"res_name" VARCHAR(255),
"Image" VARCHAR(255),
"desc" VARCHAR(255),
 "createdAt" timestamp not null default CURRENT_TIMESTAMP,
 "updatedAt" timestamp not null default CURRENT_TIMESTAMP
);

CREATE TABLE  "rate_res"(
"id" SERIAL PRIMARY KEY,
"user_id" INT,
"res_id" INT,
"amount" INT,
"data_rate" DATE,
FOREIGN KEY ("user_id") REFERENCES "user"("id"),
FOREIGN KEY ("res_id") REFERENCES "restaurant"("id"),
 "createdAt" timestamp not null default CURRENT_TIMESTAMP,
 "updatedAt" timestamp not null default CURRENT_TIMESTAMP


);


CREATE TABLE "like_res"(
"id" SERIAL PRIMARY KEY,
"user_id" INT,
"res_id" INT,
"date_like" DATE,
"createdAt" timestamp not null default CURRENT_TIMESTAMP,
"updatedAt" timestamp not null default CURRENT_TIMESTAMP,
FOREIGN KEY ("user_id") REFERENCES "user"("id"),
FOREIGN KEY ("res_id") REFERENCES "restaurant"("id")
);

CREATE TABLE "food_type"(
"id" SERIAL PRIMARY KEY,
"type_name" VARCHAR(255),
"createdAt" timestamp not null default CURRENT_TIMESTAMP,
"updatedAt" timestamp not null default CURRENT_TIMESTAMP

);

CREATE TABLE "food"(
"id" SERIAL PRIMARY KEY,
"type_id" INT,
"food_name" VARCHAR(255),
"image" VARCHAR(255),
"price" FLOAT,
"decs" VARCHAR(255),
"createdAt" timestamp not null default CURRENT_TIMESTAMP,
"updatedAt" timestamp not null default CURRENT_TIMESTAMP,
FOREIGN KEY ("type_id") REFERENCES "food_type"("id")


);

CREATE TABLE "order"(
"id" SERIAL PRIMARY KEY,
"user_id" INT,
"food_id" INT,
"amount" INT,
"code" VARCHAR(255),
"arr_sub_id" VARCHAR(255),
"createdAt" timestamp not null default CURRENT_TIMESTAMP,
"updatedAt" timestamp not null default CURRENT_TIMESTAMP,
FOREIGN KEY ("user_id") REFERENCES "user"("id"),
FOREIGN KEY ("food_id") REFERENCES "food"("id")

);


CREATE TABLE "sub_food"(
"id" SERIAL PRIMARY KEY,
"food_id" INT,
"sub_name" VARCHAR(255),
"sub_price" FLOAT,
FOREIGN KEY("food_id") REFERENCES "food"("id"),
"createdAt" timestamp not null default CURRENT_TIMESTAMP,
"updatedAt" timestamp not null default CURRENT_TIMESTAMP
);


INSERT into "user" ("full_name","email") VALUES
                    ('Nguyễn Văn A','A@gmail.com'),
                    ('Nguyễn Văn B','B@gmail.com'),
                    ('Nguyễn Văn C','C@gmail.com'),
                    ('Nguyễn Văn D','D@gmail.com'),
                    ('Nguyễn Văn E','E@gmail.com');
INSERT into "restaurant" ("res_name","desc") VALUES
                     ('Nhà A','Ngon'),
                     ('Nhà B','rẻ'),
                     ('Nhà C','mắc'),
                     ('Nhà D','dở'),
                     ('Nhà F','tuyệt');
 INSERT into "food" ("food_name","decs") VALUES
                     ('Sukem','Bánh làm từ kem'),
                     ('Gỏi gà','làm từ gà'),
                     ('gỏi vịt','làm từ vịt'),
                     ('cá','làm từ cá'),
                     ('heo','làm từ heo');
                     
INSERT into "like_res" ("user_id","res_id") VALUES
                     (1,2),
                     (3,2),
                     (4,1),
                     (5,2),
                     (2,4),
                     (1,2),
                     (3,2),
                     (4,3),
                     (2,5),
                     (1,1);



INSERT into "order" ("user_id","food_id") VALUES
                     (1,2),
                     (3,2),
                     (4,2),
                     (5,2),
                     (1,2);


INSERT into "rate_res" ("user_id","res_id") VALUES
                     (1,2),
                     (3,2),
                     (4,2),
                     (5,2),
                     (1,2);

                     
--Tìm 5 người đã like nhà hàng nhiều nhất.
SELECT "user_id","user"."id","full_name","email", COUNT("user_id") as "Số Lượt Like"
FROM "like_res"
INNER JOIN "user" on "like_res"."user_id" = "user"."id"
GROUP BY "user_id","user"."id"
ORDER BY "Số Lượt Like" DESC
LIMIT 5;
-- Tìm 2 nhà hàng có lượt like nhiều nhất
SELECT "res_id","restaurant"."id","res_name", COUNT("user_id") as "Số Lượt Like"
FROM "like_res"
INNER JOIN "restaurant" on "like_res"."res_id" = "restaurant"."id"
GROUP BY "res_id","restaurant"."id"
ORDER BY "Số Lượt Like" DESC
LIMIT 2;
--Tìm người đã đặt hàng nhiều nhất.
SELECT "user_id","user"."id","full_name","email",COUNT("user_id") as "Số Lượt mua"
FROM "order"
INNER JOIN "user" on "user"."id" = "order"."user_id"
GROUP BY "user_id", "user"."id"
ORDER BY "Số Lượt mua" DESC
LIMIT 1;
--Tìm người dùng không hoạt động trong hệ thống(không đặt hàng, không like, không đánh giá nhà hàng).
SELECT *
FROM "user"
LEFT JOIN "order" on "order"."user_id" = "user"."id"
LEFT JOIN "like_res" on "like_res"."user_id" = "user"."id"
LEFT JOIN "rate_res" on "rate_res"."user_id" = "user"."id"
WHERE "order"."user_id" is NULL AND "like_res"."user_id" IS NULL AND "rate_res"."user_id" IS NULL ;

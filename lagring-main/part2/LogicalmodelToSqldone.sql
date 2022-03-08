CREATE TABLE "person"
(
  "person_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "person_number" varchar(12) UNIQUE,
  "first_name" varchar(50),
  "last_name" varchar(50),
  "street" varchar(100),
  "zip" varchar(5),
  "city" varchar(50)
);
CREATE TABLE "student"
(
  "student_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "person_id" int NOT NULL REFERENCES "person",
  "age" varchar(50),
  "rent_instrument_quota" varchar(50)
);
CREATE TABLE "student_payment"
(
  "student_id" int NOT NULL REFERENCES "student",
  "fee" varchar(10),
  PRIMARY KEY("student_id")
);

CREATE TABLE "siblings"
(
  "student_id" int NOT NULL REFERENCES "student",
 "sibling_id" varchar(500),
  PRIMARY KEY("student_id")
);

CREATE TABLE "discount"
(
  "student_id" int NOT NULL REFERENCES "student",
  "amount" varchar(500),

  PRIMARY KEY("student_id")
);

CREATE TABLE "prices"
(
  "difficulty" varchar(10),
  "standard_price" varchar(10)
);
CREATE TABLE "rented_instruments"
( 
  "stock_id" int NOT NULL REFERENCES "stock",
  "student_id" int NOT NULL REFERENCES "student",
  "length_of_rent" date,
  "max_length_of_rent" date,
  "is_rented" boolean
);

CREATE TABLE "stock"
(
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "brand" varchar(500),
  "instrument_name" varchar(500),
  "amount" varchar(10),
  "cost" varchar(500)
);

CREATE TABLE "instructor"
(
  "instructor_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "person_id" int NOT NULL REFERENCES "person",
  "employment_id" varchar(10) UNIQUE NOT NULL
);
CREATE TABLE "instructor_payment"
(
  "instructor_id" int NOT NULL REFERENCES "instructor",
  "amount" varchar(10),
  "time_of_payment" TIMESTAMP,
  PRIMARY KEY("instructor_id")
);

CREATE TABLE "lesson"
(
  "id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "instructor_id" int NOT NULL REFERENCES "instructor",
  "attendence" varchar(10),
  "min_attendence" varchar(5),
  "max_attendence" varchar(5),
  "length_of_lesson" varchar(5),
  "skill_level" varchar(10),
  "date" timestamp NOT NULL
);
CREATE TABLE "room"
(
  "lesson_id" int NOT NULL REFERENCES "lesson",
  "room_number" varchar(5),
  "street" varchar(100),
  "zip" varchar(5),
  "city" varchar(50)
  
);

CREATE TABLE "individual"
(
  "lesson_id" int NOT NULL REFERENCES "lesson",
  "instruments" varchar(500)
);

CREATE TABLE "group"
(
  "lesson_id" int NOT NULL REFERENCES "lesson",
  "instruments" varchar(500)
);
CREATE TABLE "ensamble"
(
  "lesson_id" int NOT NULL REFERENCES "lesson",
  "genre" varchar(500)
);

CREATE TABLE "email"
(
  "email_id" int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  "email" varchar(100) UNIQUE NOT NULL
);

CREATE TABLE "phone"
(
  "person_id" int NOT NULL REFERENCES "person" ON DELETE CASCADE,
  "phone_no" varchar(12) NOT NULL,
  PRIMARY KEY ("person_id", "phone_no")
);

CREATE TABLE "person_email"
(
  "email_id" int NOT NULL REFERENCES "email" ON DELETE CASCADE,
  "person_id" int NOT NULL REFERENCES "person" ON DELETE CASCADE,
  PRIMARY KEY("email_id", "person_id")
);
CREATE TABLE "person_phone"
(
  "email_id" int NOT NULL REFERENCES "email" ON DELETE CASCADE,
  "person_id" int NOT NULL REFERENCES "person" ON DELETE CASCADE,
  PRIMARY KEY("email_id", "person_id")
);

CREATE TABLE "parent_email"
(
  "email_id" int NOT NULL REFERENCES "email" ON DELETE CASCADE,
  "student_id" int NOT NULL REFERENCES "student" ON DELETE CASCADE,
  PRIMARY KEY("email_id", "student_id")
);
CREATE TABLE "parent_phone"
(
  "email_id" int NOT NULL REFERENCES "email" ON DELETE CASCADE,
  "student_id" int NOT NULL REFERENCES "student" ON DELETE CASCADE,
  PRIMARY KEY("email_id", "student_id")
);
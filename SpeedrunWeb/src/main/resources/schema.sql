CREATE TABLE users (
id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
username VARCHAR(32) UNIQUE NOT NULL,
password VARCHAR(32) NOT NULL,
is_admin Boolean
);
CREATE TABLE posts(
id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
name VARCHAR(64) NOT NULL,
link VARCHAR(128) NOT NULL,
time time NOT NULL,
date DATE,
verified Boolean
);

CREATE TABLE different_categories (
id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
category_name VARCHAR(64) NOT NULL
);
CREATE TABLE selector(
catagory_id INT NOT NULL REFERENCES different_categories(id),
post_id INT NOT NULL REFERENCES posts(id)
);
CREATE TABLE forum(
    id int GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    head VARCHAR(64),
    comment VARCHAR(65),
    name VARCHAR(64)
);
INSERT INTO users (username,password, is_admin) VALUES ('ada@kth.se', 'qwerty', true);
INSERT INTO users (username,password, is_admin) VALUES ('beda@kth.se', 'asdfgh', true);
INSERT INTO different_categories (category_name) VALUES ('Dark souls');
INSERT INTO posts (name, link, time, date, verified, catagory) VALUES ('ada@kth.se', 'https://youtu.be/CDXK2MPgcqA', '00:23:45', '2023-01-02', false, 'Elden ring');
INSERT INTO selector (catagory_id, post_id) VALUES (1,1);

CREATE TABLE student(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) NOT NULL,
	surname VARCHAR(255),
	address VARCHAR(255),
	n_group INT,
	CHECK (n_group >= 1000 AND n_group <= 9999),
	score REAL, 
	CHECK (score >= 2 AND score <= 5)
);

CREATE TABLE hobby(
	id SERIAL PRIMARY KEY,
	name varchar(255) NOT NULL,
	risk NUMERIC(3, 2) NOT NULL
);

CREATE TABLE student_hobby(
	id SERIAL PRIMARY KEY,
	student_id INT NOT NULL REFERENCES student(id),
	hobby_id INT NOT NULL REFERENCES hobby(id),
	date_start TIMESTAMP NOT NULL,
	date_end DATE
);

INSERT INTO student (name, surname, address, n_group, score) VALUES ('Антон', 'Мельников', 'Удомля', 1276, 4.5);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Богдан', 'Быков', 'Новороссийск', 1284, 4.9);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Клим', 'Титов', 'Кемерово', 2212, 2.5);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Всеволод', 'Андреев', 'Десногорск', 1216, 2.1);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Ксения', 'Тарасова', 'Солнечногорск', 3015, 4.1);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Евгений', 'Стрелков', 'Калининград', 2645, 3.5);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Алиса', 'Уварова', 'Ханты-Мансийск', 5522, 4.3);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Евгений', 'Иванов', 'Москва', 1526, 4.3);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Егор', 'Некрасов', 'Тверь', 4217, 2.1);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Михаил', 'Логинов', 'Мышкин', 1357, 4.7);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Степан', 'Олейников', 'Галич', 1242, 4.3);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Григорий', 'Шаров', 'Симферополь', 4616, 2.8);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Анна', 'Степанова', 'Ноябрьск', 2671, 3.1);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Эля', 'Костина', 'Петровск', 5513, 2.8);
INSERT INTO student (name, surname, address, n_group, score) VALUES ('Денис', 'Рыбаков', 'Сергиев-Посад', 5054, 2.1);

INSERT INTO hobby (name, risk) VALUES ('футбол', 0.5);
INSERT INTO hobby (name, risk) VALUES ('хоккей', 2);
INSERT INTO hobby (name, risk) VALUES ('баскетбол', 1.5);
INSERT INTO hobby (name, risk) VALUES ('волейбол', 1);
INSERT INTO hobby (name, risk) VALUES ('плавание', 0.5);

INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (1, 1, '07-01-2010 12:03:59', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (2, 2, '05-01-2019 14:00:00', '07-08-2021');
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (2, 3, '02-05-2020 12:00:00', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (5, 2, '10-07-2015 17:00:00', '10-9-2020');
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (5, 4, '12-12-2011 18:00:00', '02-01-2012');
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (8, 4, '09-23-2014 10:00:00', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (9, 5, '12-12-2017 13:00:00', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (12, 1, '05-06-2012 12:00:00', null);
INSERT INTO student_hobby (student_id, hobby_id, date_start, date_end) VALUES (14, 2, '03-04-2019 19:00:00', '04-06-2018');

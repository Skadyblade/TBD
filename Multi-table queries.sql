SELECT
	s.name, 
	s.surname, 
	h.name as hobby_name
FROM 
	student as s,
	student_hobby as sh,
	hobby as h
WHERE s.id = sh.student_id and h.id = sh.hobby_id;


SELECT s.id
FROM
	student s
INNER JOIN student_hobby sh on sh.student_id = s.id and sh.date_finish IS NULL
ORDER BY sh.date_start
LIMIT 1;


SELECT s.name,
	   s.surname,
	   s.date_birth,
	   SUM(h.risk) as sum_risk
FROM student s,
	 hobby h,
	 student_hobby sh
WHERE s.id = sh.student_id AND h.id = sh.hobby_id AND
	  s.score > (SELECT AVG(score)
				FROM student)
GROUP BY s.id
HAVING SUM(h.risk) > 0.9;


SELECT s.id,
	   s.name,
	   s.surname,
	   s.date_birth,
	   h.name as hobby_name,
	   12 * extract(year from age(date_finish, date_start))
FROM student s,
	 hobby h,
	 student_hobby sh
WHERE s.id = sh.student_id AND h.id = sh.hobby_id AND
	  date_finish IS NOT NULL;


SELECT s.id,
	   s.name,
	   s.surname,
	   s.date_birth,
	   COUNT(sh.date_finish) AS hobby_count
FROM student s,
	 hobby h,
	 student_hobby sh
WHERE s.id = sh.student_id AND h.id = sh.hobby_id AND
	  extract(year from age(now()::timestamp::date, s.date_birth)) = 24
	  AND sh.date_finish IS NOT NULL
GROUP BY s.id
HAVING COUNT(sh.date_finish) > 1;


SELECT s.n_group, round(avg(s.score), 2)
FROM
	student s
INNER JOIN student_hobby sh on sh.student_id = s.id and sh.date_finish IS NULL
GROUP BY n_group;


SELECT s.id,
	   s.name, 
	   h.name as hobby_name, 
	   h.risk as hobby_risk,
	   12 * extract(year from age(now()::date, sh.date_start)) as hobby_time
FROM 
	 student_hobby sh
INNER JOIN student s on sh.student_id = s.id
INNER JOIN hobby h on sh.hobby_id = h.id
WHERE date_finish IS NULL
ORDER BY hobby_time DESC
LIMIT 1;


SELECT s.name,
	   s.surname,
	   s.score,
	   h.name as hobby_name
FROM 
	 student_hobby sh
INNER JOIN student s on sh.student_id = s.id
INNER JOIN hobby h on sh.hobby_id = h.id
WHERE score = (SELECT MAX(score) FROM student);


SELECT s.name,
	   s.surname,
	   div(s.n_group, 1000) as course,
	   s.score,
	   h.name as hobby_name
FROM 
	 student_hobby sh
INNER JOIN student s on sh.student_id = s.id
INNER JOIN hobby h on sh.hobby_id = h.id
WHERE s.score >= 2.5 and s.score < 3.5 and div(s.n_group, 1000) = 2;


SELECT s.n_group, round(count(s.id) filter(WHERE s.score > 4)*1.0 /count(s.id), 2)
FROM student s
GROUP BY s.n_group
HAVING (count(s.id) filter(WHERE s.score > 4)*1.0 /count(s.id)) > 0.6


SELECT s.n_group, COUNT(DISTINCT h.id) as hobby_count
FROM student_hobby sh
INNER JOIN student s ON s.id = sh.student_id
INNER JOIN hobby h ON h.id = sh.hobby_id
GROUP BY s.n_group


SELECT s.*
FROM student_hobby sh
RIGHT JOIN student s ON s.id = sh.student_id
WHERE sh.id IS NULL AND s.score >= 4.5


CREATE OR REPLACE VIEW Students_V1 AS
SELECT DISTINCT s.*
FROM student s
LEFT JOIN student_hobby sh on s.id = sh.student_id
WHERE sh.date_finish IS NULL AND extract(year from age(now()::date, sh.date_start)) >= 5;


SELECT h.name as hobby_name,
	   COUNT(s.id) as count_students
FROM 
	hobby h,
	student s,
	student_hobby sh
WHERE s.id = sh.student_id and h.id = sh.hobby_id
GROUP BY hobby_name;


SELECT h.id
FROM 
	student_hobby sh
INNER JOIN hobby h on sh.hobby_id = h.id
GROUP BY h.id
ORDER BY count(1) DESC
LIMIT 1;


SELECT s.*
FROM student_hobby sh
INNER JOIN student s on s.id = sh.student_id AND sh.hobby_id = 
(
	SELECT h.id
	FROM 
		student_hobby sh
	INNER JOIN hobby h on sh.hobby_id = h.id
	GROUP BY h.id
	ORDER BY count(1) DESC
	LIMIT 1
);


SELECT id
FROM hobby
ORDER BY risk DESC
LIMIT 3;


SELECT s.*
FROM student_hobby sh
INNER JOIN student s ON sh.student_id = s.id
WHERE sh.date_finish IS NULL 
GROUP BY s.id, sh.date_start
ORDER BY (now() - sh.date_start) DESC
LIMIT 10;


SELECT DISTINCT s.n_group
FROM student s
WHERE s.n_group IN
(SELECT s.n_group
FROM student_hobby sh
INNER JOIN student s ON sh.student_id = s.id
WHERE sh.date_finish IS NULL 
GROUP BY s.id, sh.date_start
ORDER BY (now() - sh.date_start) DESC
LIMIT 10);


CREATE OR REPLACE VIEW Student_data AS
SELECT s.id, s.name, s.surname
FROM student s
ORDER BY s.score DESC;

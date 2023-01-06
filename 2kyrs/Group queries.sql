SELECT n_group, COUNT(n_group)
FROM student
GROUP BY n_group;
 

SELECT n_group, MAX(score) AS max_score
FROM student
GROUP BY n_group
ORDER BY max_score DESC;


SELECT surname, COUNT(surname)
FROM student
GROUP BY surname;


SELECT EXTRACT(year from date_birth) as year, COUNT(id)
FROM student
GROUP BY year 
HAVING EXTRACT(year from date_birth) IS NOT NULL;


SELECT n_group, AVG(score)
FROM student 
GROUP BY n_group
ORDER BY n_group;


SELECT n_group
FROM
	student
WHERE score IN 
	(SELECT MAX(score)
 	FROM student)
LIMIT 1;


SELECT n_group, AVG(score) as avg_score
FROM
	student
GROUP BY n_group
HAVING AVG(score) <= 3.5
ORDER BY avg_score;


SELECT n_group, AVG(score) as avg_score, MAX(score) as max_score, MIN(score) as min_score
FROM
	student
GROUP BY n_group;


SELECT *
FROM student
WHERE (n_group, score) IN
	(SELECT n_group, MAX(score)
	FROM
		student
	GROUP BY n_group
	HAVING n_group = 5555);


SELECT *
FROM student
WHERE (n_group, score) IN
	(SELECT n_group, MAX(score)
	FROM
		student
	GROUP BY n_group);

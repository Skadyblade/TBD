SELECT *
FROM student
    WHERE score >= 4 AND score <= 4.5;

SELECT *
FROM student
    WHERE score BETWEEN 4 AND 4.5;

SELECT name, surname, n_group::varchar
FROM student
WHERE name LIKE 'А%' OR surname LIKE '%х%';

SELECT *
FROM student
    ORDER BY n_group DESC, name;

SELECT *
FROM student
    WHERE score > 4
    ORDER BY score DESC;

SELECT name, risk
FROM hobby
    WHERE name IN ('баскетбол', 'плавание');

SELECT student_id, hobby_id
FROM student_hobby
    WHERE (date_start BETWEEN '01-01-2018' AND '12-31-2019')
        AND date_end IS NOT NULL;

SELECT *
FROM student
    WHERE score > 4.5
    ORDER BY score DESC;

SELECT *
FROM student
    WHERE score > 4.5
    ORDER BY score DESC
    LIMIT 5;

SELECT *
FROM student
    WHERE score > 4.5
    ORDER BY score DESC
	FETCH FIRST 5 ROWS ONLY;

SELECT *,
	CASE
		WHEN risk >= 8 THEN 'очень высокий'
		WHEN (risk >= 6 AND risk < 8) THEN 'высокий'
		WHEN (risk >= 4 AND risk < 6) THEN 'средний'
		WHEN (risk >= 2 AND risk < 4) THEN 'низкий'
		ELSE 'очень низкий'
	END as risk_assessment
FROM hobby;

SELECT *
FROM hobby
    ORDER BY risk DESC
    LIMIT 3;

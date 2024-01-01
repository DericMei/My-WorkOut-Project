/* I did some basic data clean up in excel before uploading this file into my SQL database because some of the names of the columns were in Chinese,
   and I do not need some of the other columns. */

-- Data Cleanning --   

-- 1. Take a first look at the imported data
SELECT	*
FROM	workout;

-- 2. Column date is not in date data type, instead it is text at this moment, I need to first change it to date

-- Check for missing values
SELECT 	*
FROM 	workout
WHERE 	STR_TO_DATE(date, '%Y-%m-%d %H:%i:%s') IS NULL
  AND 	date IS NOT NULL;

-- Modify date column to date datatype
ALTER TABLE workout
MODIFY date DATE;

-- Check data type to make sure it is correctly altered
SELECT COLUMN_NAME, DATA_TYPE 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE 
    TABLE_SCHEMA = 'Workout' AND 
    TABLE_NAME = 'workout' AND 
    COLUMN_NAME = 'date';
    
-- 3. Add a new column called set_load into the database since most of the queries will be based on that column.

ALTER TABLE workout
ADD set_load DOUBLE; 

UPDATE workout
SET set_load = weight * rep;

-- 4. For the specific excercise 'chin up', when weight is 0, it means I did the workout using my body weight, if there is value in the weight column, it means I was doing weighted chin-ups.

-- To resolve this, I am going to add the weight 180lb to all values for the chin up excercise, which is my average year round weight.
UPDATE		workout
SET			weight = weight + 180
WHERE		excercise_name = 'Chin Up';

-- And then, I need to do the set_load update.

-- 5. Made a typo and need to change the name of 2 columns
ALTER TABLE workout
CHANGE COLUMN excercise_name exercise_name VARCHAR(100);

ALTER TABLE workout
CHANGE COLUMN set_num set_rank VARCHAR(100);


-- Queries --

-- 1. Highest excercise count (My Favorite exercises)
With A AS
(
SELECT		date, exercise_name
FROM		workout
GROUP BY	date, exercise_name
)
SELECT		exercise_name, COUNT(*) AS exercise_count
FROM		A
GROUP BY	exercise_name
ORDER BY	exercise_count DESC;

-- 2. Total number of workouts in the record
SELECT		COUNT(DISTINCT(date)) AS total_workouts
FROM		workout;

-- 3. Total Load Over Time for Bench Press
WITH A AS
(
SELECT		date, MAX(weight) AS max_weight
FROM 		workout
WHERE 		exercise_name = 'Bench Press (Barbell)'
GROUP BY 	date
),
B AS
(
SELECT		A.date, MIN(workout.set_rank) AS start_rank
FROM		A
INNER JOIN	workout
ON			A.date = workout.date
			AND A.max_weight = workout.weight
WHERE		workout.exercise_name = 'Bench Press (Barbell)'
GROUP BY	A.date
),
C AS
(
SELECT		workout.date, workout.exercise_name, workout.set_rank, workout.weight, workout.rep, workout.set_load
FROM		B
INNER JOIN	workout
ON			B.date = workout.date
			AND workout.set_rank >= B.start_rank
WHERE		workout.exercise_name = 'Bench Press (Barbell)'
GROUP BY	workout.date, workout.exercise_name, workout.set_rank, workout.weight, workout.rep, workout.set_load
)
SELECT		date, exercise_name, SUM(set_load) AS total_load
FROM		C
GROUP BY	date, exercise_name;

# **My WorkOut Project**
 This is a SQL project deployed with tableau interactive dashboard visualization based my past strenghth training data.
## Project Summary
I have been working out for a really long time. I started to use the APP Strong to record my workouts since 2020. I discovered that I can export these data as a csv file! I have always wanted to do an analysis on my own workouts.
For this project, I used the pipeline of:
- Some basic data clean up in Excel
- Uploaded cleaned up data into my MySQL database
- Further data clean up and type conversion in MySQL
- Run queries to explore data and generate insights
- Export data generated by MySQL to Excel files
- Use the data to create an [Interactive Dashboard](https://public.tableau.com/views/EricMeiWorkoutProject/Dashboard1?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link) using Tableau  

Some interesting findings:
- After almost 10 years of working out, My favorite exercise is till BenchPress
- My total load for most exercises did not go up much for the last 3 years, most likely because of COVID

All of these insights can be viewed on the [Interactive Dashboard](https://public.tableau.com/views/EricMeiWorkoutProject/Dashboard1?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link)
## Tools Used
MySQL, Tableau, Excel
## Data Science Techniques Used
Local MySQL database creation, Joins, CTE's, Subqueries, Aggregate Functions, Converting Data Types, Tableau Data Visualization, Interactive Dashboard Creation
## Files
- Workout.sql (the SQL script that contains all the SQL queries as well as codes manipulating the SQL database)
- strong.csv (raw data file before Excel clean up)
- data_toSQL.csv (raw data after Excel clean up)
- Tableau (folder containing excel files that are generated by SQL queries used to create the Tableau interactive dashboard)
## Usage
Link to the Tableau [Interactive Dashboard](https://public.tableau.com/views/EricMeiWorkoutProject/Dashboard1?:language=en-US&publish=yes&:display_count=n&:origin=viz_share_link)
## Data Source
The raw data used in this project was my own workout data recorded using the APP [Strong](https://www.strong.app) since 2020.
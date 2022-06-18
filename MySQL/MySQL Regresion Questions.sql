
# SQL questions - regression

# 1. Create a database called house_price_regression.

CREATE DATABASE house_price_regression;


USE house_price_regression;


# 2. Create a table house_price_data with the same columns as given in the csv file. Please make sure you use the correct data types for the columns.

CREATE TABLE house_price_data 
(`id` BIGINT NOT NULL,
`date` varchar(20) DEFAULT NULL,
`bedrooms` INT DEFAULT NULL,
`bathrooms` FLOAT DEFAULT NULL,
`sqft_living` INT DEFAULT NULL,
`sqft_lot` INT DEFAULT NULL,
`floors` FLOAT DEFAULT NULL,
`waterfront` INT DEFAULT NULL,
`view` INT DEFAULT NULL,
`conditions` FLOAT DEFAULT NULL,
`grade` INT DEFAULT NULL,
`sqft_above` INT DEFAULT NULL,
`sqft_basement` INT DEFAULT NULL,
`yr_built` INT DEFAULT NULL,
`yr_renovated` INT DEFAULT NULL,
`zipcode` INT DEFAULT NULL,
`lat` FLOAT DEFAULT NULL,
`long` FLOAT DEFAULT NULL,
`sqft_living15` INT DEFAULT NULL,
`sqft_lot15` INT DEFAULT NULL,
`price` INT DEFAULT NULL
);

# 3. Import the data from the csv file into the table. Before you import the data into the empty table, 
# make sure that you have deleted the headers from the csv file. To not modify the original data, if you want you can create a copy of the csv file as well. 
# Note you might have to use the following queries to give permission to SQL to import data from csv files in bulk:

drop table house_price_data;
SHOW GLOBAL VARIABLES LIKE 'local_infile';
set global local_infile=1;

LOAD DATA INFILE '/Users/dchrobak/Desktop/School/Mid-Project/data_mid_bootcamp_project_regression/regression_data.csv'
INTO TABLE house_price_data
FIELDS TERMINATED BY ',';

SHOW VARIABLES LIKE 'secure_file_priv';

set global secure_file_priv = "";

#4 Select all the data from table house_price_data to check if the data was imported correctly

select *
from house_price_data;


# 5. Use the alter table command to drop the column date from the database, as we would not use it in the analysis with SQL. 
# Select all the data from the table to verify if the command worked. Limit your returned results to 10.

ALTER TABLE house_price_data
DROP COLUMN date;

select *
from house_price_data
limit 10;

# 6. Use sql query to find how many rows of data you have.

select count(*)
from house_price_data;

#. There are 21597 rows

# 7. Now we will try to find the unique values in some of the categorical columns:
	
    # What are the unique values in the column bedrooms?
    
    select distinct bedrooms
    from house_price_data;
    
	# What are the unique values in the column bathrooms?
    
    select distinct bathrooms
    from house_price_data;
    
	# What are the unique values in the column floors?
    
    select distinct floors
    from house_price_data;
    
	# What are the unique values in the column condition?
    
	select distinct conditions
    from house_price_data;
    
    # I had to change the name of condition to 'conditions' because it was a key word
    
    
	# What are the unique values in the column grade?
    
    select distinct grade
    from house_price_data;

# 8. Arrange the data in a decreasing order by the price of the house. Return only the IDs of the top 10 most expensive houses in your data.

select *
from house_price_data
order by price desc
limit 10;

# 9. What is the average price of all the properties in your data?

select avg(price) 'Average price of all the properties'
from house_price_data;


# 10. In this exercise we will use simple group by to check the properties of some of the categorical variables in our data

	# What is the average price of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the prices. 
    # Use an alias to change the name of the second column.
    
    select
		bedrooms, avg(price) 'Average price per bedroom'
	from house_price_data
    group by bedrooms;
	
    # What is the average sqft_living of the houses grouped by bedrooms? The returned result should have only two columns, bedrooms and Average of the sqft_living. 
    # Use an alias to change the name of the second column.
    
	select
		bedrooms, avg(sqft_living) 'Average sqft per property'
	from house_price_data
    group by bedrooms;
    
    # What is the average price of the houses with a waterfront and without a waterfront? The returned result should have only two columns, waterfront and Average of the prices. 
    # Use an alias to change the name of the second column.
    
    select 
		waterfront, avg(price) 'Avg with or withour a waterfront'
	from house_price_data
    group by waterfront;
    
    # Is there any correlation between the columns condition and grade? You can analyse this by grouping the data by one of the variables and then aggregating the results of the other column. 
    # Visually check if there is a positive correlation or negative correlation or no correlation between the variables.

	select grade, avg(conditions)
	from house_price_data
    group by grade
    order by grade;
    
    # no correltation


# 11. One of the customers is only interested in the following houses:
	# Number of bedrooms either 3 or 4
	# Bathrooms more than 3
	# One Floor
	# No waterfront
	# Condition should be 3 at least
	# Grade should be 5 at least
	# Price less than 300000
# For the rest of the things, they are not too concerned. Write a simple query to find what are the options available for them?

select *
from house_price_data
where 
	bathrooms = 3 or 4
    AND bedrooms > 4
    AND floors = 1
    AND waterfront = 0
    AND conditions >= 3
	AND grade >= 5
    AND price < 300000
order by price;

# 12. Your manager wants to find out the list of properties whose prices are twice more than the average of all the properties in the database. Write a query to show them the list of such properties. 
# You might need to use a sub query for this problem.

select *
from house_price_data
where price > 2*(select avg(price)
				from house_price_data);
                   
                

# 13. Since this is something that the senior management is regularly interested in, create a view of the same query.
CREATE VIEW doubled_average_price as
    select price as  'Doubled Average'
	from house_price_data
	where price > 2*(select avg(price)
				from house_price_data);

select *
from doubled_average_price;


# 14. Most customers are interested in properties with three or four bedrooms. What is the difference in average prices of the properties with three and four bedrooms?

select avg(price)
from house_price_data
where bedrooms =  4 and 3;

# 15. What are the different locations where properties are available in your database? (distinct zip codes)

select distinct zipcode
from house_price_data;

# 16. Show the list of all the properties that were renovated.

select *
from house_price_data
where yr_renovated > 0







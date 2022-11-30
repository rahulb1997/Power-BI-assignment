create database COMPLAINT_ADMINISTRATION;

USE COMPLAINT_ADMINISTRATION;

CREATE TABLE BROKERS(
BrokerID VARCHAR(30),
BrokerCode VARCHAR(50),
BrokerFullName VARCHAR(50),
DistributionNetwork VARCHAR(50),
DistributionChannel VARCHAR(50),
CommissionScheme VARCHAR(50)
);

CREATE TABLE STATE_REGIONS(
State_Code VARCHAR(50),
State VARCHAR(50),
Region VARCHAR(50)
);

LOAD DATA INFILE 'C:/State Regions.CSV'
INTO TABLE STATE_REGIONS
FIELDS TERMINATED BY ','
IGNORE 1 ROWS;

SELECT * FROM state_regions;

DROP TABLE state_regions;

select * from brokers;

select * from categories;

select * from complains_data;

select * from customers;

select * from priorities;

select * from products;

select * from regions;

select * from sources;  # HAS MANY EMPTY ROWS 

SELECT * FROM STATE_REGIONS2;  # HAS MANY EMPTY ROWS 

SELECT * FROM STATUS_HISTORY_DATA;

SELECT * FROM STATUSES;

SELECT * FROM TYPES;

-- -------------------------------------------------------------------------------------------

-- DELETING BLANK ROWS FROM THE TABLES ( DATA CLEANING )

DELETE FROM CATEGORIES WHERE ID= '' OR ID IS NULL;

DELETE FROM PRIORITIES WHERE ID= '' OR ID IS NULL;

DELETE FROM PRODUCTS WHERE ProductID= '' OR ProductID IS NULL;

DELETE FROM REGIONS WHERE ID= '' OR ID IS NULL;

DELETE FROM SOURCES WHERE ID= '' OR ID IS NULL;

DELETE FROM STATE_REGIONS2 WHERE STATE= '' OR STATE IS NULL;

DELETE FROM state_regions WHERE `State Code`= 'State Code'; -- DELETING HEADER ROW INCORRECTLY ENTERED TWICE

ALTER table state_regions
DROP MyUnknownColumn;		-- DROPPING A BLANK COLUMN 

DELETE FROM STATUSES WHERE ID= '' OR ID IS NULL;

DELETE FROM TYPES WHERE ID= '' OR ID IS NULL;

-- SINCE STATE_REGIONS HAS MANY EMPTY ROWS AND COLUMNS 

CREATE TABLE STATE_REGIONS2 AS 
SELECT `State Code` AS STATE_CODE, STATE, REGION FROM state_regions;


-- -----------------------------------------------------------------------------------------

CREATE TABLE REGIONWISE_COMPLAINTS AS 
SELECT CATEGORIES.DESCRIPTION, state_regions2.REGION FROM complains_data LEFT OUTER JOIN customers
ON complains_data.CUSTOMERID= CUSTOMERS.CUSTOMERID
LEFT OUTER JOIN REGIONS
ON customers.RegionID= REGIONS.ID
LEFT OUTER JOIN state_regions2
ON REGIONS.STATE_CODE= state_regions2.STATE_CODE
LEFT OUTER JOIN CATEGORIES
ON complains_data.ComplainCategoryID= categories.ID;


SELECT * FROM REGIONWISE_COMPLAINTS;
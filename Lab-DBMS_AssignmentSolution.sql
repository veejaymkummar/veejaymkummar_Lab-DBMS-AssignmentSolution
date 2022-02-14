/*Delete the database if it exists */
DROP Database IF EXISTS E_Commerce_DB;

/*Create the database also check for duplication*/
Create Database if not exists E_Commerce_DB;
/* After Creating Use the Database*/
Use E_Commerce_DB;

/* Create the tabcategoryle as per the specification in the assignment the lenght of the varchar i have assumed*/
/*Create Passenger table*/
CREATE TABLE `category` (
  `CAT_ID` int NOT NULL AUTO_INCREMENT,
  `CAT_NAME` varchar(255),
  PRIMARY KEY (`CAT_ID`)/* Define category ID as primary key*/
) ;

CREATE TABLE `customer` (
  `CUS__ID` int NOT NULL AUTO_INCREMENT,
  `CUS_NAME` varchar(255),
  `CUS_PHONE`  bigint,
  `CUS_CITY` varchar(255),
  `CUS_GENDER` varchar(1),
  PRIMARY KEY (`CUS__ID`) /* Define CUS__ID as primary key*/
);
 CREATE TABLE `product` (
  `PRO_ID` int NOT NULL AUTO_INCREMENT,
  `PRO_NAME` varchar(255),
  `PRO_DESC` varchar(255),
  `CAT_ID` int,
  PRIMARY KEY (`PRO_ID`), /* Define CUS__ID as primary key*/
  CONSTRAINT `CAT_ID` FOREIGN KEY (`CAT_ID`) REFERENCES `category` (`CAT_ID`) /* Define CAT_ID as foreign key from category table*/
);
CREATE TABLE `supplier` (
  `Supp_ID` int NOT NULL AUTO_INCREMENT,
  `Supp_name` varchar(255),
  `Supp_City` varchar(255),
  `Sup_Phone` bigint,
  PRIMARY KEY (`Supp_ID`) /* Define Supp_ID as primary key*/
) ;
CREATE TABLE `productdetails` (
  `PROD_ID` int NOT NULL AUTO_INCREMENT,
  `PRO_ID` int,
  `SUPP_ID` int,
  `PRICE` float,
  PRIMARY KEY (`PROD_ID`), /* Define PROD_ID as primary key*/
  CONSTRAINT `Pro_ID` FOREIGN KEY (`PRO_ID`) REFERENCES `product` (`PRO_ID`),  /* Define PRO_ID as foreign key from product table*/
  CONSTRAINT `Supp_ID` FOREIGN KEY (`SUPP_ID`) REFERENCES `supplier` (`Supp_ID`) /* Define SUPP_ID as foreign key from supplier table*/
);
CREATE TABLE `order` (
  `ORD_ID` int NOT NULL,
  `ORD_AMOUNT` float,
  `ORD_DATE` date,
  `CUS_ID` int,
  `PROD_ID` int,
  PRIMARY KEY (`ORD_ID`), /* Define ORD_ID as primary key*/
  CONSTRAINT `CUS_ID` FOREIGN KEY (`CUS_ID`) REFERENCES `customer` (`CUS__ID`),  /* Define CUS_ID as foreign key from customer table*/
  CONSTRAINT `PROD_ID` FOREIGN KEY (`PROD_ID`) REFERENCES `productdetails` (`PROD_ID`)  /* Define PROD_ID as foreign key from productdetails table*/
);

CREATE TABLE `rating` (
  `RAT_ID` int NOT NULL AUTO_INCREMENT,
  `CUS_ID` int,
  `SUPP_ID` int,
  `RAT_RATSTARS` int,
  PRIMARY KEY (`RAT_ID`), /* Define RAT_ID as primary key*/
  CONSTRAINT `CUS_ID1` FOREIGN KEY (`CUS_ID`) REFERENCES `customer` (`CUS__ID`), /* Define CUS_ID as foreign key from customer table*/
  CONSTRAINT `SUPP_ID1` FOREIGN KEY (`SUPP_ID`) REFERENCES `supplier` (`Supp_ID`) /* Define SUPP_ID as foreign key from supplier table*/
);

/* Inserting the data s per the Assignment Document */
Insert into Supplier ( Supp_Name, Supp_City, Sup_Phone)
VALUES
('Rajesh Retails','Delhi',1234567890),
('Appario Ltd.','Mumbai',2589631470),
('Knome products','Banglore',9785462315),
('Bansal Retails',"Kochi",8975463285),
('Mittal Ltd.','Lucknow',7898456532);

/* Displaying the inserted data */
SELECT * from Supplier;

/* Inserting the data as per the Assignment Document */
Insert into Customer ( CUS_Name, CUS_Phone, CUS_City, CUS_Gender)
VALUES
('AAKASH',9999999999,'DELHI','M'),
('AMAN',9785463215,'NOIDA','M'),
('NEHA',9999999999,'MUMBAI','F'),
('MEGHA',9994562399,'KOLKATA','F'),
('PULKIT',7895999999,'LUCKNOW','M');
/* Displaying the inserted Data */
SELECT * from Customer;

/* Inserting the data as per the Assignment Document */
Insert into Category (CAT_Name)
VALUES
('BOOKS'),
('GAMES'),
('GROCERIES'),
('ELECTRONICS'),
('CLOTHES');
/* Dispalying the Inserted Data*/
SELECT * from CATEGORY;

/* Inserting the data as per the Assignment Document */
Insert into product( Pro_Name, Pro_Desc, Cat_ID)
VALUES
('GTA V','DFJDJFDJFDJFDJFJF',2),
('TSHIRT','DFDFJDFJDKFD',5),
('ROG LAPTOP','DFNTTNTNTERND',4),
('OATS','REURENTBTOTH',3),
('HARRY POTTER','NBEMCTHTJTH',1);
/* Displaying the inserted data */
SELECT * from PRODUCT;

/* Inserting the data as per the Assignment Document */
Insert into ProductDetails (Pro_ID, Supp_ID, Price)
VALUES
(1,2,1500),
(3,5,30000),
(5,1,3000),
(2,3,2500),
(4,1,1000);

/* Displaying the inserted data */
SELECT * from Productdetails;

/* Inserting the data as per the Assignment Document */
Insert into `order`(ORD_ID,Ord_Amount, Ord_Date, Cus_ID, Prod_ID)
VALUES
/* using str_to_date function to read string and conver the string into date using the data format as second argument */
(20,1500,str_to_date('2021-10-12','%Y-%m-%d'),3,5),
(25,30500,str_to_date('2021-09-16','%Y-%m-%d'),5,2),
(26,2000,str_to_date('2021-10-05','%Y-%m-%d'),1,1),
(30,3500,str_to_date('2021-08-16','%Y-%m-%d'),4,3),
(50,2000,str_to_date('2021-10-06','%Y-%m-%d'),2,1);

/* Displaying the inserted Data */
SELECT * from e_commerce_db.order;

/* Inserted the Data as per the assignment Document*/
Insert into rating (CUS_ID, SUPP_ID,RAT_RATSTARS)
VALUES
(2,2,4),
(3,4,3),
(5,1,5),
(1,3,2),
(4,5,4);
/* Displaying the inserted Data */
SELECT * from rating;

/* Q3 Display the number of the customer group by their genders who have placed 
any order of amount greater than or equal to Rs.3000. */
SELECT Customer.CUS_GENDER, COUNT(Customer.CUS__ID) AS Count_of_Customer
FROM Customer INNER JOIN e_commerce_db.Order ON Customer.CUS__ID = 'Order.CUS_ID'
WHERE (e_commerce_db.Order.ORD_AMOUNT >= 3000)
GROUP BY Customer.CUS_GENDER;

/*Q4 Display all the orders along with the product name ordered by a customer having Customer_Id=2.*/
SELECT Customer.CUS__ID as 'Customer ID', Customer.CUS_NAME as 'Customer Name', 
e_commerce_db.Order.ORD_AMOUNT as 'Order Amount', Product.PRO_NAME as 'Product Name'
FROM ProductDetails INNER JOIN
/* Join the order table with product details table and then product details with product table.json_table
Also Join the ORder table with Customer table for filtering the data for a particular customer*/
 e_commerce_db.Order ON ProductDetails.PROD_ID = e_commerce_db.Order.PROD_ID INNER JOIN
 Product ON ProductDetails.PRO_ID = Product.PRO_ID INNER JOIN
 Customer ON e_commerce_db.Order.CUS_ID = Customer.CUS__ID
WHERE (Customer.CUS__ID = 2);

/* Q5 Display the Supplier details who can supply more than one product.*/
SELECT Supplier.Supp_ID, Supplier.Supp_name, Supplier.Supp_City, Supplier.Sup_Phone
FROM Supplier INNER JOIN
/* join product detai9ls with supplier id to understand the capacicity of each supplier to supply more than one product 
using the count function on repetition of supplier id in the product details table */
ProductDetails ON Supplier.Supp_ID = ProductDetails.SUPP_ID
GROUP BY Supplier.Supp_ID, Supplier.Supp_name, Supplier.Supp_City, Supplier.Sup_Phone
HAVING (COUNT(ProductDetails.SUPP_ID) > 1);

/* Q6 Find the category of the product whose order amount is minimum.*/
SELECT Category.CAT_ID, Category.CAT_NAME, e_commerce_db.Order.ORD_AMOUNT
FROM ProductDetails INNER JOIN
/* Join the PRoduct details with product  and category with product to find the category of product*/
 Product ON ProductDetails.PRO_ID = Product.PRO_ID INNER JOIN
 Category ON Product.CAT_ID = Category.CAT_ID INNER JOIN
 /* also join the product details with the order table to get the order amount information*/
 e_commerce_db.Order ON ProductDetails.PROD_ID = e_commerce_db.Order.PROD_ID
 /* Filter the data basis the order amount in the order table which is equal to a subquery output of minimum order amount*/
WHERE (e_commerce_db.Order.ORD_AMOUNT = (SELECT MIN(ORD_AMOUNT) AS MinOrderAmount FROM e_commerce_db.Order AS Order_db_1));

/* Q7 Display the Id and Name of the Product ordered after “2021-10-05”.*/
SELECT Product.PRO_ID, Product.PRO_NAME, e_commerce_db.Order.ORD_DATE
FROM Product INNER JOIN
/* Join the product details table with order table to get the order date and then filter the data */
 ProductDetails ON Product.PRO_ID = ProductDetails.PRO_ID INNER JOIN
 e_commerce_db.Order ON ProductDetails.PROD_ID = e_commerce_db.Order.PROD_ID
 /* Filter the information using order date with is greater than the String to date conversion output */
WHERE (e_commerce_db.Order.ORD_DATE > str_to_date('2021-10-5','%Y-%m-%d'));

/* Q8 Display customer name and gender whose names start or end with character 'A'.*/
SELECT CUS__ID, CUS_NAME, CUS_GENDER
FROM Customer
/* Filter using two conditions 
A. Substring to find the first charecter if equal to condition in question 
B. Right function to find the last charecter is equal to the condition in question
then if either of the condition is ment using the OR operator */
Where SUBSTRING(Cus_Name,1,1) = 'A' or RIGHT(CUS_NAME,1) in ('A');

/*Q9 Create a stored procedure to display the Rating for a Supplier
 if any along with the Verdict on that rating
 if any like if rating >4 then “Genuine Supplier” 
 if rating >2 “Average Supplier” 
 else “Supplier should not be considered”.*/
 
 /*Drop the procedure if it is already existing*/
DROP Procedure if Exists SupplierVerdict;
/* Start to write a procedure*/
DELIMITER //
CREATE PROCEDURE SupplierVerdict()

/*Begining of the procedure*/
BEGIN 
SELECT Supplier.Supp_ID, Supplier.Supp_name, Rating.RAT_RATSTARS,
/* Using nested if Statement for ccheking the conditions as 
A. > 4
B. >2 and <=4
C. othere which are below or equal to 2 */
if(Rating.Rat_ratstars > 4,'Genuine Supplier',
	if(Rating.Rat_ratstars > 2 and Rating.RAT_RATSTARS <= 4,'Average Supplier', 
		'Supplier should not be considered')) as Verdict
/* This can also be achieved using the CASE conditional statements as below in the commented section itself
CASE 
    When Rating.Rat_ratstars > 4 then "Genuine Supplier'
    When Rating.Rat_ratstars > 2 or Rating.Rat_ratstars <= 4 then "Average Supplier'
    Else "Supplier should not be considered'
End as Verdict

The above CASE code block would replace the if Block
 */
 
FROM Supplier INNER JOIN

/* Inner join the supplier and rating tables to get the star rating information per supplier*/
Rating ON Supplier.Supp_ID = Rating.SUPP_ID;
END; /* End of procedure */
/*Call the procedure to display the Q9 output*/
CALL SupplierVerdict();



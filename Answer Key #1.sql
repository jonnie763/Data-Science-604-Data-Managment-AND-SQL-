use TSQLV4

-- 1. Return orders from June 2015. Tables involved: TSQLV4 database,Sales.Orders table. 

SELECT orderid, orderdate, custid, empid

FROM Sales.Orders

WHERE orderdate >= '20150601' 

 AND orderdate < '20150701';

-- 2. Calculate the total value for each order (hint--multiple qty*unitprice first, then group by each orderid) 
--and then select just those that have total value greater than 10000. 
--Please sort by total value. Tables involved: Sales.OrderDetails.

SELECT orderid, SUM(qty*unitprice) AS totalvalue

FROM Sales.OrderDetails

GROUP BY orderid

HAVING SUM(qty*unitprice) > 10000

ORDER BY totalvalue DESC;

--3. Return the three ship countries with the highest average freight for orders placed in 2015 
--Tables involved: Sales.Orders table. The output should look similar to: 

SELECT TOP (3) shipcountry, AVG(freight) AS avgfreight

FROM Sales.Orders

WHERE orderdate >= '20150101' AND orderdate < '20160101'

GROUP BY shipcountry

ORDER BY avgfreight DESC;

--4. Write a query that returns employees who did not place orders on or after May 1st, 2016. T
--Tables involved: TSQLV4 database, Employees and Orders tables. The output should look similar to:

select E.empid, E.firstname, E.lastname

from [TSQLV4].[HR].[Employees] as E

where e.empid not in

(select o.empid from [TSQLV4].[Sales].[Orders] as o

where o.orderdate >= '20160501')

--5. Write a query statement that generates 5 copies out of each employee row- 
--Tables involved: TSQLV4 database, Employees and Nums tables. 
--Yes, I am asking to duplicate the data for each employee, five times. The output should look similar to: 

SELECT E.empid, E.firstname, E.lastname, N.n

FROM HR.Employees AS E

 CROSS JOIN dbo.Nums AS N 

WHERE N.n <= 5

ORDER BY n, empid;

--6. Use a SELECT INTO statement to create and populate a new table Sales.
-- Order14To16 with orders from the Sales.Orders that were placed in the years 2014 through 2016.

DROP TABLE IF EXISTS dbo.Orders;

SELECT *

INTO dbo.Orders

FROM Sales.Orders

WHERE orderdate >= '20140101'

 AND orderdate < '20170101';

--7. Alter the table in step 7 to add an integer column called ‘FiscalYear.’ 
--Use an UPDATE statement to set the value of FiscalYear column to equal the year the order was placed except that
--if the month is October, November, or December you will add one year to the year.  

-- Include the SQL Queries for both (one to alter the table and the second to update the value)

ALTER TABLE dbo.Orders

ADD FiscalYear_1 int



--8. Optional Extra Credit Question: Return all customers, and for each return a Yes/No value depending on whether the customer placed an order on Feb 12, 2016. 
-- Tables involved: TSQLV4 database, Customers and Orders tables. 

SELECT DISTINCT C.custid, C.companyname, 

 CASE WHEN O.orderid IS NOT NULL THEN 'Yes' ELSE 'No' END AS HasOrderOn20160212

FROM Sales.Customers AS C

 LEFT OUTER JOIN Sales.Orders AS O

  ON O.custid = C.custid

  AND O.orderdate = '20160212';

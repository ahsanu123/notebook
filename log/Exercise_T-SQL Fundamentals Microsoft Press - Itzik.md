# Exercise T-SQL Fundamentals Microsoft Press - Itzik Ben-Gan

## Chapter 2, Single Table Query
### [1 Agustus 2023] Exercise 1
1. Write a query against the Sales.Orders table that returns orders placed in June 2021
```sql
USE TSQLV6;
SELECT 
    orderid, 
    orderdate,
    custid, 
    empid
FROM Sales.Orders
WHERE MONTH(orderdate) = 6 AND YEAR(2021);
```

### Exercise 2
1. Write a query against the Sales.Orders table that returns orders placed on the day before the last day of the month:
```sql
USE TSQLV6;
SELECT 
    orderid, 
    orderdate, 
    custid, 
    empid
FROM Sales.Orders
WHERE DAY(orderdate) 
BETWEEN 
    CASE
        WHEN MONTH(orderdate) % 2 = 0 AND MONTH(orderdate) != 2 THEN 29
        WHEN MONTH(orderdate) % 2 = 1 AND MONTH(orderdate) != 2 THEN 30
        ELSE 27
    END 
AND 
    CASE
        WHEN MONTH(orderdate) % 2 = 0 AND MONTH(orderdate) != 2 THEN 30
        WHEN MONTH(orderdate) % 2 = 1 AND MONTH(orderdate) != 2 THEN 31
        ELSE 28
    END;
```
### Exercise 3
1. Write a query against the HR.Employees table that returns employees with a last name containing the letter e twice or more:

```sql
USE TSQLV6;
SELECT  
    empid,
    firstname,
    lastname

FROM HR.Employees
WHERE lastname LIKE '%e%e%';
```

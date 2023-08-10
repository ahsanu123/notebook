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

## Chapter 3, Join
### [2 Agustus 2023] Exercise 3
Return US customers, and for each customer return the total number of orders and total quantities:
```SQL
USE TSQLV6;

SELECT C.custid, COUNT(DISTINCT O.orderid) AS numorders, SUM(OD.qty) AS totalqty
FROM Sales.Customers AS C
    INNER JOIN Sales.Orders         AS O ON C.custid = O.custid
    INNER JOIN Sales.OrderDetails   AS OD ON O.orderid = OD.orderid
WHERE C.country = N'USA'
GROUP BY C.custid;
```
### Excercicse 4
Return customers and their orders, including customers who placed no orders
```SQL
USE TSQLV6;

SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O
    ON C.custid = O.custid;

```

### Excercise 5 
Return customers who placed no orders
```SQL
USE TSQLV6;

SELECT C.custid, C.companyname
FROM Sales.Customers AS C
    LEFT OUTER JOIN Sales.Orders AS O ON C.custid = O.custid 
WHERE O.orderid IS NULL;

```

### Excercise 6 

Return Customer With orders placed on February 12, 2022, along with their orders
```SQL
SELECT C.custid, C.companyname, O.orderid, O.orderdate
FROM Sales.Customers AS C 
    INNER JOIN Sales.Orders AS O ON C.custid = O.custid

WHERE O.orderdate = '20220212';
```

### Excercise 9 
Return all customers, and for each return a Yes/No value depending on whether the customer placed orders on February 12, 2022:

```SQL
USE TSQLV6;

SELECT C.custid, C.companyname, 
    CASE
        WHEN O.orderid IS NOT NULL 
            THEN 'YES'
        ELSE 'NO' 
    END AS HasAnOrders
FROM Sales.Customers AS C
LEFT OUTER JOIN Sales.Orders AS O 
    ON  O.custid = C.custid 
    AND O.orderdate = '20220212';
```
## Chapter 4, Sub Queris
### Exercise 3

```SQL
USE TSQLV6;

SELECT H.empid, H.firstname, H.lastname
FROM HR.Employees AS H
WHERE H.empid NOT IN 
(
    SELECT O.empid
    FROM Sales.Orders AS O
    where O.orderdate > '20220501'
);
```

## Chapter 5, Table Expression
### [9 Agustus 2023] Note
select growth of `customer` from previous year compared to this year.
```SQL
USE TSQLV6;

SELECT 
    Cur.orderyear   AS currentYear,
    Prv.orderyear   AS prevYear,
    Cur.numcust     AS curentnumcust,
    Prv.numcust     AS prevnumcust,
    Cur.numcust - Prv.numcust AS growth
FROM
(
    SELECT  YEAR(orderdate) AS orderyear, 
            COUNT(DISTINCT custid) AS numcust
    FROM    Sales.Orders
    GROUP BY YEAR(orderdate)
) AS Cur 

LEFT OUTER JOIN 
(
    SELECT  YEAR(orderdate) AS orderyear, 
            COUNT(DISTINCT custid) AS numcust 
    FROM Sales.Orders 
    GROUP BY YEAR(orderdate) 
) AS Prv 

ON Cur.orderyear = Prv.orderyear + 1;
```

### [10 Agustus 2023] Note `View`
 - View digunakan untuk menampilkan queri dari table dengan filter tertentu (seperti negara asal, dll)
 - untuk membuat view dapat digunakan `CREATE OR ALTER VIEW namedatabase`
 - secara default sql dapat mengakses dan merubah atau pun menambahkan data melalui view, **namun** hal ini tidak disarankan karena, jika mengubah atau menambahkan ke tabel **yg tidak sesuai filter** maka tidak akan tertampil di view.
 - untuk membatasi penambahan maupun perubahan di view dapat digunakan `WITCH CHECK OPTION` diakhir query
 - secara default, colom dari tabel asli di view dapat dihapus oleh sql, sehingga ketika view dieksekusi kembali dapat menyebabkan error, untuk membatasi penghapusan colom pada tabel asal, dapat digunakan `WITH SCHEMABINGING`.
 - untuk menghapus view dapat digunakan `DELETE VIEW viewname`








------------------------------------------------
-- Project: Advanced SQL Business Analysis
-- Dataset: Northwind
-- Author: Preksha
-- Description:
-- Advanced business analysis queries using CTEs, window functions, ranking, customer segmentation, and revenue analysis.
--------------------------------------------------


--Task 1: Customers with Zero Discount

SELECT c.CustomerID, c.CompanyName, 
		COUNT(o.OrderID) AS NumberOfOrders
FROM Customers c
JOIN Orders o
	ON c.CustomerID = o.CustomerID
JOIN [Order Details] OD
	ON o.OrderID = OD.OrderID
GROUP BY c.CustomerID, c.CompanyName
HAVING MAX(OD.Discount) = 0
ORDER BY NumberOfOrders DESC
GO

--Task 2: Top 3 Per Country

 WITH CustomerRevenue AS (SELECT c.CustomerID, 
								c.CompanyName, 
								c.Country, 
								SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Revenue
						  FROM Customers c
						  JOIN Orders o
						  ON c.CustomerID = o.CustomerID
						  JOIN [Order Details] OD
						  ON o.OrderID = OD.OrderID
						  GROUP BY  c.CustomerID, c.CompanyName, c.Country
						  ),
RankedCustomers AS (SELECT CustomerID, 
							CompanyName, 
							Country, 
							Revenue,
							DENSE_RANK() OVER(PARTITION BY Country ORDER BY Revenue DESC) AS CountryRank
					FROM CustomerRevenue
					)
SELECT CustomerID, CompanyName, Country, Revenue, CountryRank
FROM RankedCustomers
WHERE CountryRank <= 3
Order BY Country, CountryRank
GO

--Task 3: Running Total Revenue

WITH CustomerMonths AS (SELECT YEAR(o.OrderDate) AS OrderYear, 
								MONTH(o.OrderDate) AS OrderMonth, 
								SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS Revenue
						FROM Orders o
						JOIN [Order Details] OD
						ON o.OrderID = OD.OrderID
						GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
						),
RunningTotal AS (SELECT OrderYear, 
						OrderMonth, 
						Revenue, 
						SUM(Revenue) OVER(ORDER BY OrderYear, OrderMonth) AS RunningRevenue
				FROM CustomerMonths
				)
SELECT OrderYear,
		OrderMonth,
		Revenue,
		RunningRevenue
FROM RunningTotal
ORDER BY OrderYear, OrderMonth
GO

--Task 4: Repeat vs One time

SELECT c.CustomerID, c.CompanyName,
		COUNT(o.OrderID) AS NumberOfOrders,
		CASE
			WHEN COUNT(o.OrderID) = 1 THEN 'One Time'
			ELSE 'Repeat'
		END AS CustomerType
FROM Customers c
JOIN Orders o
	ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.CompanyName
GO

--Task 5: Monthly Revenue Trend

SELECT YEAR(o.OrderDate) AS OrderYear, 
		MONTH(o.OrderDate) AS OrderMonth, 
		DATENAME(MONTH, o.OrderDate) AS MonthName,
		SUM(OD.Quantity * OD.UnitPrice * (1 - OD.Discount)) AS TotalRevenue
FROM Orders o
JOIN [Order Details] OD
	ON o.OrderID = OD.OrderID
GROUP BY YEAR(o.OrderDate), 
		MONTH(o.OrderDate),
		DATENAME(MONTH, o.OrderDate)
ORDER BY OrderYear, 
		OrderMonth
GO

--Task 6: Consecutive Month Orders

WITH CustomerMonths AS (SELECT DISTINCT CustomerID, 
									YEAR(OrderDate) AS OrderYear,
									MONTH(OrderDate) AS OrderMonth
						FROM Orders),
ConsecutiveMonths AS (SELECT CustomerID,
							OrderYear,
							OrderMonth,
							LAG(OrderYear) OVER(PARTITION BY CustomerID ORDER BY OrderYear, OrderMonth) AS PreviousYear,
							LAG(OrderMonth) OVER(PARTITION BY CustomerID ORDER BY OrderYear, OrderMonth) AS PreviousMonth
					FROM CustomerMonths)
SELECT CustomerID,
		OrderYear,
		OrderMonth,
		PreviousYear,
		PreviousMonth
FROM ConsecutiveMonths
WHERE OrderYear = PreviousYear
AND OrderMonth = PreviousMonth + 1
GO



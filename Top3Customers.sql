USE WideWorldImporters;
GO

SELECT TOP 3
    c.CustomerID,
    c.CustomerName,
    SUM(ct.TransactionAmount) AS TotalTransactionAmount
FROM
    Sales.CustomerTransactions ct
JOIN
    Sales.Customers c ON ct.CustomerID = c.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY
    TotalTransactionAmount DESC;

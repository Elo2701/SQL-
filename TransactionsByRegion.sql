---List all customer transactions with transaction types and customer region details,
---filtered by a specific region (e.g., “Oakview”).
USE WideWorldImporters;
GO

SELECT
    ct.CustomerTransactionID,
    c.CustomerName,
    tt.TransactionTypeName,
    ct.TransactionDate,
    ct.TransactionAmount,
    sp.StateProvinceName AS RegionName
FROM
    Sales.CustomerTransactions ct
JOIN
    Sales.Customers c ON ct.CustomerID = c.CustomerID
JOIN
    Application.TransactionTypes tt ON ct.TransactionTypeID = tt.TransactionTypeID

JOIN
    Application.Cities dc ON c.DeliveryCityID = dc.CityID


JOIN
    Application.StateProvinces sp ON dc.StateProvinceID = sp.StateProvinceID

WHERE
    sp.StateProvinceName = 'Alabama'
ORDER BY
    ct.TransactionDate DESC;

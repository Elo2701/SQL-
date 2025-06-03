USE WideWorldImporters;
GO
---Calculate total invoice amounts and payments per customer to date.
SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(il.Quantity * il.UnitPrice) AS TotalInvoiced,
    ISNULL(SUM(ct.TransactionAmount), 0) AS TotalPaid
FROM
    Sales.Customers c
JOIN
    Sales.Invoices i ON c.CustomerID = i.CustomerID
JOIN
    Sales.InvoiceLines il ON i.InvoiceID = il.InvoiceID
LEFT JOIN
    Sales.CustomerTransactions ct ON ct.CustomerID = c.CustomerID
    AND ct.TransactionTypeID IN (1, 2)  -- Adjust these IDs for payment types
GROUP BY
    c.CustomerID, c.CustomerName;

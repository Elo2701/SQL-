--Identify customers with outstanding invoices and calculate the total outstanding
--amounts, the total invoiced, and the total paid for those customers.

USE WideWorldImporters;
GO

WITH InvoiceSummary AS (
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
        AND ct.TransactionTypeID IN (1, 2)  -- Adjust IDs for payment transactions
    GROUP BY
        c.CustomerID, c.CustomerName
)
SELECT
    CustomerID,
    CustomerName,
    TotalInvoiced,
    TotalPaid,
    (TotalInvoiced - TotalPaid) AS OutstandingAmount
FROM
    InvoiceSummary
WHERE
    (TotalInvoiced - TotalPaid) > 0;

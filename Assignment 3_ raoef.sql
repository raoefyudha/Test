USE OOVEO_Salon
--Name : Abdul Raoef Yudha Qurnia
--DiscordName: raoef

-- NUMBER 1
SELECT MAX(Price) AS [Maximum Price], 
MIN(Price) AS[Minimum Price], 
CAST(ROUND(AVG(Price),0)AS DECIMAL(11,2) ) AS [Average Price]
FROM MsTreatment

-- NUMBER 2
SELECT StaffPosition, 
LEFT(StaffGender,1) AS [Gender], 'Rp. ' +
CONVERT(varchar,CAST(AVG(StaffSalary) AS DECIMAL(11,2))) AS AverageSalary
FROM MsStaff
GROUP BY StaffPosition,StaffGender

-- Number 3
SELECT CONVERT(varchar,TransactionDate,107) 
AS [TransactionDate],
COUNT(TransactionId) AS [Total Transaction per Day]
FROM HeaderSalonServices
GROUP BY  TransactionDate

-- Number 4
SELECT UPPER(CustomerGender) AS [CustomerGender],
COUNT(TransactionId) AS [Total Transaction]
FROM MsCustomer mc JOIN HeaderSalonServices hss ON
mc.CustomerId = hss.CustomerId 
GROUP BY CustomerGender

--Number 5
SELECT TreatmentTypeName, COUNT(hss.TransactionId) 
AS [Total Transaction] 
FROM HeaderSalonServices hss JOIN 
DetailSalonServices dss ON 
hss.TransactionId = dss.TransactionId
JOIN MsTreatment mt ON 
dss.TreatmentId = mt.TreatmentId JOIN
MsTreatmentType mtp ON 
mt.TreatmentTypeId = mtp.TreatmentTypeId
GROUP BY TreatmentTypeName
ORDER BY  COUNT(hss.TransactionId)DESC

-- Number 6
SELECT CONVERT(varchar,TransactionDate,106) AS[Date], 
SUM(Price) AS [Revenue per Day]
FROM HeaderSalonServices hss 
JOIN DetailSalonServices dss 
ON hss.TransactionId = dss.TransactionId
JOIN MsTreatment mt 
ON dss.TreatmentId = mt.TreatmentId
GROUP BY TransactionDate
HAVING SUM(Price) BETWEEN 1000000 AND 5000000

-- Number 7
SELECT REPLACE(mt.TreatmentTypeId, 'TT0', 'Treatment Type ') 
AS [ID], 
TreatmentTypeName, 
CAST(COUNT(TreatmentId) AS varchar) + ' Treatment' 
AS [Total Treatment per Type]
FROM MsTreatmentType mtp JOIN MsTreatment mt 
ON mt.TreatmentTypeId = mtp.TreatmentTypeId
GROUP BY mt.TreatmentTypeId, TreatmentTypeName
HAVING COUNT(TreatmentId) > 5
ORDER BY COUNT(TreatmentId) DESC

-- Number 8
SELECT LEFT(StaffName, CHARINDEX(' ', StaffName )) 
AS [StaffName], 
dss.TransactionId, 
COUNT(dss.TreatmentId) AS [Total Treatment per Transaction] 
FROM MsStaff mff 
JOIN HeaderSalonServices hss 
ON mff.StaffId = hss.StaffId 
JOIN DetailSalonServices dss
ON hss.TransactionId = dss.TransactionId 
GROUP BY StaffName ,dss.TransactionId

-- Number 9
SELECT TransactionDate, CustomerName, TreatmentName, Price 
FROM MsCustomer mc 
JOIN HeaderSalonServices hss 
ON mc.CustomerId = hss.CustomerId
JOIN DetailSalonServices dss 
ON hss.TransactionId = dss.TransactionId
JOIN MsTreatment mt 
ON mt.TreatmentId = dss.TreatmentId
JOIN MsStaff mff
ON mff.StaffId = hss.StaffId
WHERE DATENAME(WEEKDAY, TransactionDate) like 'Thursday' AND 
StaffName like '%Ryan%'
ORDER BY TransactionDate, CustomerName ASC

-- Number 10
SELECT TransactionDate, CustomerName,
SUM(Price) AS [Total Price]
FROM MsCustomer mc 
JOIN HeaderSalonServices hss 
ON mc.CustomerId = hss.CustomerId 
JOIN DetailSalonServices dss
ON hss.TransactionId = dss.TransactionId 
JOIN MsTreatment mt ON
dss.TreatmentId = mt.TreatmentId
WHERE DAY(TransactionDate) > 20
GROUP BY TransactionDate, CustomerName
ORDER BY TransactionDate ASC













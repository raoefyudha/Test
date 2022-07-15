use OOVEO_Salon
-- asg 2 , discord name raoef, full name: Abdul Raoef Yudha Qurnia 

-- number 1
SELECT * FROM MsStaff
WHERE StaffGender like 'Female'

-- number 2
SELECT StaffName, 'Rp. ' + CAST(StaffSalary AS varchar)
AS StaffSalary
FROM MsStaff
WHERE StaffName like 'm%' 

-- number 3
SELECT TreatmentName, Price 
FROM MsTreatment mt JOIN MsTreatmentType mtt ON
mt.TreatmentTypeId = mtt.TreatmentTypeId
WHERE mt.TreatmentTypeId IN ('TT002', 'TT003')

-- number 4
SELECT StaffName, StaffPosition, 
CONVERT(varchar,TransactionDate,107) as [Transaction Date] 
FROM MsStaff mff JOIN HeaderSalonServices hss ON
mff.StaffId = hss.StaffId
WHERE StaffSalary BETWEEN 7000000 AND 10000000

-- number 5
SELECT SUBSTRING( CustomerName, 1 , CHARINDEX(' ',CustomerName) ) AS [Name]
, LEFT(CustomerGender,1) AS Gender, PaymentType 
FROM MsCustomer mc JOIN HeaderSalonServices hss ON
mc.CustomerId = hss.CustomerId
WHERE PaymentType like 'Debit'

-- number 6
SELECT UPPER(LEFT(CustomerName,1)) + 
SUBSTRING(CustomerName, (CHARINDEX( ' ', CustomerName) + 1), 1) AS Initial,
DATENAME(WEEKDAY,TransactionDate) as [Day]
FROM MsCustomer mc JOIN HeaderSalonServices hss ON
mc.CustomerId = hss.CustomerId 
WHERE DATEDIFF (DAY,(TransactionDate), '2012/12/24') < 3

-- number 7
SELECT TransactionDate, 
RIGHT(CustomerName,5) + 
SUBSTRING(REVERSE(CustomerName), (CHARINDEX( ' ', CustomerName)), 0) AS [CustomerName]
FROM HeaderSalonServices hss JOIN MsCustomer mc ON
hss.CustomerId = mc.CustomerId 
WHERE CustomerName like '% %' AND
DATENAME(WEEKDAY,TransactionDate) like 'Saturday' 

-- number 8
SELECT StaffName, CustomerName, [CustomerPhone] =
REPLACE(CustomerPhone,'0','+62') , CustomerAddress
FROM MsStaff mff JOIN HeaderSalonServices hss ON
mff.StaffId =hss.StaffId JOIN MsCustomer mc 
ON hss.CustomerId = mc.CustomerId
WHERE mff.StaffName like '% % %'
AND CustomerName like '[aiueo]%[AIUEO]'

-- number 9
SELECT StaffName, TreatmentName,
DATEDIFF (DAY,(TransactionDate), '2012/12/24') 
as [Term of Transaction]
FROM MsStaff mff JOIN HeaderSalonServices hss ON
mff.StaffId = hss.StaffId JOIN DetailSalonServices dss ON
hss.TransactionId = dss.TransactionId JOIN MsTreatment mt ON
dss.TreatmentId = mt.TreatmentId 
WHERE LEN(TreatmentName) > 20 OR
TreatmentName like '% %'

-- number 10
SELECT TransactionDate, CustomerName, TreatmentName, 
CAST(Price AS int) * 2/10 AS Discount
, PaymentType
FROM HeaderSalonServices hss JOIN MsCustomer mc ON
hss.CustomerId = mc.CustomerId JOIN DetailSalonServices dss ON
hss.TransactionId = dss.TransactionId JOIN MsTreatment mt ON
dss.TreatmentId = mt.TreatmentId
WHERE DAY(TransactionDate) = 22


USE OOVEO_Salon

-- 1
SELECT TreatmentId,TreatmentName
FROM MsTreatment
WHERE TreatmentId IN ('TM001','TM002')

-- 2
SELECT mt.TreatmentName, mt.Price FROM MsTreatment mt 
WHERE mt.TreatmentTypeId  in (
	SELECT mtt.TreatmentTypeid
	FROM MsTreatmentType mtt
	WHERE TreatmentTypeName NOT IN 
	('Hair Treatment','Message / Spa')
)

-- 3
SELECT CustomerName,CustomerPhone,CustomerAddress  
FROM MsCustomer mc
WHERE mc.CustomerId IN(
	SELECT hss.CustomerId 
	FROM HeaderSalonServices hss
	WHERE LEN(CustomerName) > 8 AND 
	DATENAME(WEEKDAY,TransactionDate) like 'Friday'
)
--4
SELECT mtt.TreatmentTypeName, mt.TreatmentName,mt.Price 
FROM MsTreatment mt, MsTreatmentType mtt
WHERE mt.TreatmentTypeId = mtt.TreatmentTypeId
AND mt.TreatmentId IN (
	SELECT dss.TreatmentId 
	FROM DetailSalonServices dss
	WHERE dss.TransactionId IN (
		SELECT hss.TransactionId
		FROM HeaderSalonServices hss
		WHERE hss.CustomerId IN (
			SELECT mc.CustomerId
			FROM MsCustomer mc
			WHERE mc.CustomerName like '%Putra'
			AND DAY(hss.TransactionDate) = 22
		)
	)
)

-- 5
SELECT StaffName, CustomerName, 
CONVERT(varchar,TransactionDate,107) AS [TrasactionDate]
FROM MsStaff ms 
JOIN HeaderSalonServices hss 
ON ms.StaffId = hss.StaffId 
JOIN MsCustomer mc 
ON hss.CustomerId = mc.CustomerId 
WHERE EXISTS (
SELECT TreatmentId FROM DetailSalonServices dss 
WHERE dss.TransactionId = hss.TransactionId
AND RIGHT(TreatmentId,1) IN (0,2,4,6,8)
)

-- 6 
SELECT CustomerName, CustomerPhone, CustomerAddress 
FROM MsCustomer mc JOIN HeaderSalonServices hss ON
mc.CustomerId = hss.CustomerId
WHERE EXISTS (
	SELECT StaffName FROM MsStaff ms
	WHERE ms.StaffId = hss.StaffId
	AND LEN(StaffName) % 2 <> 0
)

-- 7 
SELECT [ID] = RIGHT(ms.StaffId,3), 
SUBSTRING(StaffName, CHARINDEX (' ', StaffName) , 
CHARINDEX (' ', StaffName, CHARINDEX (' ', StaffName) ) + 2 ) AS [Name] 
FROM MsStaff ms 
JOIN HeaderSalonServices hss
ON ms.StaffId = hss.StaffId 
JOIN MsCustomer mc 
ON hss.CustomerId = mc.CustomerId
WHERE LEN(StaffName) > 15
AND EXISTS (
	SELECT StaffId FROM MsStaff ms
	WHERE ms.StaffId = hss.StaffId
	AND CustomerGender not like 'Male'
	OR CustomerGender like 'Female'	
)

-- 8
SELECT TreatmentTypeName, TreatmentName, Price 
FROM MsTreatment mt, MsTreatmentType mtt, 
(
	SELECT [avg] = AVG(Price) 
	FROM MsTreatment
) as avg_price
WHERE mt.TreatmentTypeId = mtt.TreatmentTypeId
AND Price > avg_price.[avg]

-- 9
SELECT StaffName, StaffPosition, StaffSalary 
FROM MsStaff ms,
(
	SELECT [mx] = MAX(StaffSalary), 
	[mn] = MIN(StaffSalary)
	FROM MsStaff
) as minmax
WHERE StaffSalary = minmax.[mx] 
OR  StaffSalary = minmax.[mn]

-- 10
SELECT CustomerName, CustomerPhone, 
CustomerAddress, alias1.ct as[Count Treatment]
FROM MsCustomer mc 
JOIN HeaderSalonServices hss 
ON mc.CustomerId = hss.CustomerId,
(
	SELECT [ct] = COUNT(TreatmentId),TransactionId
	FROM DetailSalonServices dss
	GROUP BY TransactionId
) alias1,

(
	SELECT [mx]= MAX(c.ct) FROM 
	(
	SELECT [ct] = COUNT(TreatmentId),TransactionId
	FROM DetailSalonServices dss
	GROUP BY TransactionId
	)c
) alias2
WHERE hss.TransactionId = alias1.TransactionId
AND alias1.ct = alias2.mx



























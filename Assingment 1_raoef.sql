USE ASG_1


-- NUMBER 1.
CREATE TABLE MsCustomer (
	CustomerId char(5) 
	PRIMARY KEY CHECK 
	(CustomerId like 'CU[0-9][0-9][0-9]' ),
	CustomerName varchar(50),
	CustomerGender varchar(10) 
	CHECK 
	(CustomerGender like 'Male' OR CustomerGender like 'Female'),
	CustomerPhone varchar(13),
	CustomerAddress varchar(100)
)

CREATE TABLE MsStaff (
	StaffId char(5) 
	PRIMARY KEY CHECK 
	(StaffId like 'SF[0-9][0-9][0-9]'),
	StaffName varchar(50),
	StaffGender varchar(10) 
	CHECK 
	(StaffGender like 'Male' OR StaffGender like 'Female'),
	StaffPhone varchar(13),
	StaffAddress varchar(100),
	StaffSalary numeric(11,2),
	StaffPosition varchar(20)
)

CREATE TABLE MsTreatmentType (
	TreatmentTypeId char(5) 
	PRIMARY KEY CHECK 
	(TreatmentTypeId like 'TT[0-9][0-9][0-9]'),
	TreatmentTypeName varchar(50)

)

CREATE TABLE MsTreatment(
	TreatmentId char(5) 
	PRIMARY KEY CHECK 
	(TreatmentId like 'TR[0-9][0-9][0-9]'), 
	TreatmentTypeId char(5) REFERENCES MsTreatmentType
	(TreatmentTypeId) ON UPDATE CASCADE CHECK 
	(TreatmentTypeId like 'TT[0-9][0-9][0-9]'),
	TreatmentName varchar(50),
	Price numeric(11,2)
)

CREATE TABLE HeaderSalonServices (
	TransactionId char(5) PRIMARY KEY CHECK 
	(TransactionId like 'TR[0-9][0-9][0-9]'),
	CustomerId char(5) REFERENCES MsCustomer
	(CustomerId) ON UPDATE CASCADE CHECK 
	(CustomerId like 'CU[0-9][0-9][0-9]' ),
	StaffId char(5) 
	REFERENCES MsStaff(StaffId) ON UPDATE CASCADE CHECK 
	(StaffId like 'SF[0-9][0-9][0-9]'),
	TransactionDate DATE,
	PaymentType varchar(25)
)


CREATE TABLE DetailSalonServices (
	TransactionId char(5) REFERENCES HeaderSalonServices  
	(TransactionId) CHECK 
	(TransactionId like 'TR[0-9][0-9][0-9]'),
	TreatmentId char(5) REFERENCES MsTreatment (TreatmentId) 
	CHECK (TreatmentId like 'TR[0-9][0-9][0-9]'),
	PRIMARY KEY (TransactionId, TreatmentId)
)

-- NUMBER 2
DROP TABLE DetailSalonServices

-- NUMBER 3
CREATE TABLE DetailSalonServices (
	TransactionId char(5) REFERENCES HeaderSalonServices  
	(TransactionId) CHECK 
	(TransactionId like 'TR[0-9][0-9][0-9]'),
	TreatmentId char(5) REFERENCES MsTreatment (TreatmentId) 
	CHECK (TreatmentId like 'TR[0-9][0-9][0-9]')
)
ALTER TABLE DetailSalonServices
ADD CONSTRAINT PK_DSS PRIMARY KEY (TransactionId, TreatmentId)

-- NUMBEER 4
ALTER TABLE MsStaff
ADD CONSTRAINT St_Nm CHECK (StaffName > 5 OR StaffName < 20)

ALTER TABLE MsStaff
NOCHECK CONSTRAINT St_Nm

ALTER TABLE MsStaff
DROP CONSTRAINT St_Nm

-- NUMBER 5
ALTER TABLE MsTreatment
ADD [Description] varchar(100) 

ALTER TABLE MsTreatment
DROP Column [Description]




BEGIN TRAN
ROLLBACK
COMMIT

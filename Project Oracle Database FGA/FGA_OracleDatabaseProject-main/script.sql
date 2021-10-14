DROP TABLE SalaryHistory;
DROP TABLE BalanceHistory;
DROP TABLE Transaction;
DROP TABLE PaymentType;
DROP TABLE Driver cascade constraints;
DROP TABLE Vehicle cascade constraints;
DROP TABLE Users;
DROP TABLE VehicleName cascade constraints;


-- DDL --
CREATE TABLE balancehistory (
 	datecreated  DATE NOT NULL,
    	balance      NUMBER(8, 2) NOT NULL,
    	users_userid INTEGER NOT NULL,
	CONSTRAINT balance_check CHECK (balance   > 0)
);

CREATE TABLE driver (
  	driverid          INTEGER NOT NULL,
   	driverphonenumber VARCHAR2(16) NOT NULL,
    	driveremail       VARCHAR2(255) NOT NULL,
    	firtstname        VARCHAR2(255),
    	lastname          VARCHAR2(255),
    	gender            VARCHAR2(16) NOT NULL,
    	dob               DATE NOT NULL,
    	pob               VARCHAR2(255),
    	nationality       VARCHAR2(255) NOT NULL,
    	startdate         DATE NOT NULL,
    	address           VARCHAR2(255) NOT NULL,
    	vehicle_vehicleid INTEGER,
	CONSTRAINT driver_pk PRIMARY KEY ( driverid )
);

CREATE TABLE paymenttype (
    	paymenttypeid INTEGER NOT NULL,
    	paymentname   VARCHAR2(64) NOT NULL,
	CONSTRAINT paymenttype_pk PRIMARY KEY ( paymenttypeid )
);

CREATE TABLE salaryhistory (
    	datecreated     DATE,
    	salary          NUMBER(10, 2) NOT NULL,
    	driver_driverid INTEGER NOT NULL,
	CONSTRAINT salary_check CHECK (salary  > 0)
);

CREATE TABLE transaction (
    	transactionid             INTEGER NOT NULL,
    	ratinggiven               NUMBER(2, 2),
    	pickuppoint               VARCHAR2(255) NOT NULL,
    	destination               VARCHAR2(255) NOT NULL,
    	tip                       NUMBER(10, 2),
    	driver_driverid           INTEGER NOT NULL,
    	paymenttype_paymenttypeid INTEGER NOT NULL,
    	users_userid              INTEGER NOT NULL,
	CONSTRAINT transaction_pk PRIMARY KEY ( transactionid )
);

CREATE TABLE users (
    	userid          INTEGER NOT NULL,
    	userphonenumber VARCHAR2(16) NOT NULL,
    	useremail       VARCHAR2(255) NOT NULL,
    	firstname       VARCHAR2(255),
    	lastname        VARCHAR2(255),
    	gender          VARCHAR2(16),
    	dob             DATE NOT NULL,
    	pob             VARCHAR2(255),
    	address         VARCHAR2(255) NOT NULL,
    	nationality     VARCHAR2(255) NOT NULL,
	CONSTRAINT users_pk PRIMARY KEY ( userid )
);

CREATE TABLE vehicle (
    	vehicleid                 INTEGER NOT NULL,
    	licenceplate              VARCHAR2(18) NOT NULL,
    	vehiclename_vehiclenameid INTEGER NOT NULL,
	CONSTRAINT vehicle_pk PRIMARY KEY ( vehicleid )
);

CREATE TABLE vehiclename (
    	vehiclenameid INTEGER NOT NULL,
    	vehicletype   VARCHAR2(16) NOT NULL,
    	vehiclename   VARCHAR2(255) NOT NULL,
	CONSTRAINT vehiclename_pk PRIMARY KEY ( vehiclenameid )
);

ALTER TABLE balancehistory
    ADD CONSTRAINT balancehistory_users_fk FOREIGN KEY ( users_userid )
        REFERENCES users ( userid );

ALTER TABLE driver
    ADD CONSTRAINT driver_vehicle_fk FOREIGN KEY ( vehicle_vehicleid )
        REFERENCES vehicle ( vehicleid );

ALTER TABLE salaryhistory
    ADD CONSTRAINT salaryhistory_driver_fk FOREIGN KEY ( driver_driverid )
        REFERENCES driver ( driverid );

ALTER TABLE transaction
    ADD CONSTRAINT transaction_driver_fk FOREIGN KEY ( driver_driverid )
        REFERENCES driver ( driverid );

ALTER TABLE transaction
    ADD CONSTRAINT transaction_paymenttype_fk FOREIGN KEY ( paymenttype_paymenttypeid )
        REFERENCES paymenttype ( paymenttypeid );

ALTER TABLE transaction
    ADD CONSTRAINT transaction_users_fk FOREIGN KEY ( users_userid )
        REFERENCES users ( userid );

ALTER TABLE vehicle
    ADD CONSTRAINT vehicle_vehiclename_fk FOREIGN KEY ( vehiclename_vehiclenameid )
        REFERENCES vehiclename ( vehiclenameid );


CREATE OR REPLACE TRIGGER fkntm_transaction BEFORE
    UPDATE OF driver_driverid, users_userid ON transaction
BEGIN
    raise_application_error(-20225, 'Non Transferable FK constraint  on table Transaction is violated');
END;




-- Sequences -- 

DROP SEQUENCE driver_driverid_seq;
DROP SEQUENCE users_userid_seq;
DROP SEQUENCE vn_vnid_seq;
DROP SEQUENCE vehicle_vehicleid_seq;
DROP SEQUENCE transaction_transactionid_seq;


CREATE SEQUENCE driver_driverid_seq
INCREMENT BY 1
START WITH 0
MAXVALUE 10000
MINVALUE 0
NOCACHE
NOCYCLE;

CREATE SEQUENCE users_userid_seq
INCREMENT BY 1
START WITH 0
MAXVALUE 10000
MINVALUE 0
NOCACHE
NOCYCLE;

CREATE SEQUENCE transaction_transactionid_seq
INCREMENT BY 1
START WITH 0
MAXVALUE 10000
MINVALUE 0
NOCACHE
NOCYCLE;

CREATE SEQUENCE vn_vnid_seq
INCREMENT BY 1
START WITH 0
MAXVALUE 10000
MINVALUE 0
NOCACHE
NOCYCLE;

CREATE SEQUENCE vehicle_vehicleid_seq
INCREMENT BY 1
START WITH 0
MAXVALUE 10000
MINVALUE 0
NOCACHE
NOCYCLE;





-- DML --

INSERT INTO VehicleName
VALUES
(vn_vnid_seq.NEXTVAL, 'Motorcycle', 'Honda Vario') 
INSERT INTO VehicleName
VALUES
(vn_vnid_seq.NEXTVAL, 'Motorcycle', 'Honda Beat') 
INSERT INTO VehicleName
VALUES
(vn_vnid_seq.NEXTVAL, 'Motorcycle', 'Yamaha Aerox') 
INSERT INTO VehicleName
VALUES
(vn_vnid_seq.NEXTVAL, 'Car', 'Toyota Agya') 
INSERT INTO VehicleName
VALUES
(vn_vnid_seq.NEXTVAL, 'Car', 'Zuzuki Ertiga')

select * from vehiclename;

INSERT INTO Vehicle 
VALUES 
(vehicle_vehicleid_seq.NEXTVAL, 'B 8989 BG', 2) 
INSERT INTO Vehicle 
VALUES 
(vehicle_vehicleid_seq.NEXTVAL, 'B 8289 HG', 3) 
INSERT INTO Vehicle 
VALUES 
(vehicle_vehicleid_seq.NEXTVAL, 'B 1101 JI', 4) 
INSERT INTO Vehicle 
VALUES 
(vehicle_vehicleid_seq.NEXTVAL, 'B 9027 KL', 1)

select * from vehicle;

INSERT INTO Driver
VALUES (driver_driverid_seq.NEXTVAL, '6282177776666', 'david@gmail.com', 'David', 'Christian', 'Male', TO_DATE('17/12/2000 21:02:44', 'dd /mm/yyyy hh24:mi:ss'), 'Bogor', 'Indonesia', TO_DATE('2021/12/18 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 'Jl. Bogor Raya No.1', 1) 
INSERT INTO Driver
VALUES (driver_driverid_seq.NEXTVAL, '6282143243242', 'azizu@gmail.com', 'Azizu', 'Putra', 'Male', TO_DATE('2000/02/12 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 'Jakarta', 'Indonesia',  TO_DATE('2021/12/17 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 'Jl. Jakarta No.14', 2) 
INSERT INTO Driver
VALUES (driver_driverid_seq.NEXTVAL, '6282187989899', 'michele@gmail.com', 'Michele', 'Felicia', 'Female', TO_DATE('1993/03/12 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 'Bali', 'Indonesia', TO_DATE('2016/08/12 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 'Jl. Bandung Raya No.92', 3) 
INSERT INTO Driver
VALUES (driver_driverid_seq.NEXTVAL, '6282434398032', 'nadya@gmail.com', 'Nadya', 'Putri', 'Female', TO_DATE('1998/07/19 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 'Bogor', 'Indonesia', TO_DATE('2016/01/20 21:02:44', 'yyyy/mm/dd hh24:mi:ss'), 'Jl. Melati No.12', 0)

select * from driver;


INSERT INTO SalaryHistory 
VALUES
(TO_DATE('12/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 89999, 3) 
INSERT INTO SalaryHistory 
VALUES
(TO_DATE('13/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 79999, 3) 
INSERT INTO SalaryHistory 
VALUES
(TO_DATE('14/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 80999, 3) 
INSERT INTO SalaryHistory
VALUES
(TO_DATE('12/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 129999, 2) 
INSERT INTO SalaryHistory
VALUES
(TO_DATE('13/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 200999, 2) 
INSERT INTO SalaryHistory 
VALUES
(TO_DATE('14/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 201999, 2)

select * from salaryhistory;


INSERT INTO Users
VALUES
(users_userid_seq.NEXTVAL, '6281299987662', 'budi@gmail.com', 'Budi', 'Gunawan', 'Male', TO_DATE('12/08/1992 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 'Bogor', 'Jl. Bogor Raya No.19', 'Indonesia')  
INSERT INTO Users
VALUES
(users_userid_seq.NEXTVAL, '6281295434783', 'richard@gmail.com', 'Richard', 'Tan', 'Male', TO_DATE('12/08/1997 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 'Jakarta', 'Jl. Jakarta No.21', 'Indonesia')  
INSERT INTO Users
VALUES
(users_userid_seq.NEXTVAL, '6282190832532', 'haikal@gmail.com', 'Haikal', 'Rizki', 'Male', TO_DATE('12/08/1988 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 'Jakarta', 'Jl. Jakarta No.291', 'Indonesia')  

select * from users;


INSERT INTO BalanceHistory
VALUES
(TO_DATE('12/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 12000, 2) 
INSERT INTO BalanceHistory
VALUES
(TO_DATE('13/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 24000, 2) 
INSERT INTO BalanceHistory
VALUES
(TO_DATE('14/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 20000, 2) 
INSERT INTO BalanceHistory
VALUES
(TO_DATE('12/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 50000, 1) 
INSERT INTO BalanceHistory
VALUES
(TO_DATE('13/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 60000, 1) 
INSERT INTO BalanceHistory
VALUES
(TO_DATE('14/08/2021 00:01:01', 'dd/mm/yyyy hh24:mi:ss'), 70000, 1)

select * from balancehistory;

INSERT INTO PaymentType
VALUES
(1, 'Cash') 
INSERT INTO PaymentType
VALUES
(2, 'Cash') 
INSERT INTO PaymentType
VALUES
(3, 'Go Pay') 
INSERT INTO PaymentType
VALUES
(4, 'Dana') 

select * from paymenttype;


INSERT INTO Transaction
VALUES
(transaction_transactionid_seq.NEXTVAL, 0.9, 'bogor 1', 'bogor 2', 2000, 3, 1, 1) 
INSERT INTO Transaction
VALUES
(transaction_transactionid_seq.NEXTVAL, 0.9, 'bogor 2', 'bogor 3', 5000, 2, 2, 2) 
INSERT INTO Transaction
VALUES
(transaction_transactionid_seq.NEXTVAL, 0.8, 'bogor 3', 'bogor 4', 2000, 1, 2, 1) 
INSERT INTO Transaction
VALUES
(transaction_transactionid_seq.NEXTVAL, 0.7, 'bogor 4', 'bogor 5', 2000, 3, 3, 2) 
INSERT INTO Transaction
VALUES
(transaction_transactionid_seq.NEXTVAL, 0.9, 'jakarta 1', 'jakarta 2', 5000, 3, 1, 0)

select * from transaction;




-- views --

-- Mencari user dengan kewarganegaraan indonesia
CREATE VIEW view_indo_user
AS SELECT *
  FROM users
  WHERE nationality = 'Indonesia'
WITH READ ONLY;

select * FROM view_indo_user;


-- Menghitung semua total transaksi
CREATE VIEW view_total_transaction ("Total")
AS SELECT COUNT(TransactionID)
  FROM Transaction
  WITH READ ONLY;

SELECT * FROM view_total_transaction ;

-- Mencari user dengan total transaksi lebih dari rata-rata transaksi seluruh pengguna
CREATE VIEW loyal_user
AS SELECT  t.users_userid, COUNT(transactionid) AS "Total"
  FROM transaction t
  LEFT JOIN users s ON t.users_userid = s.userid
  GROUP BY t.users_userid
  HAVING COUNT(transactionid) > (SELECT  AVG(COUNT(transactionid))
  FROM transaction t
  LEFT JOIN users s ON t.users_userid = s.userid
  GROUP BY t.users_userid)
WITH READ ONLY;

select * FROM loyal_user;




-- indexes --

DROP INDEX user_userid_idx ;
DROP INDEX driver_driverid_idx ;
DROP INDEX transaction_transactionid_idx ;
DROP INDEX vehicle_vehicleid_idx ;
DROP INDEX vn_vnid_idx;

CREATE INDEX user_userid_idx ON Users(UserID);
CREATE INDEX driver_driverid_idx ON Driver(DriverID);
CREATE INDEX transaction_transactionid_idx ON Transaction(TransactionID);
CREATE INDEX vehicle_vehicleid_idx ON Vechile(VechicleID);
CREATE INDEX vn_vnid_idx ON VehicleName(VehicleNameID);

SELECT DISTINCT ic.index_name, ic.column_name, ic.column_position, id.uniqueness FROM user_indexes id, user_ind_columns ic WHERE id.table_name = ic.table_name AND ic.table_name = 'USERS';




-- synonyms -- 

DROP SYNONYM trans;

CREATE SYNONYM trans FOR Transaction; 

SELECT Synonym_name, Table_name, Table_owner, Db_link FROM user_synonyms;

select transactionid, users_userid from trans

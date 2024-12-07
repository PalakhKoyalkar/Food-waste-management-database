CREATE DATABASE foodwastemanagementsystem
USE foodwastemanagementsystem

--foodprovider table : stores the details of food donors.
CREATE TABLE foodprovider(
    providerid INT PRIMARY KEY IDENTITY(1,1),
	providername varchar(100),
	providercontactnumber BIGINT,
	provideraddress VARCHAR(100),
	providercity VARCHAR(30),
	providerpincode INT,
	CONSTRAINT checkprovidercontactnumber CHECK (providercontactnumber >=6000000000 AND providercontactnumber<= 9999999999),
	CONSTRAINT checkproviderpincode CHECK (providerpincode BETWEEN 100000 AND 999999)
);

--NGO Table: Stores information about organizations that will receive food donations.
CREATE TABLE NGO(
    ngoid INT PRIMARY KEY IDENTITY(1,1),
	ngoname VARCHAR(100),
	ngocontactnumber BIGINT,
	ngoaddress VARCHAR(100),
	ngocity VARCHAR(30),
	ngopincode INT,
	CONSTRAINT checkngocontactnumber CHECK (ngocontactnumber >=6000000000 AND ngocontactnumber<= 9999999999),
	CONSTRAINT checkngopincode CHECK (ngopincode BETWEEN 100000 AND 999999)
);

--donation cordinator table :Stores the intermediary details that facilitate communication between donors and NGOs.
CREATE TABLE DonationCoordinator(
    donationcoordinatorid INT PRIMARY KEY IDENTITY(1,1),
	donationcoordinatorname VARCHAR(100),
	donationcoordinatormail VARCHAR(255),
	CONSTRAINT checkdonationcoordinatormail check (donationcoordinatormail LIKE '%_@__%.__%')
);

--foodwaste data table: Stores information about the food waste donated.
CREATE TABLE fooddata(
    foodid INT PRIMARY KEY IDENTITY(1,1),
	providerid INT,
	foodtype VARCHAR(50),
	foodquantity FLOAT, --in kilograms
	Expirydate DATE,
	CONSTRAINT fkproviderid FOREIGN KEY (providerid) REFERENCES foodprovider(providerid)
);

-- donationrequest table : Stores the donation requests made by NGOs.
CREATE TABLE donationrequest(
    requestid INT PRIMARY KEY IDENTITY(1,1),
	ngoid INT,
	foodtype VARCHAR(50),
	requiredquantity FLOAT, --in kilograms
	requestdate DATE,
	CONSTRAINT fkngoid FOREIGN KEY (ngoid) REFERENCES NGO(ngoid)
);

--captures the transaction between food providers, NGO and donationcoordinator.
CREATE TABLE donationtransaction(
    transactionid INT PRIMARY KEY IDENTITY(1,1),
	foodid INT,
	requestid INT,
	donationcoordinatorid INT,
	transactiondate DATE,
	deliveredquantity FLOAT,
	CONSTRAINT fkfoodid FOREIGN KEY (foodid) REFERENCES fooddata(foodid),
	CONSTRAINT fkrequestid FOREIGN KEY (requestid) REFERENCES donationrequest(requestid),
	CONSTRAINT fkdonationcoordinatorid FOREIGN KEY (donationcoordinatorid) REFERENCES DonationCoordinator(donationcoordinatorid)
);

/*INPUT VALUES*/
--foodprovider table
insert into foodprovider (providername,providercontactnumber,provideraddress,providercity,providerpincode)
 values ('Kota Ravi',7383181533,'PNo270 Shreenatji soc-4, Niligiri,Udhna Yard','Surat',395010),
        ('Margham Ganesh',9173356481,'B-346 Suman Siddhi Society, Gododara','Surat',395010),
		('Shrinista Koyalkar',7876551533,'151-4 Rauji Sochpal Building,Dadar','Mumbai',400028),
		('Chanthu S',8734259037,'Pno109,Demonte Colony,Varkala','Thiruvandhapuram',695143),
		('Shiva Venkatesh',9386526222,'D-546 Bhagya Nagar','Ongole',523001),
		('Ishita Sharma',7845382538,'324-C, Brundhavan Colony','Phagwara',144411),
		('Tanishta',8745386457,'78-D, Chaura Bazar','Ludhiana',141001),
	    ('Mahendra Singh',7802914165,'PNo104,Beautiful Society','Jalandhar',144001),
		('Vamshi Anabattulu',9546372826,'434-2,Suman Prahar','Ludhiana',141001),
		('Rakesh Sharma',8764573903,'A-718, Kalpana Society','Jalandhar',144001)

--NGO table
insert into NGO (ngoname,ngocontactnumber,ngoaddress,ngocity,ngopincode)
values ('Goonj Foundation',8745363809,'Jangpura','New Delhi',110014),
       ('FoodBank India',7645370098,'1st Floor, Jivdani Apartment, Mhatre Nagar, Dadar West','Mumbai',400028),
	   ('Akshaya Patra Foundation',9845096021,'2nd Floor, Sukh Sagar, 40, Banshankar Marg, Basavanagudi','Bengaluru',560004),
	   ('Robin Hood Army',8065748535,'F-41, 2nd Floor, Opp. Radha Swami Satsang Beas','New Delhi', 110015),
	   ('Gujarat Food Bank',7864509203,'3rd Floor, Nirmal Residency, Near Shreyas School, Maninagar','Ahmedabad',110052),
	   ('Food for All',6378063468,'Plot 49, Opp. Indian Oil Petrol Pump, 60 Feet Road, Ashok Vihar Phase 3','New Delhi',110052),
	   ('Sewa Punjab',8976453087,'56, Krishna Nagar','Jalandhar',144001),
	   ('The Midday Meal Scheme',8745620701,'Room No. 201, 2nd Floor, State Project Office, Near Jalandhar Bye-pass','Ludhiana',141008),
	   ('Food for Change Punjab',6754309803,'H.No. 82, Street No. 4, Shankar Garden, Near Guru Teg Bahadur School','Patiala',147001),
	   ('Sankalp Trust',9084536078,'501, Dev Ashish Complex, Opp. Vishwakarma Engineering College','Ahmedabad',382426)

--DonationCoordinator table
insert into DonationCoordinator (donationcoordinatorname,donationcoordinatormail)
values ('Rakesh Kamuni','rakeshkamuni2002@gamil.com'),
       ('Srinath Mittakola','mittakolasrinath98@gamil.com'),
	   ('Rashmitha S','rashmitha123@gmail.com'),
	   ('Neha Allam','nehaallam87@gmail.com'),
	   ('Sirisha Guttula','sirishaguttula56@gmail.com'),
	   ('Dhananjay Chitturi','chitturidhananjay@gmail.com'),
	   ('Charan Boggavarapu','boggavarapucharam@gmail.com'),
	   ('Abhinaya S','abhinaya789@gmail.com'),
	   ('Ankna Chaudhary','anknachaudhary@gmail.com'),
	   ('Sanjana Sherawat','sanjanasherawat@gmail.com')

--fooddata table
insert into fooddata(providerid,foodtype,foodquantity,Expirydate)
values (1,'Puri and Chana',10.5,'11-27-2024'),
       (2,'Rice and Dal',15,'11-27-2024'),
	   (3,'Roti and Aloocurry',20,'11-27-2024'),
	   (4,'Veg Biriyani',20,'11-27-2024'),
	   (5,'Chole Kulche',15,'11-27-2024'),
	   (6,'Rice and Dal',25.5,'11-27-2024'),
	   (7,'Chana Puri',10.5,'11-27-2024'),
	   (8,'Roti and Aloocurry',12,'11-27-2024'),
	   (9,'Pav Bhaji',15,'11-27-2024'),
	   (10,'Chole Kulche',20,'11-27-2024')

--donationrequest table
insert into donationrequest(ngoid,foodtype,requiredquantity,requestdate)
values (1,'Puri and Chana',10,'11-26-2024'),
       (2,'Veg Biroyani',15,'11-26-2024'),
	   (3,'Chole kulche',10.5,'11-26-2024'),
	   (4,'Pav Bhaji',12,'11-26-2024'),
	   (5,'Puri and Chana',12.5,'11-26-2024'),
	   (6,'Rice and Dal',20,'11-26-2024'),
	   (7,'Chana Puri',10,'11-26-2024'),
	   (8,'Roti and Aloocurry',15,'11-26-2024'),
	   (9,'Rice and Dal',20,'11-26-2024'),
	   (10,'Chole Kulche',15.5,'11-26-2024')

--donationtransaction table
insert into donationtransaction(foodid,requestid,donationcoordinatorid,transactiondate,deliveredquantity)
values (1,1,1,'11-27-2024','10.2'),
       (2,2,2,'11-26-2024','15'),
	   (3,3,3,'11-27-2024','12.5'),
	   (4,4,4,'11-28-2024','20'),
	   (5,5,5,'11-25-2024','12.5'),
	   (6,6,6,'11-20-2024','15.5'),
	   (7,7,7,'11-26-2024','10'),
	   (8,8,8,'11-19-2024','10.5'),
	   (9,9,9,'11-21-2024','20'),
	   (10,10,10,'11-22-2024','15')

select * from foodprovider
select * from NGO
select * from DonationCoordinator
select * from fooddata
select * from donationrequest
select * from donationtransaction

/*Queries*/

--1.What food was donated by Transaction id =3
SELECT fd.foodtype, fd.foodquantity
FROM fooddata fd
WHERE fd.foodid = (SELECT foodid FROM donationtransaction WHERE transactionid = 3);

--2.Which provider provided 'Pav bhaji'
SELECT providername 
FROM foodprovider 
WHERE providerid = (SELECT providerid FROM fooddata WHERE foodtype = 'Pav Bhaji');

--3.Total quantity of food was donated on  2024-11-20
SELECT SUM(deliveredquantity) AS total_donated_quantity
FROM donationtransaction
WHERE transactiondate = '2024-11-20';

--4.Display Ngo with maximum amount of food donated
SELECT n.ngoname, SUM(dt.deliveredquantity) AS total_donated_quantity
FROM donationtransaction dt
JOIN donationrequest dr ON dt.requestid = dr.requestid
JOIN NGO n ON dr.ngoid = n.ngoid
GROUP BY n.ngoname
ORDER BY total_donated_quantity DESC
TOP 1;  
/*OR*/
SELECT n.ngoname, SUM(dt.deliveredquantity) AS total_delivered
FROM NGO n
JOIN donationrequest dr ON n.ngoid = dr.ngoid
JOIN donationtransaction dt ON dr.requestid = dt.requestid
GROUP BY n.ngoname
HAVING SUM(dt.deliveredquantity) = (
    SELECT MAX(total_delivered)
    FROM (
        SELECT SUM(dt2.deliveredquantity) AS total_delivered
        FROM donationrequest dr2
        JOIN donationtransaction dt2 ON dr2.requestid = dt2.requestid
        GROUP BY dr2.ngoid
    ) AS MaxDonation
);


--5.What is the total quantity of food requested by each NGO?
SELECT n.ngoname, SUM(dr.requiredquantity) AS total_requested
FROM NGO n
JOIN donationrequest dr ON n.ngoid = dr.ngoid
GROUP BY n.ngoname;

--6.What is the total quantity of food donated by each provider?
SELECT fp.providername, SUM(fd.foodquantity) AS total_quantity
FROM foodprovider fp
JOIN fooddata fd ON fp.providerid = fd.providerid
GROUP BY fp.providername;

--7.Which donation coordinators handled which donation transactions?
SELECT dc.donationcoordinatorname, dt.transactionid, dt.transactiondate, dt.deliveredquantity
FROM DonationCoordinator dc
JOIN donationtransaction dt ON dc.donationcoordinatorid = dt.donationcoordinatorid;

--8.Which food donations have an expiry date after 2024-11-26?
SELECT * FROM fooddata WHERE Expirydate > '2024-11-26';

--9.Which food types and quantities were donated by each provider?
SELECT fp.providername, fd.foodtype, fd.foodquantity
FROM foodprovider fp
JOIN fooddata fd ON fp.providerid = fd.providerid;

--10.Which NGOs requested which types of food, and what were the required quantities?
SELECT n.ngoname, dr.foodtype, dr.requiredquantity
FROM NGO n
JOIN donationrequest dr ON n.ngoid = dr.ngoid;

--UPDATES
INSERT INTO foodprovider (providername, providercontactnumber, provideraddress, providercity, providerpincode)
VALUES 
('Arjun Gupta',7012345678,'C-5, Anand Vihar','Mumbai',400049),
('Rekha Nair',8876543210,'B-120, Vasanth Vihar','Thane',400602),
('Vivek Sharma',7382911123,'Plot 47, Green Valley','Ahmedabad',380001),
('Rajesh Mehta',9087654321,'Flat 101, Gokuldham','Pune',411057),
('Preeti Patel',8293746512,'C-67, Nehru Colony','Bengaluru',560045);

INSERT INTO NGO (ngoname, ngocontactnumber, ngoaddress, ngocity, ngopincode)
VALUES 
('Feeding Hands',9023456789,'Sector 21, Vashi','Mumbai',400703),
('Future Foundation',9182736450,'Ghatkopar East','Mumbai',400077),
('FoodAid India',8789567823,'Karol Bagh','New Delhi',110005),
('Helping Hearts',7689123456,'MG Road','Pune',411001),
('Harmony Trust',9876543219,'Koramangala','Bengaluru',560034);

INSERT INTO DonationCoordinator (donationcoordinatorname, donationcoordinatormail)
VALUES 
('Megha Reddy','meghareddy@gmail.com'),
('Amit Desai','amitdesai89@gmail.com'),
('Sonal Kapoor','sonalkapoor456@gmail.com'),
('Rohan Jain','rohanjain23@gmail.com'),
('Niharika Yadav','niharika123@gmail.com');

INSERT INTO fooddata (providerid, foodtype, foodquantity, Expirydate)
VALUES 
(3, 'Daal Makhani', 18.0, '2024-11-30'),
(5, 'Paneer Curry', 20.0, '2024-11-25'),
(6, 'Veg Pulao', 15.0, '2024-12-01'),
(8, 'Bread Butter', 12.0, '2024-11-28'),
(9, 'Fried Rice', 25.0, '2024-11-29');

INSERT INTO donationrequest (ngoid, foodtype, requiredquantity, requestdate)
VALUES 
(1, 'Bread Butter', 12.0, '2024-11-25'),
(2, 'Paneer Curry', 18.0, '2024-11-24'),
(4, 'Veg Pulao', 14.5, '2024-11-26'),
(7, 'Daal Makhani', 16.0, '2024-11-28'),
(10, 'Fried Rice', 20.0, '2024-11-29');

INSERT INTO donationtransaction (foodid, requestid, donationcoordinatorid, transactiondate, deliveredquantity)
VALUES 
(11, 11, 11, '2024-11-24', 15.0),
(12, 12, 12, '2024-11-25', 18.0),
(13, 13, 13, '2024-11-26', 14.5),
(14, 14, 14, '2024-11-27', 16.0),
(15, 15, 15, '2024-11-28', 20.0);

--12. Retrieve all donation transactions where the delivered quantity exceeds the maximum required quantity
SELECT dt.transactionid, dt.deliveredquantity
FROM donationtransaction dt
WHERE dt.deliveredquantity > (
    SELECT MAX(dr.requiredquantity)
    FROM donationrequest dr
);



--23.Find providers who donated food items that were requested by more than one NGO
SELECT 
    dt.donationcoordinatorid, 
    dt.foodid
FROM 
    donationtransaction dt
WHERE 
    dt.foodid IN (
        SELECT  foodid
        FROM donationtransaction
        GROUP BY  foodid
        HAVING COUNT(DISTINCT requestid) > 1
    );


--24. Check whether the donated food is more than 2days
DECLARE @FoodID INT;
DECLARE @RequestID INT;
DECLARE @DonationDate DATETIME;
DECLARE @CurrentDate DATETIME;

-- Set current date for comparison
SET @CurrentDate = GETDATE();
-- Declare dynamic cursor to fetch food donation transactions
DECLARE dynamic_cursor CURSOR DYNAMIC
FOR
SELECT foodid, requestid, transactiondate
FROM donationtransaction;
-- Declare variables to store cursor values
DECLARE @FetchedFoodID INT;
DECLARE @FetchedRequestID INT;
DECLARE @FetchedTransactionDate DATETIME;

-- Open the cursor
OPEN dynamic_cursor;
-- Fetch the first row
FETCH NEXT FROM dynamic_cursor INTO @FetchedFoodID, @FetchedRequestID, @FetchedTransactionDate;
-- Loop through the result set and check the donation date
PRINT 'Donation Status (Older Than 2 Days Check):';
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Calculate the difference in days
    IF DATEDIFF(DAY, @FetchedTransactionDate, @CurrentDate) > 2
    BEGIN
        PRINT 'Donation for FoodID ' + CAST(@FetchedFoodID AS NVARCHAR) + 
              ' with RequestID ' + CAST(@FetchedRequestID AS NVARCHAR) + 
              ' is older than 2 days.';
    END
    ELSE
    BEGIN
        PRINT 'Donation for FoodID ' + CAST(@FetchedFoodID AS NVARCHAR) + 
              ' with RequestID ' + CAST(@FetchedRequestID AS NVARCHAR) + 
              ' is within the last 2 days.';
    END    
    -- Fetch the next row
    FETCH NEXT FROM dynamic_cursor INTO @FetchedFoodID, @FetchedRequestID, @FetchedTransactionDate;
END;
-- Close and deallocate the cursor
CLOSE dynamic_cursor;
DEALLOCATE dynamic_cursor;

--13.List all food providers and the quantity of food donated, including providers who haven't donated yet
SELECT fp.providername, SUM(fd.foodquantity) AS total_quantity
FROM foodprovider fp
LEFT JOIN fooddata fd ON fp.providerid = fd.providerid
GROUP BY fp.providername;

--14. Display all  NGOs and their corresponding donations(if any)
SELECT n.ngoname, dt.deliveredquantity
FROM donationtransaction dt
RIGHT JOIN NGO n ON dt.requestid = n.ngoid;

--11.get details of ngo 
CREATE PROCEDURE getngodetails
@ngoid int
AS
BEGIN 
    Select ngoname, ngoid, ngoaddress, ngocity from NGO
	where ngoid = @ngoid;
END;

EXEC getngodetails @ngoid=2
EXEC getngodetails @ngoid=3


--15. Calculate total donations for a specific NGO
CREATE PROCEDURE CalculateTotalDonations
@ngo_id INT
AS
BEGIN
    DECLARE @total_donated_quantity FLOAT;

    SELECT @total_donated_quantity = SUM(dt.deliveredquantity)
    FROM donationtransaction dt
    JOIN donationrequest dr ON dt.requestid = dr.requestid
    WHERE dr.ngoid = @ngo_id;

    PRINT 'The total donated quantity for NGO ID ' + CAST(@ngo_id AS VARCHAR) + ' is ' + CAST(@total_donated_quantity AS VARCHAR);
END;
-- Execute the procedure
EXEC CalculateTotalDonations @ngo_id = 2;


--16. Add a new donation request with validation 
CREATE PROCEDURE AddDonationRequest
@ngo_id INT,
@food_type VARCHAR(50),
@required_quantity FLOAT,
@request_date DATE
AS
BEGIN
    IF @required_quantity <= 0
    BEGIN
        PRINT 'Error: Required quantity must be greater than 0.';
        RETURN;
    END;

    IF @request_date < GETDATE()
    BEGIN
        PRINT 'Error: Request date cannot be in the past.';
        RETURN;
    END;

    INSERT INTO donationrequest (ngoid, foodtype, requiredquantity, requestdate)
    VALUES (@ngo_id, @food_type, @required_quantity, @request_date);

    PRINT 'Donation request added successfully for NGO ID ' + CAST(@ngo_id AS VARCHAR);
END;
-- Execute the procedure
EXEC AddDonationRequest @ngo_id = 3, @food_type = 'Chole Kulche', @required_quantity = 20, @request_date = '2024-11-28';

--17. Retrieve all transactions for a given date and return total donated quantity
CREATE PROCEDURE GetTransactionsForDate
@transaction_date DATE
AS
BEGIN
    DECLARE @total_donated_quantity FLOAT;

    SELECT dt.transactionid, dt.foodid, dt.requestid, dt.donationcoordinatorid, dt.deliveredquantity
    FROM donationtransaction dt
    WHERE dt.transactiondate = @transaction_date;

    SELECT @total_donated_quantity = SUM(dt.deliveredquantity)
    FROM donationtransaction dt
    WHERE dt.transactiondate = @transaction_date;

    PRINT 'The total donated quantity for ' + CAST(@transaction_date AS VARCHAR) + ' is ' + CAST(@total_donated_quantity AS VARCHAR);
END;
-- Execute the procedure
EXEC GetTransactionsForDate @transaction_date = '2024-11-27';

--18. Prevent inserting negative food quantities
CREATE TRIGGER trg_PreventNegativeQuantity
ON donationrequest
AFTER INSERT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM INSERTED WHERE requiredquantity < 0)
    BEGIN
        PRINT 'Error: Negative food quantities are not allowed.';
        RETURN;
    END;

    -- Allow valid rows to be inserted
    INSERT INTO donationrequest (ngoid, foodtype, requiredquantity, requestdate)
    SELECT ngoid, foodtype, requiredquantity, requestdate
    FROM INSERTED;
END;

--19. Prevent duplicate donation requests for the same NGO and food type
CREATE TRIGGER trg_PreventDuplicateDonationRequest
ON donationrequest
AFTER INSERT
AS
BEGIN
    -- Check if there are any duplicates for the same NGO and food type
    IF EXISTS (
        SELECT 1
        FROM donationrequest dr
        INNER JOIN INSERTED i
            ON i.ngoid = dr.ngoid
            AND i.foodtype = dr.foodtype
            AND i.requestdate = dr.requestdate
        WHERE dr.ngoid = i.ngoid
        AND dr.foodtype = i.foodtype
    )
    BEGIN
        PRINT 'Error: Duplicate donation requests for the same NGO and food type are not allowed.';
        -- Rollback the insert if a duplicate is found
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- If no duplicates are found, continue with the insert
        PRINT 'Donation request inserted successfully.';
    END;
END;

--20. Insert a new donation transaction 
BEGIN TRANSACTION;

BEGIN TRY
    -- Insert a new donation transaction
    INSERT INTO donationtransaction (foodid, requestid, donationcoordinatorid, transactiondate, deliveredquantity)
    VALUES (1, 101, 5, GETDATE(), 50);

    -- Commit the transaction
    COMMIT TRANSACTION;
    PRINT 'New donation transaction inserted successfully.';
END TRY
BEGIN CATCH
    -- Rollback the transaction in case of an error
    ROLLBACK TRANSACTION;
    PRINT 'Transaction failed: ' + ERROR_MESSAGE();
END CATCH;

-- View updated donationtransaction table
SELECT * FROM donationtransaction;

--21. Insert multiple donation transactions and rollback if any error occurs.
BEGIN TRANSACTION;

BEGIN TRY
    -- Insert multiple donation transactions
    INSERT INTO donationtransaction (foodid, requestid, donationcoordinatorid, transactiondate, deliveredquantity)
    VALUES (11, 12, 6, GETDATE(), 30);

    INSERT INTO donationtransaction (foodid, requestid, donationcoordinatorid, transactiondate, deliveredquantity)
    VALUES (12, 13, 7, GETDATE(), 40);

    -- Commit the transaction
    COMMIT TRANSACTION;
    PRINT 'All donation transactions inserted successfully.';
END TRY
BEGIN CATCH
    -- Rollback all transactions in case of an error
    ROLLBACK TRANSACTION;
    PRINT 'Transaction failed: ' + ERROR_MESSAGE();
END CATCH;

-- View updated donationtransaction table
SELECT * FROM donationtransaction;

--22. Check if a food provider has donated a certain amount if not rollback
BEGIN TRANSACTION;

DECLARE @TotalDelivered INT;

-- Calculate the total delivered quantity by a specific coordinator for a specific request
SELECT @TotalDelivered = ISNULL(SUM(deliveredquantity), 0) -- Using ISNULL to handle NULL case
FROM donationtransaction
WHERE donationcoordinatorid = 5 AND requestid = 101;

-- Check if the total delivered quantity meets or exceeds the required threshold (100)
IF @TotalDelivered >= 100
BEGIN
    -- Insert a new donation transaction
    INSERT INTO donationtransaction (foodid, requestid, donationcoordinatorid, transactiondate, deliveredquantity)
    VALUES (1,1,1, GETDATE(),10);

    -- Commit the transaction
    COMMIT TRANSACTION;
    PRINT 'Donation transaction recorded successfully.';
END
ELSE
BEGIN
    -- Rollback the transaction if the condition is not met
    ROLLBACK TRANSACTION;
    PRINT 'Transaction failed: Coordinator has not delivered the required quantity.';
END;

-- View the updated donationtransaction table
SELECT * FROM donationtransaction;




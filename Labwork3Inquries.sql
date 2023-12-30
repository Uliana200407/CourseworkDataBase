# 1st task

SELECT * FROM Room WHERE Price < 1300;

SELECT * FROM Reservation WHERE CheckIn_Date > '2023-01-01';

SELECT * FROM Client WHERE CategoryID = 1 AND (Passport LIKE
'AB%' OR Passport LIKE 'BE%');

SELECT * FROM Room WHERE RoomID NOT IN (SELECT RoomID
FROM Reservation WHERE CheckIn_Date BETWEEN '2023-06-01' AND
'2023-06-30');

SELECT ReservationID, DATEDIFF(CheckOut_Date, CheckIn_Date) *
(SELECT Price FROM Room WHERE Room.RoomID =
Reservation.RoomID) AS TotalCost FROM Reservation;

SELECT RoomID, Capacity, Price * 0.9 AS DiscountedPrice FROM Room
WHERE Capacity > 2;

SELECT * FROM Client WHERE CategoryID IN (1, 3, 5);

SELECT * FROM Room WHERE Price BETWEEN 1000 AND 1200;

SELECT * FROM Client WHERE LastName LIKE 'Sm%';

SELECT * FROM Room WHERE Hotel_ID IS NULL;

# 2nd task

SELECT h.Name, (SELECT AVG(Price) FROM Room WHERE Hotel_ID =
h.ID) AS AveragePrice FROM Hotel h;

SELECT * FROM Hotel h WHERE EXISTS (SELECT * FROM Room
WHERE Hotel_ID = h.ID AND Price > 150);

SELECT * FROM Client, Room;

SELECT r.*, c.FirstName, c.LastName, rm.ComfortLevel
FROM Reservation r, Client c, Room rm
WHERE r.ClientID = c.ClientID AND r.RoomID = rm.RoomID;

SELECT DISTINCT c.FirstName, c.LastName
FROM Client c,
     Reservation r, Room rm
WHERE c.ClientID = r.ClientID AND r.RoomID = rm.RoomID
  AND rm.ComfortLevel = 'Luxury';

SELECT s.*, r.CheckIn_Date, r.CheckOut_Date
FROM Stay s
     INNER JOIN Reservation r ON s.ReservationID = r.ReservationID;

SELECT c.FirstName, c.LastName, r.ReservationID
FROM Client c
LEFT JOIN Reservation r ON c.ClientID = r.ClientID;

SELECT rm.RoomID, rm.Capacity, r.ReservationID FROM Room rm
RIGHT JOIN Reservation r ON rm.RoomID = r.RoomID;


SELECT FirstName, LastName FROM Client WHERE ClientID IN
(SELECT ClientID FROM Reservation)
UNION
SELECT FirstName, LastName FROM Client WHERE ClientID IN
(SELECT ClientID FROM Stay);

SELECT FirstName, LastName
FROM Client
WHERE ClientID IN (
    SELECT ClientID
    FROM Reservation
) OR ClientID IN (
    SELECT ClientID
    FROM Stay
);


SELECT r.RoomID, r.Capacity, r.ComfortLevel, r.Price FROM Room r
WHERE r.RoomID NOT IN (SELECT RoomID FROM Reservation
WHERE CheckIn_Date <= '2023-01-01' AND CheckOut_Date >= '2023-01-10');

SELECT c.FirstName, c.LastName FROM Client c
WHERE c.ClientID IN (SELECT ClientID FROM Reservation WHERE
Status = 'Confirmed' AND RoomID NOT IN (SELECT RoomID FROM Stay)); #!

# 3rd task is in my report

# 4th task
# a)
SELECT r.RoomID, r.Capacity, r.ComfortLevel, r.Price
FROM Room r
WHERE NOT EXISTS (
SELECT 1
FROM Reservation res
WHERE res.RoomID = r.RoomID
AND res.CheckIn_Date <= '2023-01-15' -- the end
AND res.CheckOut_Date >= '2023-01-10' -- the beginning
);


# b)
SELECT DISTINCT c.FirstName, c.LastName
FROM Client c
JOIN Reservation r ON c.ClientID = r.ClientID
LEFT JOIN Stay s ON r.ReservationID = s.ReservationID
WHERE r.CheckIn_Date >= '2023-07-05'
AND r.CheckOut_Date <= '2023-07-15'
AND s.StayID IS NULL;


CREATE TABLE Hotels
(
    HotelId INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    City VARCHAR(50) NOT NULL,
    StarRating INT,
    ContactNumber VARCHAR(20),
    ManageId INT UNIQUE
);


CREATE TABLE Staff
(
    StaffId INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Position VARCHAR(50),
    Salary DECIMAL(10,2),
    HotelId INT NOT NULL,

    CONSTRAINT FK_Staff_Hotels
        FOREIGN KEY (HotelId)
        REFERENCES Hotels(HotelId)
);

ALTER TABLE Hotels
ADD CONSTRAINT FK_Hotels_Manager
    FOREIGN KEY (ManageId)
    REFERENCES Staff(StaffId);

CREATE TABLE Rooms
(
    RoomNumber INT PRIMARY KEY,
    RoomType VARCHAR(50),
    Capacity INT,
    DailyRate DECIMAL(10,2),
    Availability BIT,
    HotelId INT NOT NULL,

    CONSTRAINT FK_Rooms_Hotels
        FOREIGN KEY (HotelId)
        REFERENCES Hotels(HotelId)
);

CREATE TABLE Reservations
(
    ReservationId INT PRIMARY KEY,
    BookingDate DATE,
    CheckInDate DATE,
    CheckOutDate DATE,
    ReservationStatus VARCHAR(30),
    TotalPrice DECIMAL(10,2),
    NumberOfAdults INT,
    NumberOfChildren INT
);

CREATE TABLE Guests
(
    GuestId INT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Nationality VARCHAR(50),
    PassportNumber VARCHAR(30),
    DateOfBirth DATE
);

CREATE TABLE Payments
(
    PaymentId INT PRIMARY KEY,
    Method VARCHAR(30),
    Date DATE,
    Amount DECIMAL(10,2),
    ConfirmationNumber VARCHAR(50)
);

CREATE TABLE Services
(
    ServiceId INT PRIMARY KEY,
    ServiceName VARCHAR(100) NOT NULL,
    Charge DECIMAL(10,2),
    RequestDate DATE,
    StaffId INT NOT NULL,

    CONSTRAINT FK_Services_Staff
        FOREIGN KEY (StaffId)
        REFERENCES Staff(StaffId)
);

CREATE TABLE Amenities
(
    RoomNumber INT,
    Amenity VARCHAR(100),

    CONSTRAINT PK_Amenities
        PRIMARY KEY (RoomNumber, Amenity),

    CONSTRAINT FK_Amenities_Rooms
        FOREIGN KEY (RoomNumber)
        REFERENCES Rooms(RoomNumber)
);

CREATE TABLE Reservations_Rooms
(
    ReservationId INT,
    RoomNumber INT,

    CONSTRAINT PK_Reservations_Rooms
        PRIMARY KEY (ReservationId, RoomNumber),

    CONSTRAINT FK_Reservations_Rooms_Reservations
        FOREIGN KEY (ReservationId)
        REFERENCES Reservations(ReservationId),

    CONSTRAINT FK_Reservations_Rooms_Rooms
        FOREIGN KEY (RoomNumber)
        REFERENCES Rooms(RoomNumber)
);

CREATE TABLE ReservationService
(
    ServiceId INT,
    ReservationId INT,

    CONSTRAINT PK_ReservationService
        PRIMARY KEY (ServiceId, ReservationId),

    CONSTRAINT FK_ReservationService_Services
        FOREIGN KEY (ServiceId)
        REFERENCES Services(ServiceId),

    CONSTRAINT FK_ReservationService_Reservations
        FOREIGN KEY (ReservationId)
        REFERENCES Reservations(ReservationId)
);

CREATE TABLE Reservations_Guest
(
    ReservationId INT,
    GuestId INT,

    CONSTRAINT PK_Reservations_Guest
        PRIMARY KEY (ReservationId, GuestId),

    CONSTRAINT FK_Reservations_Guest_Reservations
        FOREIGN KEY (ReservationId)
        REFERENCES Reservations(ReservationId),

    CONSTRAINT FK_Reservations_Guest_Guests
        FOREIGN KEY (GuestId)
        REFERENCES Guests(GuestId)
);

CREATE TABLE Guest_Contact_Details
(
    GuestId INT,
    Detail VARCHAR(100),

    CONSTRAINT PK_Guest_Contact_Details
        PRIMARY KEY (GuestId, Detail),

    CONSTRAINT FK_Guest_Contact_Details_Guests
        FOREIGN KEY (GuestId)
        REFERENCES Guests(GuestId)
);

CREATE TABLE Reservations_Payment
(
    ReservationId INT,
    PaymentId INT,

    CONSTRAINT PK_Reservations_Payment
        PRIMARY KEY (ReservationId, PaymentId),

    CONSTRAINT FK_Reservations_Payment_Reservations
        FOREIGN KEY (ReservationId)
        REFERENCES Reservations(ReservationId),

    CONSTRAINT FK_Reservations_Payment_Payments
        FOREIGN KEY (PaymentId)
        REFERENCES Payments(PaymentId)
);

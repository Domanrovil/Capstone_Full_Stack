
/* Team 8 Church Management System Database Prototype*/
/* The SQL Query will create various tables that will be needed for the database involving the church management system
All tables were taken from the ER diagram made from sprint 3 with some minor changes meant to make the tables more 
accurate and informative.*/

USE ChurchVMS;


CREATE TABLE Roles(
RoleID int NOT NULL,
RoleName varchar (30) NOT NULL, 
RoleDesc varchar (100) NOT NULL,
CONSTRAINT PK_Roles PRIMARY KEY(RoleID));


CREATE TABLE Teams(
TeamID int IDENTITY(1,1) NOT NULL,
TeamDesc varchar (100),
UserID int,
CONSTRAINT FK_Teams_Users FOREIGN KEY (UserID) REFERENCES Users,
CONSTRAINT PK_Teams PRIMARY KEY(TeamID));


CREATE TABLE ZipCodes(
ZipCode varchar(15),
City varchar (50),
State varchar(5),
CONSTRAINT PK_ZipCodes PRIMARY KEY(ZipCode));


CREATE TABLE Logins(
LoginID int IDENTITY(1,1) NOT NULL,
LoginEmail varchar (255),
UserPassword varchar (255),
CONSTRAINT PK_Logins PRIMARY KEY (LoginID));


CREATE TABLE Users(
UserID int IDENTITY(1,1) NOT NULL,
FirstName varchar(50) NOT NULL,
LastName varchar(50) NOT NULL,
Address_Line1 varchar(50),
Address_Line2 varchar(50),
Phone varchar(16),
Email varchar(255),
ZipCode varchar(15),
RoleID int NOT NULL,
LoginID int NOT NULL,
CONSTRAINT PK_Users PRIMARY KEY(UserID),
CONSTRAINT FK_Users_ZipCodes FOREIGN KEY (ZipCode) REFERENCES ZipCodes,
CONSTRAINT FK_Users_Roles FOREIGN KEY(RoleID) REFERENCES Roles,
CONSTRAINT FK_Users_Logins FOREIGN KEY(LoginID) REFERENCES Logins);


CREATE TABLE UserAvailability(
UserID int NOT NULL,
DayOfWeek varchar(20),
StartTime time,
EndTime time,
CONSTRAINT PK_UserAvailability PRIMARY KEY (UserID),
CONSTRAINT FK_UserAvailability_Users FOREIGN KEY (UserID) REFERENCES Users);


CREATE TABLE TeamAssignments(
TeamID int NOT NULL,
UserID int NOT NULL,
CONSTRAINT PK_TeamAssignments PRIMARY KEY(TeamID,UserID),
CONSTRAINT FK_TeamAssignments_Teams FOREIGN KEY (TeamID) REFERENCES Teams,
CONSTRAINT FK_TeamAssignments_Users FOREIGN KEY (UserID) REFERENCES Users);


CREATE TABLE Jobs(
JobID int IDENTITY(1,1) NOT NULL,
JobDescription varchar (255),
CONSTRAINT PK_Jobs PRIMARY KEY (JobID));


CREATE TABLE Files(
FileID int IDENTITY(1,1) NOT NULL,
FileDescription varchar(100),
FileTags varchar(50),
FilePath varchar(200),
FileImage varbinary(max),
CONSTRAINT PK_Files PRIMARY KEY (FileID));


/* Change EventStart Date and time to be together
EventStartDateTime EventEndDateTime*/

CREATE TABLE Events(
EventID int IDENTITY(1,1) NOT NULL,
EventName varchar(100),
EventStartDateTime DateTime, 
EventEndDateTime DateTime,
EventNotes text,
TeamID int NOT NULL,
CONSTRAINT PK_Events PRIMARY KEY (EventID),
CONSTRAINT FK_Events_Teams FOREIGN KEY (TeamID) REFERENCES Teams);

/* ===========================================
=========ALTER COLUMN data type==============
=============================================*/ 
ALTER TABLE Events
ALTER COLUMN EventEndDateTime smalldatetime

ALTER TABLE Events
ALTER COLUMN EventStartDateTime smalldatetime
/* ===========================================
=========End of ALTER==============
=============================================*/ 


CREATE TABLE FileShares(
FileID int NOT NULL,
TeamID int NOT NULL,
EventID int NOT NULL,
CONSTRAINT PK_FileShares PRIMARY KEY (FileID,TeamID),
CONSTRAINT Fk_Fileshares_Files FOREIGN KEY (FileID) REFERENCES Files,
CONSTRAINT FK_FileShares_Teams FOREIGN KEY (TeamID) REFERENCES Teams,
CONSTRAINT FK_FileShares_Events FOREIGN KEY (EventID) REFERENCES Events)


CREATE TABLE Shifts(
ShiftID int IDENTITY(1,1) NOT NULL,
Date date,
StartTime time,
EndTime time,
UserID int NOT NULL,
JobID int NOT NULL,
EventID int NOT NULL,
CONSTRAINT PK_Shifts PRIMARY KEY (ShiftID),
CONSTRAINT FK_Shifts_Users FOREIGN KEY (UserID) REFERENCES Users,
CONSTRAINT FK_Shifts_Jobs FOREIGN KEY (JobID) REFERENCES Jobs,
CONSTRAINT FK_Shifts_Events FOREIGN KEY (EventID) REFERENCES Events)
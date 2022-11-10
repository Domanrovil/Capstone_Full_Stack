
/* Team 8 Church Management System Database Prototype*/
/* The SQL Query will create various tables that will be needed for the database involving the church management system
All tables were taken from the ER diagram made from sprint 3 with some minor changes meant to make the tables more 
accurate and informative.*/

Create database ChurchVMS
Create table Roles
(RoleID int  NOT null,
RoleName varchar (30) not null,
RoleDesc varchar (100) not null,
constraint PK_Roles primary key(RoleID))

/* Fake Data and a select * from command to display an example of how table will look */
insert into Roles
(RoleID,RoleName,RoleDesc) 
values
(1,'Administrator','In Charge of Database/Church Management System'),
(2,'TeamLeader','In charge of assigning and managing team members for events'),
(3,'TeamMember','Member of a team for events')
Select * from Roles

create table Teams
(TeamID int not null,
TeamDesc varchar (100),
constraint PK_Teams primary key(TeamID))

/*Fake Data and a select * from command to display an example of how table will look */
insert into Teams
(TeamID,TeamDesc)
values
(1,'Worship Team for Sunday Morning Services'),
(2,'Event Team that handles all church events'),
(3,'Youth Team in charge of planning and teaching children on Sunday mornings')
Select * from Teams


Create table ZipCodes
(ZipCode varchar(15),
City varchar (50),
State varchar(5),
Constraint PK_ZipCodes Primary key(ZipCode))


/*Fake Data and a select * from command to display an example of how table will look */
insert into ZipCodes
(ZipCode,City,State)
values
('46573','Huntington','OR'),
('63822','Kettering','LA'),
('54925','Greensboro','NC')
Select * from ZipCodes


Create Table Users(
UserID int not null,
FirstName varchar(50) not null,
MiddleInitial varchar(1),
LastName varchar(50) not null,
Address_Line1 varchar(50),
Address_Line2 varchar(50),
Phone varchar(14),
Email varchar(50),
ZipCode varchar(15) not null,
RoleID int not null,
Constraint PK_Users Primary Key(UserID),
Constraint FK_Users_ZipCodes Foreign Key (ZipCode) References ZipCodes,
Constraint FK_Users_Roles Foreign Key(RoleID) References Roles,)

/*Fake Data and a select * from command to display an example of how table will look */
insert into Users
(UserID,FirstName,MiddleInitial,LastName,Address_Line1,Address_Line2,Phone,Email,ZipCode,RoleID)
values
(1,'Marie','J','Turnbull','4753 Violet Square','Apt. 871','410-289-7005','marie_turnbull@hotmail.com','46573',1),
(2,'Ike','B','Sykes','824 Juliana Lodge','Apt. 855','582-300-8783','ike_sykes@mail.com','63822',2),
(3,'Audrey','C','Macgregor','401 Stokes Ville','Suite 863','505-644-6394','audrey_macgregor@mail.com','54925',3),
(7,'Jason','B','Sullivan','400 Pacific Street','Apt. 81','510-129-7005','Jason@hotmail.com','63822',1),
(8,'Amanda','L','Oryx','200 Sully Street','Apt. 955','999-999-8883','Amanda@gmail.com','63822',2),
(9,'Michael','N','Sullivan','4th steet','Suite 283','565-222-0094','Michael@gmail.com','63822',3),
(10,'Abby','Z','Tristan','4753 Violet Square','Apt. 871','510-289-7905','Abby@hotmail.com','54925',1),
(11,'Lincoln','','Natter','824 Juliana Lodge','Apt. 855','999-390-8783','Matter@gmail.com','54925',2),
(12,'Lincoln','','McGregor','401 Stokes Ville','Suite 263','565-624-6394','lincoln@gmail.com','54925',3)
Select * from Users



Create Table UserAvailability(
UserID int not null,
DayOfWeek varchar(20),
StartTime time,
EndTime time,
Constraint PK_UserAvailability primary key (UserID),
Constraint FK_UserAvailability_Users Foreign Key (UserID) References Users)

/*Fake Data and a select * from command to display an example of how table will look */
insert into UserAvailability
(UserID,DayOfWeek,StartTime,EndTime)
values
(1,'Sunday','08:00','12:00'),
(2,'Wednesday','17:00','19:30'),
(3,'Friday','18:00','21:00')
Select * from UserAvailability


Create table TeamAssignments(
TeamID int not null,
UserID int not null,
Constraint PK_TeamAssignments primary key(TeamID,UserID),
Constraint FK_TeamAssignments_Teams Foreign Key (TeamID) References Teams,
Constraint FK_TeamAssignments_Users Foreign Key (UserID) References Users)

/*Fake Data and a select * from command to display an example of how table will look */
insert into TeamAssignments
(TeamID,UserID)
values
(1,3),
(2,2),
(3,1)
Select * from TeamAssignments



Create table Logins(
LoginID int not null,
LoginUserName varchar (50),
UserPassword varchar (50),
UserID int not null,
Constraint PK_Logins Primary Key (LoginID),
Constraint FK_Logins_Users Foreign key (UserID) References Users)

insert into Logins
(LoginID,LoginUserName,UserPassword,UserID)
values
(1,'TurnBallM','Password',1),
(2,'SykesI','Password@1',2),
(3,'MacgregorA','Password',3)
Select * From Logins

Create Table Jobs(
JobID int not null,
JobDescription varchar (100),
Constraint PK_Jobs Primary Key (JobID))

insert into Jobs
(JobID,JobDescription)
values
(1,'Perform Music for the venue'),
(2,'Set up, manage, and clean venue'),
(3,'Assist in minor managerial task such as attendance taking, distributing task ,etc.')
Select * From Jobs

Create Table Files(
FileID int not null,
FileDescription varchar(100),
FileTags varchar(50),
FilePath varchar(200),
FileImage varbinary(max),
Constraint PK_Files Primary Key (FileID))

insert into Files
(FileID, FileDescription, FileTags,FilePath,FileImage)
Select
1,'Photo of Easter Holiday Event Logo','Events','C:\Users\Domanrovil Ovalle\OneDrive\Documents\School\CapstoneDatabase', BulkColumn
FROM Openrowset( Bulk 'C:\Users\Domanrovil Ovalle\OneDrive\Documents\School\CapstoneDatabase\EasterHoliday.jpg', Single_Blob) as image
Select * From Files

/* Seperated EventDateTime and created new columns to add more detail to the specific time and date*/
/* Change EventStart Date and time to be together
EventStartDateTime EventEndDateTime*/

Create Table Events(
EventID int not null,
EventName varchar(100),
EventStartDateTime DateTime, 
EventEndDateTime DateTime,
UserID int not null,
Constraint PK_Events Primary Key (EventID),
constraint FK_Events_Users foreign key (UserID) references Users)

/* ===========================================
=========ALTER column data type==============
=============================================*/ 
alter table Events
alter column EventEndDateTime smalldatetime

Alter table Events
Alter column EventStartDateTime smalldatetime
/* ===========================================
=========End of ALTER==============
=============================================*/ 

/* Experimenting on formatting of StartDateTime may or may not be part of final product  
=====================================================================*/
select * from Events
SELECT FORMAT(EventStartDateTime, 'dd-MM-yyyy hh:mm:ss tt') as [Event Start Date and Time]
FROM Events
/* End of Formatting experiment*/


Insert into Events
(EventID, EventName, EventStartDateTime, EventEndDateTime,UserId)
Values
(1,'EasterHoliday','2022-04-17 10:30:00','2022-04-17 13:00:00',1),
(2,'Valentine Event','2022-04-13 10:30:00','2022-04-13 13:00:00',1)
Select * From Events


Create table FileShares(
FileID int not null,
TeamID int not null,
EventID int not null,
Constraint PK_FileShares Primary Key (FileID,TeamID),
Constraint Fk_Fileshares_Files foreign key (FileID) References Files,
Constraint FK_FileShares_Teams foreign key (TeamID) References Teams,
Constraint FK_FileShares_Events foreign key (EventID) References Events)

Insert into FileShares
(FileID, TeamID, EventID)
values
(1,1,1),
(1,2,2),
(1,3,2)
Select * From FileShares



Create table Shifts(
ShiftID Int not null,
Date date,
StartTime time,
EndTime time,
UserID int not null,
JobID int not null,
EventID int not null,
Constraint PK_Shifts Primary Key (ShiftID),
Constraint FK_Shifts_Users foreign key (UserID) references Users,
Constraint FK_Shifts_Jobs Foreign Key (JobID) References Jobs,
Constraint FK_Shifts_Events Foreign Key (EventID) References Events)

Insert into Shifts
(ShiftID,Date,StartTime,EndTime,UserID,JobID,EventID)
values
(1,'2/13/2022','10:00','12:30', 1,1,1),
(2,'2/13/2022','10:00','12:30',2,1,2),
(3,'2/13/2022','10:00','12:30', 3,2,2)
select * From shifts









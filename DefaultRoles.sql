/* Adds default roles to database Example for Client (NOT FINAL)*/

USE ChurchVMS;

INSERT INTO Roles VALUES (1, 'Applicant', 'Applied and pending approval');
INSERT INTO Roles VALUES (2, 'Volunteer', 'Approved volunteer');
INSERT INTO Roles VALUES (3, 'Team Leader', 'Volunteer who manages a team');
INSERT INTO Roles VALUES (4, 'Administrator', 'Has full authority to manage system'); 

SELECT * FROM Roles;

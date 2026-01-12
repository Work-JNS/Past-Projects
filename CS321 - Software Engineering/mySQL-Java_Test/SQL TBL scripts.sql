SQL TBL scripts


ImmForm:
CREATE TABLE ImmForm (
    id INT NOT NULL AUTO_INCREMENT,
    petitionerANumm VARCHAR(255) NOT NULL,
    depANumm VARCHAR(255) NOT NULL,
    dateCreated DATE NOT NULL,
    PRIMARY KEY (id)
);


Immigrant:
CREATE TABLE Immigrant (
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    A_Number VARCHAR(20) NOT NULL,
    Is_Dep BOOLEAN NOT NULL,
    PRIMARY KEY (A_Number)
);

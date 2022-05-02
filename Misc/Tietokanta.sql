/*
Tietokanta frisbeegolfista. Alussa tietokannan ja taulujen luonti, sen jälkeen taulujen populointi. Näiden jälkeen viisi kyselyä.

Ohjeet tietokannan käyttöönottoa varten:

1. CREATE DATABASE Frisbeegolfkisat;
2. päivitä
3. USE DATABASE frisbeegolfkisat;
4. Suorita (aja) taulujen luonti ja populointi
5. Tee kyselyitä

Copyright: Jussi Kukkonen
Päivämäärä 15.3.2021

Tietokanta frisbeegolf kisoista, jossa pelaajien tiedot ovat kuvitteellisia, mutta sponsorit ja kilpailupaikat ovat oikeita, nykymaailmasta löytyviä. Käytetty seuraavia ohjelmia: MariaDB ja MySQL.

*/

DROP DATABASE Frisbeegolfkisat;

CREATE DATABASE Frisbeegolfkisat;

USE DATABASE frisbeegolfkisat;

-- TAULUJEN LUONTI --

CREATE TABLE Kilpailusarja
(
  Ika 					    INT,
  pdgaRating 			  VARCHAR(25),
  Sukupuoli 			  VARCHAR(25),
  KilpailusarjaID 	INT NOT NULL,
  PRIMARY KEY (KilpailusarjaID)
);

CREATE TABLE SponsoriTyyppi
(
  SponsoriTyyppiID 			INT,
  PRIMARY KEY (SponsoriTyyppiID)
);

CREATE TABLE Kilpailu
(
  Kilpailupvm DATE,
  Rata VARCHAR(50),
  KilpailuID INT NOT NULL,
  KilpailusarjaID INT NOT NULL,
  PRIMARY KEY (KilpailuID),
  FOREIGN KEY (KilpailusarjaID) REFERENCES Kilpailusarja(KilpailusarjaID)
);

CREATE TABLE Sponsori
(
  SponsoriID INT NOT NULL,
  Sponsori_nimi VARCHAR(25),
  Sponsori_maa VARCHAR(25),
  SponsoriTyyppiID INT,
  PRIMARY KEY (SponsoriID),
  FOREIGN KEY (SponsoriTyyppiID) REFERENCES SponsoriTyyppi(SponsoriTyyppiID)
);

CREATE TABLE Sponsoroida
(
  SponsoriID INT NOT NULL,
  KilpailuID INT NOT NULL,
  PRIMARY KEY (SponsoriID, KilpailuID),
  FOREIGN KEY (SponsoriID) REFERENCES Sponsori(SponsoriID),
  FOREIGN KEY (KilpailuID) REFERENCES Kilpailu(KilpailuID)
);

CREATE TABLE Kilpailija
(
  KilpailijaID INT NOT NULL,
  Maa VARCHAR(25),
  Ika INT,
  Kilpailutaso VARCHAR(25),
  Sukupuoli VARCHAR(25),
  Etunimi VARCHAR(25),
  Sukunimi VARCHAR(25),
  SponsoriID INT NOT NULL,
  PRIMARY KEY (KilpailijaID),
  FOREIGN KEY (SponsoriID) REFERENCES Sponsori(SponsoriID)
);

CREATE TABLE Osallistuu
(
  Tulos INT,
  Sijoitus INT,
  KilpailuID INT NOT NULL,
  KilpailijaID INT NOT NULL,
  PRIMARY KEY (KilpailuID, KilpailijaID),
  FOREIGN KEY (KilpailuID) REFERENCES Kilpailu(KilpailuID),
  FOREIGN KEY (KilpailijaID) REFERENCES Kilpailija(KilpailijaID)
);


-- TAULUJEN POPULOINTI --

INSERT INTO kilpailusarja (Ika, pdgaRating, Sukupuoli, KilpailusarjaID) VALUES (NULL, NULL, 'male', 1);
INSERT INTO kilpailusarja (Ika, pdgaRating, Sukupuoli, KilpailusarjaID) VALUES (NULL, NULL, 'female', 2);

INSERT INTO sponsorityyppi (SponsoriTyyppiID) VALUES (1);

INSERT INTO Kilpailu (Kilpailupvm, Rata, KilpailuID, KilpailusarjaID) VALUES ('2020-06-15', 'Lake Eureka DGC, Illinous (USA)', 1, 1); -- Lake Eureka DISC GOLF COURSE | Peoria, ILLINOUS (USA), kilpailuID ja KilpailusarjaID en tiedä mitä niissä olis..
INSERT INTO Kilpailu (Kilpailupvm, Rata, KilpailuID, KilpailusarjaID) VALUES ('2020-06-15', 'Lake Eureka DGC', 2, 2);

INSERT INTO Sponsori (SponsoriID, Sponsori_nimi, Sponsori_maa, SponsoriTyyppiID) VALUES (1, 'Latitude 64', 'Sweden', 1);
INSERT INTO Sponsori (SponsoriID, Sponsori_nimi, Sponsori_maa, SponsoriTyyppiID) VALUES (2, 'Innova', 'USA', 1);
INSERT INTO Sponsori (SponsoriID, Sponsori_nimi, Sponsori_maa, SponsoriTyyppiID) VALUES (3, 'Discmania', 'Finland', 1);
INSERT INTO Sponsori (SponsoriID, Sponsori_nimi, Sponsori_maa, SponsoriTyyppiID) VALUES (4, 'Discraft', 'USA', 1);
INSERT INTO Sponsori (SponsoriID, Sponsori_nimi, Sponsori_maa, SponsoriTyyppiID) VALUES (5, 'Prodigy', 'USA', 1);
INSERT INTO Sponsori (SponsoriID, Sponsori_nimi, Sponsori_maa, SponsoriTyyppiID) VALUES (6, 'Dynamic Discs', 'USA', 1);

INSERT INTO sponsoroida (SponsoriID, KilpailuID) VALUES (1, 1);

INSERT INTO Kilpailija (KilpailijaID, Maa, Ika, Kilpailutaso, Sukupuoli, Etunimi, Sukunimi, SponsoriID) VALUES (1, 'Finland', 21, 'pro', 'male', 'Oliver', 'Kulmala', 5); 		-- sponsorisopimustyyppi 1 (jatkosopimus)
INSERT INTO Kilpailija (KilpailijaID, Maa, Ika, Kilpailutaso, Sukupuoli, Etunimi, Sukunimi, SponsoriID) VALUES (2, 'USA', 23, 'pro', 'male', 'Donald', 'Thrussell', 3);				-- sponsorisopimustyyppi 1 
INSERT INTO Kilpailija (KilpailijaID, Maa, Ika, Kilpailutaso, Sukupuoli, Etunimi, Sukunimi, SponsoriID) VALUES (3, 'Finland', 18, 'pro', 'male', 'Ransu', 'Tuominen', 5);	-- sponsorisopimustyyppi 3 (promosopimus)
INSERT INTO Kilpailija (KilpailijaID, Maa, Ika, Kilpailutaso, Sukupuoli, Etunimi, Sukunimi, SponsoriID) VALUES (4, 'USA', 35, 'pro', 'male', 'Koby', 'Moore', 4);				-- sponsorisopimustyyppi 2 (siirtosopimus)
INSERT INTO Kilpailija (KilpailijaID, Maa, Ika, Kilpailutaso, Sukupuoli, Etunimi, Sukunimi, SponsoriID) VALUES (5, 'Estonia', 23, 'pro', 'male', 'Tanel', 'Pärn', 1);			-- sponsorisopimustyyppi 1
INSERT INTO Kilpailija (KilpailijaID, Maa, Ika, Kilpailutaso, Sukupuoli, Etunimi, Sukunimi, SponsoriID) VALUES (6, 'Finland', 21, 'pro', 'female', 'Vilhemiina', 'Jokela', 2);	-- sponsorisopimustyyppi 1
INSERT INTO Kilpailija (KilpailijaID, Maa, Ika, Kilpailutaso, Sukupuoli, Etunimi, Sukunimi, SponsoriID) VALUES (7, 'USA', 30, 'pro', 'female', 'Emely', 'Tracy', 4);			-- sponsorisopimustyyppi 1
INSERT INTO Kilpailija (KilpailijaID, Maa, Ika, Kilpailutaso, Sukupuoli, Etunimi, Sukunimi, SponsoriID) VALUES (8, 'Estonia', 28, 'pro', 'female', 'Veronika', 'Mägi', 1);	-- sponsorisopimustyyppi 1
INSERT INTO Kilpailija (KilpailijaID, Maa, Ika, Kilpailutaso, Sukupuoli, Etunimi, Sukunimi, SponsoriID) VALUES (9, 'USA', 36, 'pro', 'female', 'Alysha', 'Cooper', 5);			-- sponsorisopimustyyppi 1
INSERT INTO Kilpailija (KilpailijaID, Maa, Ika, Kilpailutaso, Sukupuoli, Etunimi, Sukunimi, SponsoriID) VALUES (10, 'USA', 19, 'pro', 'female', 'Clementine', 'Benton', 6);	-- sponsorisopimustyyppi 1

INSERT INTO Osallistuu (Tulos, Sijoitus, KilpailuID, KilpailijaID) VALUES (-35, 2, 1, 1);
INSERT INTO Osallistuu (Tulos, Sijoitus, KilpailuID, KilpailijaID) VALUES (-37, 1, 1, 2);
INSERT INTO Osallistuu (Tulos, Sijoitus, KilpailuID, KilpailijaID) VALUES (-27, 4, 1, 3);
INSERT INTO Osallistuu (Tulos, Sijoitus, KilpailuID, KilpailijaID) VALUES (-34, 3, 1, 4);
INSERT INTO Osallistuu (Tulos, Sijoitus, KilpailuID, KilpailijaID) VALUES (-25, 5, 1, 5);
INSERT INTO Osallistuu (Tulos, Sijoitus, KilpailuID, KilpailijaID) VALUES (-22, 3, 2, 6);
INSERT INTO Osallistuu (Tulos, Sijoitus, KilpailuID, KilpailijaID) VALUES (-26, 1, 2, 7);
INSERT INTO Osallistuu (Tulos, Sijoitus, KilpailuID, KilpailijaID) VALUES (-24, 2, 2, 8);
INSERT INTO Osallistuu (Tulos, Sijoitus, KilpailuID, KilpailijaID) VALUES (-20, 5, 2, 9);
INSERT INTO Osallistuu (Tulos, Sijoitus, KilpailuID, KilpailijaID) VALUES (-21, 4, 2, 10);
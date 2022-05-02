-- Kyselyt --

/*
Hae kaikkien pelaajien tulos, etunimi, sukunimi. Lajittele tuloksen mukaan.
*/
SELECT o.Tulos, k.Etunimi, k.Sukunimi
    FROM osallistuu o
    INNER JOIN kilpailija k
    ON o.KilpailijaID = k.KilpailijaID
    ORDER BY o.Tulos;

/*
Hae ne pelajaat, joiden tulos on väliltä -30 ja -25. Hae pelaajien tulos, etunimi,
sukunimi. Lajittele tuloksen mukaan.
*/
SELECT o.Tulos, k.Etunimi, k.Sukunimi
    FROM osallistuu o
    INNER JOIN kilpailija k
    ON o.KilpailijaID = k.KilpailijaID
    WHERE o.Tulos BETWEEN -30 AND -25
    ORDER BY o.Tulos;

/*
Hae kaikki suomalaiset pelaajat. Hae heidän etunimi, sukunimi sekä sponsorin nimi.
Lajittele sukunimen mukaan.
*/
SELECT k.Etunimi, k.Sukunimi, s.Sponsori_nimi AS 'sponsori'
    FROM kilpailija k
    INNER JOIN sponsori s
    ON k.SponsoriID = s.SponsoriID
    WHERE k.Maa = 'Finland'
    ORDER BY k.Sukunimi;

/*
Hae kaikki pelaajat, joiden sponsorin nimi alkaa D -kirjaimella. Hae pelaajan
sponsorin nimi, pelaajan sukunimi, etunimi. Lajittele sponsorin nimen mukaan.
*/
SELECT s.Sponsori_nimi AS 'sponsori', k.Etunimi, k.Sukunimi
    FROM kilpailija k
    INNER JOIN sponsori s
    ON k.SponsoriID = s.SponsoriID
    WHERE s.Sponsori_nimi LIKE 'D%';

/*
Kuinka monta sponsoroitavaa kullakin sponsorilla on? Hae sponsorin nimi, sekä sponsoroitavien lukumäärä.
Lajittele lukumäärän perusteella laskevasti.
*/
SELECT s.Sponsori_nimi AS 'sponsori', count(k.SponsoriID) AS 'sponsoroitavat'
    FROM sponsori s
    INNER JOIN kilpailija k
    ON s.SponsoriID = k.SponsoriID
    GROUP BY s.Sponsori_nimi
    ORDER BY 2 DESC;
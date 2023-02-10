CREATE TABLE planets (
    name TEXT PRIMARY KEY,
    orbital_period FLOAT NOT NULL,
    star_name TEXT NOT NULL REFERENCES stars
);

CREATE TABLE stars (
    name TEXT PRIMARY KEY,
    temp TEXT NOT NULL
);

CREATE TABLE moons (
    name TEXT PRIMARY KEY,
    planet_name TEXT NOT NULL REFERENCES planets
);

INSERT INTO planets (name, orbital_period, star_name)
VALUES ('Earth', 1.00, 'The Sun'),
('Mars', 1.882, 'The Sun'),
('Venus', 0.62, 'The Sun'),
('Proxima Centauri b', 0.03, 'Proxima Centauri'),
('Gliese 876 b', 0.236, 'Gliese 876');

INSERT INTO moons (name, planet_name)
VALUES ('The Moon', 'Earth'),
('Phobos', 'Mars'),
('Deimos', 'Mars');

SELECT planets.name AS planet, stars.name AS star, COUNT(moons.name) AS moon_count
    FROM planets
    JOIN stars ON stars.name = planets.star_name
    LEFT JOIN moons ON planets.name = moons.planet_name
    GROUP BY planets.name, stars.name
    ORDER BY planets.name;


planets.planet_name and planets.star instead
more specific units
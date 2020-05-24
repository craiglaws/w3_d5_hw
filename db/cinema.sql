DROP TABLE tickets;
DROP TABLE screenings;
DROP TABLE films;
DROP TABLE customers;

CREATE TABLE customers(
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  funds INT
);

CREATE TABLE films(
  id SERIAL PRIMARY KEY,
  title VARCHAR(255),
  price INT
);


CREATE TABLE screenings(
  id SERIAL PRIMARY KEY,
  showtime TIME,
  tickets_sold INT,
  film_id INT REFERENCES films(id)
);

CREATE TABLE tickets(
  id SERIAL PRIMARY KEY,
  customer_id INT REFERENCES customers(id),
  film_id INT REFERENCES films(id),
  screening_id INT REFERENCES screenings(id)
);

## CodeClan Cinema (CCC (again))

:star: This is a PDA Homework :star:

Create a system that handles bookings for our newly built cinema!
It's enough if you can call your methods in pry, don't worry about an interface.

### Your app should have:
  - Customers
    - name
    - funds

  - Films
    - title
    - price

  - Tickets
    - customer_id
    - film_id

### Your app should be able to:
  x Create customers, films and tickets
  x CRUD actions (create, read, update, delete) customers, films and tickets.
  x Show which films a customer has booked to see, and see which customers are coming to see one film.

### Basic extensions:
  - Buying tickets should decrease the funds of the customer by the price
  x Check how many tickets were bought by a customer
  x Check how many customers are going to watch a certain film

### Advanced extensions:
  - Create a screenings table that lets us know what time films are showing
  - Write a method that finds out what is the most popular time (most tickets sold) for a given film
  - Limit the available tickets for screenings.
  - Add any other extensions you think would be great to have at a cinema!

### PDA Reminder:

As part of this homework you are required to take screenshots of the following:

```
Demonstrate searching data in a program. Take screenshots of:
 - Function that searches data
 - The result of the function running
```

```
Demonstrate sorting data in a program. Take screenshots of:
 - Function that sorts data
 - The result of the function running
```


- Submit your PDA evidence (screenshots, etc.) to Canvas

- PDA Reference: I.T 3 & I.T 4

- Customers
    id SERIAL PRIMARY KEY
    name VARCHAR(255)
    funds INT

- Films
    id SERIAL PRIMARY KEY
    title VARCHAR(255)
    price INT

- Tickets
    id SERIAL PRIMARY KEY
    customer_id  REFERENCES customers.id
    film_id REFERENCES films.id

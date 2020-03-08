require('pg')
require('pry')

require_relative('../db/sql_runner.rb')

require_relative('film.rb')
require_relative('customer.rb')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save() # CREATE
    sql = "INSERT INTO tickets
            (customer_id, film_id)
            VALUES
            ($1, $2)
            RETURNING id"
    values = [@customer_id, @film_id]

    ticket_hash = SqlRunner.run(sql, values).first()
    @id = ticket_hash['id'].to_i

    customer = Customer.find_customer_by_id(@customer_id).first   # Finds customer by id and saves object
    film = Film.find_film_by_id(@film_id).first                   # Finds film by id and saves object

    customer.funds -= film.price                                  # Deducts the film's price from the customer's funds in the created customer object

    customer.update()                                             # Updates the customer with the customer object created before
    # "Inner join"? Never heard of it.

  end

  def update() # UPDATE
    sql = "UPDATE tickets SET
            (customer_id, film_id)
            =
            ($1, $2)
            WHERE
            id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def self.all # READ
    sql = "SELECT * FROM tickets"
    tickets_array = SqlRunner.run(sql)

    return tickets_array.map { |ticket_hash| Ticket.new(ticket_hash) }
  end

  def self.delete_all # DELETE
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end

require('pg')
require('pry')

require_relative('../db/sql_runner.rb')

require_relative('film.rb')
require_relative('ticket.rb')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save() # CREATE
    sql = "INSERT INTO customers
            (name, funds)
            VALUES
            ($1, $2)
            RETURNING id"
    values = [@name, @funds]

    customers_hash = SqlRunner.run(sql, values).first()
    @id = customers_hash['id'].to_i
  end

  def update() # UPDATE
    sql = "UPDATE customers SET
            (name, funds)
            =
            ($1, $2)
            WHERE
            id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def all_films()
    sql = "SELECT films.* FROM films
            INNER JOIN tickets ON tickets.film_id = films.id
            WHERE customer_id = $1"
    values = [@id]

    film_array = SqlRunner.run(sql, values)
    return film_array.map { |film_hash| Film.new(film_hash)}
  end

  def self.all() # READ
    sql = "SELECT * FROM customers"
    customer_array = SqlRunner.run(sql)
    return customer_array.map { |customer_hash| Customer.new(customer_hash) }
  end

  def self.delete_all() # DELETE
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end

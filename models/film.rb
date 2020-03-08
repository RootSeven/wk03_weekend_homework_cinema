require('pg')
require('pry')

require_relative('../db/sql_runner.rb')

require_relative('customer.rb')
require_relative('ticket.rb')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save() # CREATE
    sql = "INSERT INTO films
            (title, price)
            values
            ($1, $2)
            RETURNING id"
    values = [@title, @price]

    film_array = SqlRunner.run(sql, values).first()
    @id = film_array['id'].to_i
  end

  def update() # UPDATE
    sql = "UPDATE films SET
            (title, price)
            =
            ($1, $2)
            WHERE
            id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def all_customers()
    sql = "SELECT customers.* FROM customers
            INNER JOIN tickets ON tickets.customer_id = customers.id
            WHERE film_id = $1"
    values = [@id]

    customer_array = SqlRunner.run(sql, values)
    return customer_array.map { |customer_hash| Customer.new(customer_hash) }
  end

  def number_of_customers()
    self.all_customers().length
  end

  def self.all() # READ
    sql = "SELECT * FROM films"
    film_array = SqlRunner.run(sql)
    return film_array.map { |film_hash| Film.new(film_hash) }
  end

  def self.find_film_by_id(id_to_find)
    sql = "SELECT * FROM films WHERE films.id = $1"
    values = [id_to_find]
    film_array = SqlRunner.run(sql, values)
    return film_array.map { |film_hash| Film.new(film_hash) }
  end

  def self.delete_all() # DELETE
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end

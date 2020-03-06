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

  def self.all() # READ
    sql = "SELECT * FROM films"
    film_array = SqlRunner.run(sql)
    return film_array.map { |film_hash| Film.new(film_hash) }
  end

  def self.delete_all() # DELETE
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

end
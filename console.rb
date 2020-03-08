require('pg')
require('pry')

require_relative('db/sql_runner.rb')

require_relative('models/customer.rb')
require_relative('models/film.rb')
require_relative('models/ticket.rb')

Ticket.delete_all
Customer.delete_all
Film.delete_all

# INSTANTIATE CUSTOMERS
customer1 = Customer.new( {'name' => 'Julie',
                            'funds' => 300} )
customer1.save()

customer2 = Customer.new( {'name' => 'Kaleidoscope',
                            'funds' => 200} )
customer2.save()

customer3 = Customer.new( {'name' => 'Limone',
                            'funds' => 100} )
customer3.save()

# INSTANTIATE FILMS
film1 = Film.new( {'title' => 'Red Dragon',
                    'price' => 3} )
film1.save()

film2 = Film.new( {'title' => 'Silence of the Lambs',
                    'price' => 10} )
film2.save()

# INSTANTIATE TICKETS
ticket1 = Ticket.new( {'customer_id' => customer1.id,
                    'film_id' => film2.id} )
ticket1.save()

ticket2 = Ticket.new( {'customer_id' => customer1.id,
                    'film_id' => film1.id} )
ticket2.save()

binding.pry
nil

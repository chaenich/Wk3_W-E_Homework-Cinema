require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')

require('pry')

Ticket.delete_all();
Customer.delete_all();
Film.delete_all();

customer1 = Customer.new( {
  'name' => 'Bob1',
  'funds' => 200
})
customer1.save()

customer2 = Customer.new( {
  'name' => 'Jim2',
  'funds' => 45
})
customer2.save()

customer3 = Customer.new( {
  'name' => 'Jane3',
  'funds' => 75
})
customer3.save()

film1 = Film.new( {
  'title' => 'Best Film 1',
  'price' => 8
})
film1.save()

film2 = Film.new( {
  'title' => 'Second Best Film 2',
  'price' => 15
})
film2.save()

film3 = Film.new( {
  'title' => 'Third Best Film 3',
  'price' => 10
})
film3.save()

ticket1 = Ticket.new( {
  'customer_id' => customer1.id, 'film_id' => film1.id
})
ticket1.save()

ticket2 = Ticket.new( {
  'customer_id' => customer1.id, 'film_id' => film2.id
})
ticket2.save()

ticket3 = Ticket.new( {
  'customer_id' => customer2.id, 'film_id' => film1.id
})
ticket3.save()

ticket4 = Ticket.new( {
  'customer_id' => customer2.id, 'film_id' => film2.id
})
ticket4.save()

ticket5 = Ticket.new( {
  'customer_id' => customer2.id, 'film_id' => film3.id
})
ticket5.save()

ticket6 = Ticket.new( {
  'customer_id' => customer3.id, 'film_id' => film1.id
})
ticket6.save()

binding.pry
nil

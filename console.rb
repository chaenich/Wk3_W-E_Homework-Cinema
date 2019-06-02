require_relative('models/customers.rb')
require_relative('models/films.rb')
require_relative('models/tickets.rb')
require_relative('models/screenings.rb')

require('pry')

Ticket.delete_all();
Screening.delete_all();
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

# ------------

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

# ------------

screening1 = Screening.new( {
  'show_time' => '17:00', 'max_viewers' => 50, 'film_id' => film1.id
} )
screening1.save()

screening2 = Screening.new( {
  'show_time' => '19:00', 'max_viewers' => 60, 'film_id' => film1.id
} )
screening2.save()

screening3 = Screening.new( {
  'show_time' => '15:30', 'max_viewers' => 75, 'film_id' => film2.id
} )
screening3.save()

screening4 = Screening.new( {
  'show_time' => '21:30', 'max_viewers' => 60, 'film_id' => film2.id
} )
screening4.save()

screening5 = Screening.new( {
  'show_time' => '16:00', 'max_viewers' => 50, 'film_id' => film3.id
} )
screening5.save()

screening6 = Screening.new( {
  'show_time' => '18:00', 'max_viewers' => 50, 'film_id' => film3.id
} )
screening6.save()

# ------------

ticket1 = Ticket.new( {
  'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening1.id
})
ticket1.save()

ticket2 = Ticket.new( {
  'customer_id' => customer1.id, 'film_id' => film2.id, 'screening_id' => screening3.id
})
ticket2.save()

ticket3 = Ticket.new( {
  'customer_id' => customer1.id, 'film_id' => film3.id, 'screening_id' => screening5.id
})
ticket3.save()

ticket4 = Ticket.new( {
  'customer_id' => customer1.id, 'film_id' => film1.id, 'screening_id' => screening2.id
})
ticket4.save()

ticket5 = Ticket.new( {
  'customer_id' => customer1.id, 'film_id' => film2.id, 'screening_id' => screening4.id
})
ticket5.save()

ticket6 = Ticket.new( {
  'customer_id' => customer2.id, 'film_id' => film3.id, 'screening_id' => screening5.id
})
ticket6.save()

ticket7 = Ticket.new( {
  'customer_id' => customer2.id, 'film_id' => film1.id, 'screening_id' => screening2.id
})
ticket7.save()

ticket8 = Ticket.new( {
  'customer_id' => customer2.id, 'film_id' => film2.id, 'screening_id' => screening3.id
})
ticket8.save()

ticket9 = Ticket.new( {
  'customer_id' => customer3.id, 'film_id' => film3.id, 'screening_id' => screening5.id
})
ticket9.save()

ticket10 = Ticket.new( {
  'customer_id' => customer3.id, 'film_id' => film1.id, 'screening_id' => screening2.id
})
ticket10.save()

ticket11 = Ticket.new( {
  'customer_id' => customer3.id, 'film_id' => film2.id, 'screening_id' => screening4.id
})
ticket11.save()

ticket12 = Ticket.new( {
  'customer_id' => customer3.id, 'film_id' => film3.id, 'screening_id' => screening6.id
})
ticket12.save()

binding.pry
nil

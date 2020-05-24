require_relative('models/customer')
require_relative('models/film')
require_relative('models/screening')
require_relative('models/ticket')

require('pry')

Ticket.delete_all()
Screening.delete_all()
Film.delete_all()
Customer.delete_all()


  customer1 = Customer.new( {
    'name' => 'Craig',
    'funds' => 30
    })
    customer1.save()

  customer2 = Customer.new( {
    'name' => 'Emily',
    'funds' => 50
    })
    customer2.save()

  customer3 = Customer.new( {
    'name' => 'Tom',
      'funds' => 6
    })
    customer3.save()








  film1 = Film.new({
    'title' => 'Kingpin',
    'price' => 5
    })
    film1.save()

  film2 = Film.new({
    'title' => 'Whiplash',
    'price' => 8
    })
    film2.save()

  film3 = Film.new({
    'title' => 'Uncle Buck',
    'price' => 3
    })
    film3.save






  screening1 = Screening.new({
    'showtime' => '20:00',
    'film_id' => film1.id
    })
  screening1.save()


  screening2 = Screening.new({
    'showtime' => '12:00',
    'film_id' => film2.id
    })
  screening2.save()


  screening3 = Screening.new({
    'showtime' => '17:00',
    'film_id' => film3.id
    })
  screening3.save()






  ticket1 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film1.id,
    'screening_id' => screening1.id
    })
    ticket1.save()

  ticket2 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film2.id,
    'screening_id' => screening2.id
    })
    ticket2.save()

  ticket3 = Ticket.new({
    'customer_id' => customer1.id,
    'film_id' => film3.id,
    'screening_id' => screening3.id
    })
    ticket3.save()

  ticket4 = Ticket.new({
    'customer_id' => customer2.id,
    'film_id' => film1.id,
    'screening_id' => screening1.id
    })
    ticket4.save()

  ticket5 = Ticket.new({
    'customer_id' => customer2.id,
    'film_id' => film2.id,
    'screening_id' => screening2.id
    })
    ticket5.save()

  ticket6 = Ticket.new({
    'customer_id' => customer3.id,
    'film_id' => film1.id,
    'screening_id' => screening1.id
    })
    ticket6.save()








binding.pry
nil

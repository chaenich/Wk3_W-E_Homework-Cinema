require_relative('../db/sql_runner')
require('pry')

class Customer

  attr_accessor :name, :funds
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds'].to_i
  end

  def save()
    sql = "INSERT INTO customers
      (name, funds)
      VALUES
      ($1, $2)
      RETURNING id"
    values = [@name, @funds]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE customers
      SET
      (name, funds)
      =
      ($1, $2)
      WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete_by_id()
    sql = "DELETE FROM customers
      WHERE id = $1"
    values =[@id]
    SqlRunner.run(sql, values)
  end

  def films()
    sql = "SELECT films.* FROM films
      INNER JOIN
      tickets ON tickets.film_id = films.id
      WHERE customer_id = $1"
    values = [@id]
    films_data = SqlRunner.run(sql, values)
    return Film.map_all(films_data)
  end

  def buy_ticket(film_id)
    price = Film.get_ticket_price(film_id)
    @funds -= price
  end

  def self.all()
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    return Customer.map_all(customers)
  end

  def self.map_all(customer_data)
    customer = customer_data.map { |customer| Customer.new(customer) }
    return customer
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

end

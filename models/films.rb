require_relative('../db/sql_runner')
require('pry')

class Film

  attr_accessor :title, :price
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price'].to_i
  end

  def save()
    sql = "INSERT INTO films
      (title, price)
      VALUES
      ($1, $2)
      RETURNING id"
    values = [@title, @price]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE films
      SET
      (title, price)
      =
      ($1, $2)
      WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete_by_id()
    sql = "DELETE FROM films
      WHERE id = $1"
    values =[@id]
    SqlRunner.run(sql, values)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
      INNER JOIN
      tickets on tickets.customer_id = customers.id
      WHERE film_id = $1"
    values = [@id]
    customers_data = SqlRunner.run(sql, values)
    return Customer.map_all(customers_data)
  end

  def screen_times()
    sql = "SELECT *
      FROM screenings
      WHERE film_id = $1"
    values = [@id]
    screening_data = SqlRunner.run(sql, values)
    return Screening.map_all(screening_data)
  end

  def self.all()
    sql = "SELECT * FROM films"
    films = SqlRunner.run(sql)
    return Film.map_all(films)
  end

  def self.map_all(film_data)
    film = film_data.map { |film| Film.new(film) }
    return film
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  # Basic Extension
  def self.get_film_details(film_id)
    sql = "SELECT *
      FROM films
      WHERE id = $1"
    values = [film_id]
    film = SqlRunner.run(sql, values).first
    return film
  end

  # Basic Extension
  def self.customer_count(film_id)
    sql = "SELECT count(*)
      FROM tickets
      WHERE film_id =$1"
    values = [film_id]
    cust_count = SqlRunner.run(sql, values).first
    return cust_count['count'].to_i
  end

end

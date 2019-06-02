require_relative('../db/sql_runner')
require('pry')

class Screening

  attr_accessor :show_time, :max_viewers, :film_id
  attr_reader :id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @show_time = options['show_time']
    @max_viewers = options['max_viewers'].to_i
    @film_id = options['film_id'].to_i
  end

  def save()
    sql = "INSERT INTO screenings
      (show_time, max_viewers, film_id)
      VALUES
      ($1, $2, $3)
      RETURNING id"
    values = [@show_time, @max_viewers, @film_id]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE screenings
      SET
      (show_time, max_viewers, film_id)
      =
      ($1, $2, $3)
      WHERE id = $4"
    values = [@show_time, @max_viewers, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete_by_id()
    sql = "DELETE FROM screenings
      WHERE id = $1"
    values =[@id]
    SqlRunner.run(sql, values)
  end

# To be changed for screenings
def customers()
    sql = "SELECT customers.* FROM customers
      INNER JOIN
      tickets on tickets.customer_id = customers.id
      WHERE film_id = $1"
    values = [@id]
    customers_data = SqlRunner.run(sql, values)
    return Customer.map_all(customers_data)
  end


  def self.all()
    sql = "SELECT * FROM screenings"
    screenings = SqlRunner.run(sql)
    return Screening.map_all(screenings)
  end

  def self.map_all(screening_data)
    screening = screening_data.map { |screening| Screening.new(screening) }
    return screening
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end

  # Basic Extension - To be changed?
  def self.customer_count(film_id)
    sql = "SELECT count(*)
      FROM tickets
      WHERE film_id =$1"
    values = [film_id]
    cust_count = SqlRunner.run(sql, values).first
    return cust_count['count'].to_i
  end

end

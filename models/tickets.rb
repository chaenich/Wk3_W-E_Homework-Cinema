require_relative('../db/sql_runner')
require('pry')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id']
    @film_id = options['film_id']
  end

  def save()
    sql = "INSERT INTO tickets
      (customer_id, film_id)
      VALUES
      ($1, $2)
      RETURNING id"
    values =[@customer_id, @film_id]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def update()
    sql = "UPDATE tickets
      SET
      (customer_id, film_id)
      =
      ($1, $2)
      WHERE id = $3"
    values = [@customer_id, @film_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete_by_id()
    sql = "DELETE FROM tickets
      WHERE id = $1"
    values =[@id]
    SqlRunner.run(sql, values)
  end


  def self.all()
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    return Ticket.map_all(tickets)
  end

  def self.map_all(ticket_data)
    ticket = ticket_data.map { |ticket| Ticket.new(ticket) }
    return ticket
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

end

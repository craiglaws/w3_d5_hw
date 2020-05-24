require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
    @screening_id = options['screening_id'].to_i
  end



  def save()

    if funds_checker() == true
      sql = "INSERT INTO tickets (customer_id, film_id, screening_id) VALUES ($1, $2, $3) RETURNING id"
      values = [@customer_id, @film_id, @screening_id]
      ticket = SqlRunner.run(sql, values)[0]
      @id = ticket['id'].to_i
      charge_customer()
      update_tickets_sold()

    end
  end

  def delete()
    sql = "DELETE FROM tickets where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM tickets WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values).first
    return Ticket.new(pg_result)
  end

  def self.list_all()
    sql = "SELECT * FROM tickets"
    pg_result = SqlRunner.run(sql)
    return pg_result.map {|ticket| Ticket.new(ticket)}
  end

  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def funds_checker()
    sql = "SELECT * FROM customers, films
            WHERE customers.id = $1
              AND films.id = $2
                AND customers.funds >= films.price;"
    values = [@customer_id, @film_id]
    result = SqlRunner.run(sql, values)
    if result.count > 0
      return true
    else
      return false
    end
  end

  def get_film_price()
    sql = "SELECT films.price FROM films WHERE films.id = $1"
    values = [@film_id]
    result = SqlRunner.run(sql, values).first
    return result['price'].to_i
  end

  def get_customer_funds()
    sql = "SELECT customers.funds FROM customers WHERE customers.id = $1"
    values = [@customer_id]
    result = SqlRunner.run(sql, values)[0]['funds'].to_i
  end

  def charge_customer()
    new_customer_funds = (get_customer_funds() - get_film_price())
    sql2 = "UPDATE customers SET funds = $1 WHERE customers.id = $2"
    values2 = [new_customer_funds, @customer_id]
    SqlRunner.run(sql2, values2)
  end

  def update_tickets_sold()
    sql = "UPDATE screenings SET tickets_sold = (tickets_sold + 1) WHERE screenings.id = $1"
    values =[@screening_id]
    SqlRunner.run(sql, values)
  end


end

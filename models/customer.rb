require_relative('../db/sql_runner')

class Customer

  attr_reader :id
  attr_accessor :name, :funds

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @funds = options['funds']
  end


  def save()
    sql = "INSERT INTO customers (name, funds) VALUES ($1, $2) RETURNING id"
    values = [@name, @funds]
    customer = SqlRunner.run(sql, values)[0]
    @id = customer['id'].to_i
  end

  def update()
    sql = "UPDATE customers SET (name, funds) = ($1, $2) WHERE id = $3"
    values = [@name, @funds, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM customers where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end


  def self.find_by_id(id)
    sql = "SELECT * FROM customers WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values).first
    return Customer.new(pg_result)
  end

  def self.list_all()
    sql = "SELECT * FROM customers"
    pg_result = SqlRunner.run(sql)
    return pg_result.map {|customer| Customer.new(customer)}
  end

  def self.delete_all()
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end


  def films()
    sql = "SELECT films.* FROM films
            INNER JOIN tickets ON tickets.film_id = films.id
              WHERE customer_id = $1"

    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map {|film| Film.new(film)}
  end

  def total_tickets()
    sql = "SELECT * FROM tickets WHERE tickets.customer_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).count
    return result
  end



  # def buy_ticket(amount)
  #   @funds -= amount
  #   self.update()
  # end

end

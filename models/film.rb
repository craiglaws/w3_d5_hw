require_relative('../db/sql_runner')

class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @title = options['title']
    @price = options['price']
  end



  def save()
    sql = "INSERT INTO films (title, price) VALUES ($1, $2) RETURNING id"
    values = [@title, @price]
    film = SqlRunner.run(sql, values)[0]
    @id = film['id'].to_i
  end

  def update()
    sql = "UPDATE films SET (title, price) = ($1, $2) WHERE id = $3"
    values = [@title, @price, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM films where id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.find_by_id(id)
    sql = "SELECT * FROM films WHERE id = $1"
    values = [id]
    pg_result = SqlRunner.run(sql, values).first
    return Film.new(pg_result)
  end

  def self.list_all()
    sql = "SELECT * FROM films"
    pg_result = SqlRunner.run(sql)
    return pg_result.map {|film| Film.new(film)}
  end

  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def customers()
    sql = "SELECT customers.* FROM customers
            INNER JOIN tickets ON tickets.customer_id = customers.id
              WHERE customer_id = $1"
    values = [@id]
    pg_result = SqlRunner.run(sql, values)
    return pg_result.map {|customer| Customer.new(customer)}
  end


  def total_customers()
    sql = "SELECT * FROM tickets WHERE tickets.film_id = $1"
    values = [@id]
    result = SqlRunner.run(sql, values).count
    return result
  end



end

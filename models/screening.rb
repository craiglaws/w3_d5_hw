require_relative('../db/sql_runner')

class Screening

  attr_reader :id
  attr_accessor :showtime, :tickets_sold, :film_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @showtime = options['showtime']
    @tickets_sold = 0
    @film_id = options['film_id'].to_i
  end


  def save()
    sql = "INSERT INTO screenings (showtime, tickets_sold, film_id) VALUES ($1, $2, $3) RETURNING id"
    values = [@showtime, @tickets_sold, @film_id]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.list_all()
    sql = "SELECT * FROM screenings"
    pg_result = SqlRunner.run(sql)
    return pg_result.map {|screening| Screening.new(screening)}
  end

  def self.delete_all()
    sql = "DELETE FROM screenings"
    SqlRunner.run(sql)
  end


end

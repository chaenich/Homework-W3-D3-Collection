require_relative("../db/sql_runner")

class Artist

  attr_accessor :name
  attr_reader :id

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
  end

  def save()
    sql = "INSERT INTO artists
    (
      name
    ) VALUES
    (
      $1
    )
    RETURNING id"
    values = [@name]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update()
    sql = "
    UPDATE artists
      SET name = $1
      WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM artists WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def albums()
    sql = "SELECT * FROM albums
        WHERE artist_id = $1"
    values = [@id]
    album_hashes = SqlRunner.run(sql, values)
    albums = album_hashes.map { |album_hash| Album.new(album_hash)}
    return albums
  end


  def self.find(id)
      sql = "SELECT * FROM artists WHERE id = $1"
      values = [id]
      results = SqlRunner.run(sql, values)
      artist_hash = results.first
      artist = Artist.new(artist_hash)
      return artist
  end

  def self.delete_all()
      sql = "DELETE FROM artists;"
      SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM artists"
      artist_array = SqlRunner.run(sql)
      return artist_array.map{|artist|Artist.new(artist)}
    end

end

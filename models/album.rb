require_relative("../db/sql_runner")
require_relative("artist")

class Album

  attr_accessor :title, :genre
  attr_reader :id, :artist_id

  def initialize(options)
    @title = options["title"]
    @genre = options["genre"]
    @id = options['id'].to_i if options['id']
    @artist_id = options["artist_id"].to_i
  end

  def save()
    sql = "INSERT INTO albums
    (
      title,
      genre,
      artist_id
    ) VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@title, @genre, @artist_id]
    result = SqlRunner.run(sql, values)
    @id = result[0]["id"].to_i
  end

  def update()
      sql = "
      UPDATE albums SET (
        title,
        genre,
        artist_id
      ) =
      (
        $1,$2, $3
      )
      WHERE id = $4"
      values = [@title, @genre, @artist_id, @id]
      SqlRunner.run(sql, values)
    end

  def artist()
      sql = "SELECT * FROM artists
        WHERE id = $1"
      values = [@artist_id]
      results = SqlRunner.run(sql, values)
      artist_hash = results.first
      return Artist.new(artist_hash)
    end


  def self.delete_all()
      sql = "DELETE FROM albums"
      SqlRunner.run(sql)
    end

    def self.all()
      sql = "SELECT * FROM albums"
      album_array = SqlRunner.run(sql)
      return album_array.map { |album| Album.new(album) }
    end

end

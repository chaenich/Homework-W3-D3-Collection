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

end

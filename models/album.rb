require_relative("../db/sql_runner")

class Album

  attr_accessor :title, :genre
  attr_reader :id, :artist_id

  def initialize(options)
    @title = options["title"]
    @genre = options["genre"].to_i
    @id = options['id'].to_i if options['id']
    @customer_id = options["customer_id"].to_i
  end

end

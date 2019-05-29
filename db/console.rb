require("pry")
require_relative("../models/artist")
require_relative("../models/album")

artist1 = Artist.new({"name" => "Arty The Artist1"})
artist1.save()

album1 = Album.new({
  "title" => "Best Album ever 1",
  "genre" => "Thrash Punk",
  "artist_id" => artist1.id
  })
album1.save()

album2 = Album.new({
  "title" => "Second Best Album ever 2",
  "genre" => "Thoughtful",
  "artist_id" => artist1.id
  })
album2.save()

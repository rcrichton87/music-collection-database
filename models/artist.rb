require_relative ('../db/sql_runner.rb')

class Artist
  attr_reader :id
  attr_accessor :name
  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
  end

  def save
    sql = "INSERT INTO artists(name) VALUES ('#{@name}') RETURNING *"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM artists;"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM artists"
    artists = SqlRunner.run(sql)
    return artists.map{|artist| Artist.new(artist)}
  end

  def albums_by_artist
    sql = "SELECT * FROM albums WHERE artist_id = #{@id}"
    albums = SqlRunner.run(sql)
    return albums.map{|album| Album.new(album)}
  end
end
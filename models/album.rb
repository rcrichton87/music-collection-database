require_relative ('../db/sql_runner.rb')

class Album

  attr_reader :id, :artist_id
  attr_accessor :title, :genre

  def initialize(options)
    @id = options['id'].to_i
    @artist_id = options['artist_id'].to_i
    @title = options['title']
    @genre = options['genre']
  end

  def save
    sql = "INSERT INTO albums (artist_id, title, genre) VALUES (#{@artist_id}, '#{@title}', '#{@genre}') RETURNING *"
    @id = SqlRunner.run(sql)[0]['id'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM albums;"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM albums;"
    albums = SqlRunner.run(sql)
    return albums.map {|album| Album.new(album)}
  end

  def artist
    sql = "SELECT * FROM artists WHERE id = #{@artist_id}"
    artists = SqlRunner.run(sql)
    return Artist.new(artists[0])
  end

  def update
    sql = "UPDATE albums SET (title, genre) = ('#{@title}', '#{@genre}') WHERE id = #{@id}"
    SqlRunner.run(sql)
  end

  def delete
    sql = "DELETE FROM albums WHERE id = #{id};"
    SqlRunner.run(sql)
  end

end
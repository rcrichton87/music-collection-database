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

end
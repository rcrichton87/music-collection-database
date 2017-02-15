require('pry')
require_relative('models/artist.rb')
require_relative('models/album.rb')

Artist.delete_all

artist1 = Artist.new({'name' => 'Miles Davis'})
artist2 = Artist.new({'name' => 'Michael Jackson'})

artist1.save
artist2.save

binding.pry
nil
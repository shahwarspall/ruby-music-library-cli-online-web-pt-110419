require 'pry'

class Song
    extend Concerns::Findable
    attr_accessor :name , :genre
    attr_reader :artist
    @@all = []
    
    def initialize(name, artist = nil, genre = nil)
        self.artist = artist 
        self.genre = genre if genre 
        @name = name
     
    
    end 
    
    def self.destroy_all 
    @@all.clear
    end 
    
    def save    
    @@all << self 
    end

    def self.all 
        @@all
    end 

    def self.create(name)
        song = Song.new(name)
        song.save
        song

    end 

    def artist=(artist)
        @artist = artist
        artist.add_song(self) if artist
      end
      
      def genre=(genre)
        @genre = genre 
        genre.songs << self unless genre.songs.include?(self)
      end

      def self.new_from_filename(file)
        raw = file.gsub(".mp3", "")
        raw_two = raw.split(" - ")
        song_name = raw_two[1]
        Song.new(song_name)
        artist = Artist.find_or_create_by_name(raw_two[0])
        genre = Genre.find_or_create_by_name(raw_two[2])
        Song.new(song_name, artist, genre)
     end 

     def self.create_from_filename(file)
       song = new_from_filename(file)
       song.save
     end 
    
end 
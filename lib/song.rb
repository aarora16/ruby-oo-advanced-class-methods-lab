require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new
    song.save
    song
  end

  def self.new_by_name(name)
    song = self.new
    song.name = name
    song
  end

  def self.create_by_name(name)
    song = new_by_name(name)
    song.save
    song
  end

  def self.find_by_name(name)
    @@all.each do |song|
      if song.name == name
        return song
      end
    end
    return nil
  end

  def self.find_or_create_by_name(name)
    if find_by_name(name)
      find_by_name(name)
    else
      create_by_name(name)
    end
  end

  def self.alphabetical
    sorted_song_names = []
    sorted_songs = []

    all.each do |song|
      sorted_song_names << song.name
    end

    sorted_song_names.sort!

    sorted_song_names.each do |song|
      sorted_songs << find_by_name(song)
    end
    sorted_songs
  end

  def self.new_from_filename(filename)
    split_name = filename.split(" - ")
    song_name = split_name[1].split(".")

    song = new_by_name(song_name[0])
    song.artist_name = split_name[0]
    song
  end

  def self.create_from_filename(filename)
    song = new_from_filename(filename)
    song.save
    song
  end

  def self.destroy_all
    all.clear
  end

end

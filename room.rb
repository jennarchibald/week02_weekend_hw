class Room

  attr_reader :name, :guests, :song_library, :playlist

  def initialize(name, song_library)

    @name = name

    @guests = []

    @song_library = song_library

    @playlist = []

  end

  def add_song_to_library(song)

    @song_library.push(song)

  end

  def add_song_to_playlist(song)
    if @song_library.any? { |song_in_library| song_in_library == song }
      @playlist.push(song)
    end
  end

  def check_in_guest(guest)
    
  end

end

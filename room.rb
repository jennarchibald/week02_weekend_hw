class Room

  attr_reader :name, :guests, :capacity, :song_library, :playlist

  def initialize(name, song_library, capacity)

    @name = name

    @song_library = song_library

    @capacity = capacity

    @guests = []

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
    @guests.push(guest) if room_has_space?()
  end

  def check_out_guest(guest)
    @guests.delete(guest)
  end

  def room_has_space?()
    @guests.length < @capacity
  end

end

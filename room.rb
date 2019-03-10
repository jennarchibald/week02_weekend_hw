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

  def add_guest_to_room(guest)
    @guests.push(guest)
  end

  def remove_guest_from_room(guest)
    @guests.delete(guest)
  end

  def room_has_space?()
    occupants_in_room() < @capacity
  end

  def is_song_in_library?(song)
    @song_library.any? { |song_in_library| song_in_library == song }
  end

  def occupants_in_room()
    return @guests.length
  end

  def guest_in_room?(guest)
    @guests.any? { |occupant| occupant == guest}
  end
end

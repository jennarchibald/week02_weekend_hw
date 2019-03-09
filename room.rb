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

  def check_in_guest(guest)
     if room_has_space?() && guest.wristband == true
       add_guest_to_room(guest)
     elsif guest.wristband == false
       return "Guest needs a wristband"
     elsif room_has_space?() == false
       return "#{name} is full."
     end
  end

  def check_out_guest(guest)
    @guests.delete(guest)
  end

  def room_has_space?()
    @guests.length < @capacity
  end

  def is_song_in_library?(song)
    @song_library.any? { |song_in_library| song_in_library == song }
  end

end

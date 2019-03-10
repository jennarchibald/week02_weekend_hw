require("Minitest/autorun")
require("Minitest/rg")
require_relative("../room")
require_relative("../song")
require_relative("../guest")
require_relative("../venue")
require_relative("../bar")
require_relative("../drink")


class TestRoom < Minitest::Test

  def setup

    @guest1 = Guest.new("Jenn", 100, @song1)
    @guest2 = Guest.new("Becky", 90, @song2)
    @guest3 = Guest.new("Pim", 90, @song3)



    @song1 = Song.new("Mr Brightside", "The Killers")
    @song2 = Song.new("Hard Times", "Paramore")
    @song3 = Song.new("Toxic", "Britney Spears")
    @song4 = Song.new("Fire Drills", "Dessa")

    @songs = [@song1, @song2, @song3]

    @room1 = Room.new("Room 1", @songs, 6)
    @room2 = Room.new("Room 2", @songs, 4)

    # @rooms = [@room1, @room2]

    # @drinks = [@drink1, @drink2, @drink3]

    # @bar1 = Bar.new(@drinks)

    # @venue1 = Venue.new(5, @rooms, @bar1)



  end

  def test_room_has_name
    assert_equal("Room 1", @room1.name)
  end

  def test_room_is_empty
    assert_equal([], @room1.guests)
  end

  def test_room_has_song_library
    assert_equal(@songs, @room1.song_library)
  end

  def test_playlist_is_empty
    assert_equal([], @room1.playlist)
  end

  def test_add_song_to_library
    @room1.add_song_to_library(@song4)
    assert_equal([@song1, @song2, @song3, @song4], @room1.song_library)
  end

  def test_add_song_to_playlist__song_in_library
    @room1.add_song_to_playlist(@song1)
    assert_equal([@song1], @room1.playlist)
  end

  def test_add_song_to_playlist__song_not_in_library
    @room1.add_song_to_playlist(@song4)
    assert_equal([], @room1.playlist)
  end


  def test_remove_guest_from_room
    @room1.add_guest_to_room(@guest1)
    @room1.add_guest_to_room(@guest2)
    assert_equal([@guest1, @guest2], @room1.guests)
    @room1.remove_guest_from_room(@guest1)
    assert_equal([@guest2], @room1.guests)
  end

  def test_room_has_capacity
    assert_equal(6, @room1.capacity)
  end

  def test_room_is_full
    assert_equal(true, @room1.room_has_space?)
    @room1.add_guest_to_room(@guest1)
    @room1.add_guest_to_room(@guest2)
    @room1.add_guest_to_room(@guest3)
    @room1.add_guest_to_room(@guest4)
    @room1.add_guest_to_room(@guest5)
    @room1.add_guest_to_room(@guest6)
    assert_equal(false, @room1.room_has_space?)
  end


  def test_is_song_in_library__song_is_there()
    result = @room1.is_song_in_library?(@song1)
    assert_equal(true, result)
  end

  def test_is_song_in_library__song_not_there()
    result = @room1.is_song_in_library?(@song4)
    assert_equal(false, result)
  end

  def test_occupants_in_room
    result = @room1.occupants_in_room()
    assert_equal(0, result)
    @room1.add_guest_to_room(@guest1)
    @room1.add_guest_to_room(@guest2)
    @room1.add_guest_to_room(@guest3)
    result = @room1.occupants_in_room()
    assert_equal(3, result)
  end

  def test_guest_in_room
    result = @room1.guest_in_room?(@guest1)
    assert_equal(false, result)
    @room1.add_guest_to_room(@guest1)
    result = @room1.guest_in_room?(@guest1)
    assert_equal(true, result)
  end


end

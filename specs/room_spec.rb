require("Minitest/autorun")
require("Minitest/rg")
require_relative("../room")
require_relative("../song")
require_relative("../guest")


class TestRoom < Minitest::Test

  def setup

    @guest1 = Guest.new("Jenn", 100)
    @guest2 = Guest.new("Becky", 90)
    @guest3 = Guest.new("Pim", 90)
    @guest4 = Guest.new("Alisdair", 90)
    @guest5 = Guest.new("Mark", 90)
    @guest6 = Guest.new("Charlie", 90)
    @guest7 = Guest.new("Grant", 90)

    @song1 = Song.new("Mr Brightside", "The Killers")
    @song2 = Song.new("Hard Times", "Paramore")
    @song3 = Song.new("Toxic", "Britney Spears")
    @song4 = Song.new("Fire Drills", "Dessa")

    @songs = [@song1, @song2, @song3]

    @room1 = Room.new("Room 1", @songs, 6)

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

  def test_check_in_guest
    @room1.check_in_guest(@guest1)
    assert_equal([@guest1], @room1.guests)
  end

  def test_check_out_guest
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest2)
    @room1.check_out_guest(@guest1)
    assert_equal([@guest2], @room1.guests)
  end

  def test_room_has_capacity
    assert_equal(6, @room1.capacity)
  end

  def test_room_is_full
    assert_equal(true, @room1.room_has_space?)
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest2)
    @room1.check_in_guest(@guest3)
    @room1.check_in_guest(@guest4)
    @room1.check_in_guest(@guest5)
    @room1.check_in_guest(@guest6)
    assert_equal(false, @room1.room_has_space?)
  end

  def test_check_in_guest__room_full
    @room1.check_in_guest(@guest1)
    @room1.check_in_guest(@guest2)
    @room1.check_in_guest(@guest3)
    @room1.check_in_guest(@guest4)
    @room1.check_in_guest(@guest5)
    @room1.check_in_guest(@guest6)
    @room1.check_in_guest(@guest7)
    assert_equal([@guest1, @guest2, @guest3, @guest4, @guest5, @guest6], @room1.guests)
  end

end

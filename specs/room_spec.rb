require("Minitest/autorun")
require("Minitest/rg")
require_relative("../room")
require_relative("../song")
require_relative("../guest")


class TestRoom < Minitest::Test

  def setup

    @guest1 = Guest.new("Jenn")

    @song1 = Song.new("Mr Brightside", "The Killers")
    @song2 = Song.new("Hard Times", "Paramore")
    @song3 = Song.new("Toxic", "Britney Spears")
    @song4 = Song.new("Fire Drills", "Dessa")

    @songs = [@song1, @song2, @song3]

    @room1 = Room.new("Room 1", @songs)

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

end

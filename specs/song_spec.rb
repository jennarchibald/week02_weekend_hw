require("Minitest/autorun")
require("Minitest/rg")
require_relative("../song")


class TestSong < Minitest::Test

  def setup

    @song1 = Song.new("Mr Brightside", "The Killers")


  end

  def test_song_has_title

    assert_equal("Mr Brightside", @song1.title)

  end

  def test_song_has_artist

    assert_equal("The Killers", @song1.artist)

  end

end

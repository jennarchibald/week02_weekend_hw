require("Minitest/autorun")
require("Minitest/rg")
require_relative("../guest")
require_relative("../song")
require_relative("../room")

class TestGuest < Minitest::Test

  def setup


    @song1 = Song.new("Mr Brightside", "The Killers")
    @song2 = Song.new("Hard Times", "Paramore")
    @song3 = Song.new("Toxic", "Britney Spears")
    @song4 = Song.new("Fire Drills", "Dessa")

    @guest1 = Guest.new("Jenn", 100, @song1)
    @guest2 = Guest.new("Bob", 100, @song4)

    @songs = [@song1, @song2, @song3]

    @room1 = Room.new("Room 1", @songs, 6)


  end

 def test_guest_has_name

   assert_equal("Jenn", @guest1.name)

 end

 def test_guest_has_money
   assert_equal(100, @guest1.how_much_money)
 end

 def test_spend_money__guest_has_money
   result = @guest1.spend_money(10)
   assert_equal(10, result)
   assert_equal(90, @guest1.how_much_money)
 end

 def test_spend_money__guest_doesnt_have_money
   result = @guest1.spend_money(110)
   assert_equal(0, result)
   assert_equal(100, @guest1.how_much_money)
 end

 def test_guest_has_wristband
   assert_equal(false, @guest1.wristband)
   @guest1.wristband = true
   assert_equal(true, @guest1.wristband)
 end

 def test_guest_has_fav_song
   result = @guest1.what_is_fav_song()
   assert_equal(@song1, result)
 end

 def test_guest_can_cheer_for_song
   result = @guest1.cheer_for_song(@song1)
   assert_equal("Woooo! Mr Brightside", result)
 end

 def test_guest_can_boo
   result = @guest1.boo()
   assert_equal("BOOOOO!", result)
 end

 def test_look_for_favourite_song__song_is_there
   result = @guest1.look_for_favourite_song(@room1)
   assert_equal("Woooo! Mr Brightside", result)
 end

 def test_look_for_favourite_song__song_not_there
   result = @guest2.look_for_favourite_song(@room1)
   assert_equal("BOOOOO!", result)
 end

end

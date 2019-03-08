require("Minitest/autorun")
require("Minitest/rg")
require_relative("../guest")

class TestGuest < Minitest::Test

  def setup

    @guest1 = Guest.new("Jenn", 100)

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




end

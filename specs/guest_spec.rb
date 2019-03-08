require("Minitest/autorun")
require("Minitest/rg")
require_relative("../guest")

class TestGuest < Minitest::Test

  def setup

    @guest1 = Guest.new("Jenn")

  end

 def test_guest_has_name

   assert_equal("Jenn", @guest1.name)

 end


end

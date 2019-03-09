require("Minitest/autorun")
require("Minitest/rg")
require_relative("../drink")

class TestDrink < MiniTest::Test

  def setup

    @drink1 = Drink.new("Beer", 3)

  end

  def test_drink_has_type
    assert_equal("Beer", @drink1.type)
  end

  def test_drink_has_price
    assert_equal(3, @drink1.price)
  end

end

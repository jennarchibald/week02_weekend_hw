require("Minitest/autorun")
require("Minitest/rg")
require_relative("../bar_tab")
require_relative("../guest")
require_relative("../song")


class TestBarTab < MiniTest::Test

  def setup

    @song1 = Song.new("Mr Brightside", "The Killers")

    @guest1 = Guest.new("Jenn", 100, @song1)
    @guest2 = Guest.new("Bob", 100, @song1)

    @bartab1 = BarTab.new(@guest1)
    @bartab2 = BarTab.new(@guest2, 50)

  end

  def test_bartab_has_guest
    assert_equal(@guest1, @bartab1.guest)
  end

  def test_bartab_has_limit
    assert_equal(100, @bartab1.what_is_limit)
  end

  def test_guest_can_set_limit
    assert_equal(50, @bartab2.what_is_limit)
  end

  def test_bartab_how_much_spent
    assert_equal(0, @bartab1.how_much_spent)
  end

  def test_bartab_can_increase_spent()
    @bartab1.increase_spent(10)
    assert_equal(10, @bartab1.how_much_spent)
  end

  def test_how_much_left()
    assert_equal(100, @bartab1.how_much_left)
    @bartab1.increase_spent(10)
    assert_equal(90, @bartab1.how_much_left)
  end

  def test_bartab_can_be_spent__enough_left()
    @bartab1.spend_bartab(10)
    assert_equal(10, @bartab1.how_much_spent)
  end

  def test_bartab_can_be_spent__not_enough()
    result = @bartab1.spend_bartab(101)
    assert_equal(0, @bartab1.how_much_spent)
    assert_equal("Not enough left", result)
  end






end

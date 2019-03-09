require("Minitest/autorun")
require("Minitest/rg")
require_relative("../drink")
require_relative("../bar")
require_relative("../guest")
require_relative("../song")
require_relative("../bar_tab")

class TestBar < MiniTest::Test

  def setup

    @song1 = Song.new("Mr Brightside", "The Killers")

    @guest1 = Guest.new("Jenn", 100, @song1)
    @guest2 = Guest.new("Bob", 1, @song1)
    @guest3 = Guest.new("Adam", 50, @song1)

    @drink1 = Drink.new("Beer", 3)
    @drink2 = Drink.new("Whiskey", 5)
    @drink3 = Drink.new("Cider", 2)
    @drink4 = Drink.new("Absinthe", 2)

    @drinks = [@drink1, @drink2, @drink3]

    @bar1 = Bar.new(@drinks)

    @bartab1 = BarTab.new(@guest1)
    @bartab2 = BarTab.new(@guest2)

  end

  def test_bar_has_drinks_menu
    assert_equal(@drinks, @bar1.drinks_menu)
  end

  def test_bar_has_bartabs
    assert_equal({}, @bar1.bartabs)
  end

  def test_add_tab__correct_guest()
    result = @bar1.add_tab(@guest1, @bartab1)
    assert_equal({@guest1 => @bartab1}, @bar1.bartabs)
    assert_equal("Tab added.", result)
  end

  def test_add_tab__wrong_guest()
    result = @bar1.add_tab(@guest2, @bartab1)
    assert_equal({}, @bar1.bartabs)
    assert_equal("Bob does not own this bartab", result)
  end

  def test_drink_on_menu__true()
    result = @bar1.drink_on_menu?(@drink1)
    assert_equal(true, result)
  end

  def test_drink_on_menu__false()
    result = @bar1.drink_on_menu?(@drink4)
    assert_equal(false, result)
  end

  def test_guest_has_tab
    @bar1.add_tab(@guest1, @bartab1)
    assert_equal(true, @bar1.guest_has_tab?(@guest1))
    assert_equal(false, @bar1.guest_has_tab?(@guest2))
  end

  def test_find_bartab__guest_has_bartab()
    @bar1.add_tab(@guest1, @bartab1)
    result = @bar1.find_bartab(@guest1)
    assert_equal(@bartab1, result)
  end

  def test_find_bartab__guest_doesnt_have_bartab()
    @bar1.add_tab(@guest1, @bartab1)
    result = @bar1.find_bartab(@guest2)
    assert_nil(result)
  end

  def test_buy_drink_on_tab()
    @bar1.add_tab(@guest1, @bartab1)
    result = @bar1.buy_drink_on_tab(@guest1, @drink1)
    assert_equal(97, @bartab1.how_much_left)
    assert_equal("Here's your Beer. You have 97 left on your tab.", result)
  end

  def test_buy_drink_on_tab__drink_not_served()
    @bar1.add_tab(@guest1, @bartab1)
    result = @bar1.buy_drink_on_tab(@guest1, @drink4)
    assert_equal(100, @bartab1.how_much_left)
    assert_equal("We don't serve Absinthe", result)
  end

  def test_buy_drink_on_tab__not_enough_left()
    @bar1.add_tab(@guest2, @bartab2)
    result = @bar1.buy_drink_on_tab(@guest2, @drink1)
    assert_equal(1, @bartab2.how_much_left)
    assert_equal("Not enough left on your tab.", result)
  end

  def test_buy_drink_on_tab__guest_has_no_tab()
    @bar1.add_tab(@guest2, @bartab2)
    result = @bar1.buy_drink_on_tab(@guest1, @drink1)
    assert_equal(1, @bartab2.how_much_left)
    assert_equal("You don't have a bartab.", result)
  end

  def test_pay_off_tab__tab_exists()
    @bar1.add_tab(@guest1, @bartab1)
    @bar1.buy_drink_on_tab(@guest1, @drink1)
    result = @bar1.pay_off_tab(@guest1, @guest1)
    assert_equal(true, @bartab1.tab_is_settled?)
    assert_equal(97, @guest1.how_much_money)
    assert_equal("Jenn's tab is paid.", result)
  end

  def test_pay_off_tab__tab_doesnt_exist()
    result = @bar1.pay_off_tab(@guest1, @guest1)
    assert_equal("There's no tab for that person", result)
    assert_equal(100, @guest1.how_much_money)
  end

  def test_pay_off_tab__other_persons_tab()
    @bar1.add_tab(@guest1, @bartab1)
    @bar1.buy_drink_on_tab(@guest1, @drink1)
    result = @bar1.pay_off_tab(@guest1, @guest3)
    assert_equal(100, @guest1.how_much_money)
    assert_equal(47, @guest3.how_much_money)
    assert_equal(true, @bartab1.tab_is_settled?)
    assert_equal("Jenn's tab is paid.", result)

  end

end

require("Minitest/autorun")
require("Minitest/rg")
require_relative("../venue")
require_relative("../guest")
require_relative("../room")
require_relative("../song")
require_relative("../bar_tab")
require_relative("../bar")
require_relative("../drink")


class TestVenue < Minitest::Test

  def setup

    @song1 = Song.new("Mr Brightside", "The Killers")
    @song2 = Song.new("Hard Times", "Paramore")
    @song3 = Song.new("Toxic", "Britney Spears")
    @song4 = Song.new("Fire Drills", "Dessa")

    @guest1 = Guest.new("Jenn", 100, @song1)
    @guest2 = Guest.new("Bob", 1, @song2)

    @songs = [@song1, @song2, @song3]

    @room1 = Room.new("Room 1", @songs, 6)
    @room2 = Room.new("Room 2", @songs, 8)
    @room3 = Room.new("Room 3", @songs, 8)

    @rooms = [@room1, @room2, @room3]

    @drink1 = Drink.new("Beer", 3)
    @drink2 = Drink.new("Whiskey", 5)
    @drink3 = Drink.new("Cider", 2)

    @drinks = [@drink1, @drink2, @drink3]

    @bar1 = Bar.new(@drinks)

    @bartab1 = BarTab.new(@guest1)

    @venue1 = Venue.new(5, @rooms, @bar1)


  end

  def test_venue_has_till
    assert_equal(0, @venue1.how_much_in_till)
  end

  def test_venue_has_entry_fee
    assert_equal(5, @venue1.entry_fee)
  end

  def test_add_to_till
    @venue1.add_to_till(10)
    assert_equal(10, @venue1.how_much_in_till)
  end

  def test_charge_entry_fee__guest_can_pay
    result = @venue1.charge_entry_fee(@guest1)
    assert_equal(true, @guest1.wristband)
    assert_equal(5, @venue1.how_much_in_till)
  end

  def test_charge_entry_fee__guest_cant_pay
    result = @venue1.charge_entry_fee(@guest2)
    assert_equal(false, @guest2.wristband)
    assert_equal(0, @venue1.how_much_in_till)
    assert_equal("Entry costs 5", result)
  end

  def test_venue_has_rooms
    assert_equal([@room1, @room2, @room3], @venue1.rooms)
  end

  def test_give_guest_wristband
    @venue1.give_guest_wristband(@guest1)
    assert_equal(true, @guest1.wristband)
  end

  def test_venue_has_bar
    assert_equal(@bar1, @venue1.bar)
  end

  def test_guest_can_leave()
    assert_equal(true, @venue1.guest_can_leave?(@guest1))
    @bar1.add_tab(@guest1, @bartab1)
    @bar1.buy_drink_on_tab(@guest1, @drink1)
    assert_equal(false, @venue1.guest_can_leave?(@guest1))
    @bar1.pay_off_tab(@guest1, @guest1)
    assert_equal(true, @venue1.guest_can_leave?(@guest1))
  end






end

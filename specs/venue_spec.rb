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
    @guest3 = Guest.new("Adam", 50, @song1)
    @guest4 = Guest.new("Alisdair", 90, @song4)
    @guest5 = Guest.new("Mark", 90, @song3)
    @guest6 = Guest.new("Charlie", 90, @song2)
    @guest7 = Guest.new("Grant", 90, @song1)
    @guest8 = Guest.new("Bob.2", 100, @song2)

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

  def test_charge_entry_fee__guest_already_paid
    @venue1.charge_entry_fee(@guest1)
    result = @venue1.charge_entry_fee(@guest1)
    assert_equal(true, @guest1.wristband)
    assert_equal(5, @venue1.how_much_in_till)
    assert_equal("Guest already paid", result)
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
    @venue1.charge_entry_fee(@guest1)
    @bar1.start_new_tab(@guest1, 100)
    @bar1.buy_drink_on_tab(@guest1, @drink1)
    assert_equal(false, @venue1.guest_can_leave?(@guest1))
    @venue1.pay_off_bar_tab(@bar1, @guest1, @guest1)
    assert_equal(true, @venue1.guest_can_leave?(@guest1))
  end

  def test_pay_off__bar_tab__tab_exists()
    @venue1.charge_entry_fee(@guest1)
    @bar1.start_new_tab(@guest1)
    @bar1.buy_drink_on_tab(@guest1, @drink1)
    result = @venue1.pay_off_bar_tab(@bar1, @guest1, @guest1)
    assert_equal(true, @bartab1.tab_is_settled?)
    assert_equal(92, @guest1.how_much_money)
    assert_equal("Jenn's tab is paid.", result)
    assert_equal(8, @venue1.how_much_in_till)
  end

  def test_pay_off_bar_tab__tab_doesnt_exist()
    result = @venue1.pay_off_bar_tab(@bar1, @guest1, @guest1)
    assert_equal("There's no tab for that person", result)
    assert_equal(100, @guest1.how_much_money)
    assert_equal(0, @venue1.how_much_in_till)
  end

  def test_pay_off_bar_tab__other_persons_tab()
    @venue1.charge_entry_fee(@guest1)
    @bar1.start_new_tab(@guest1)
    @bar1.buy_drink_on_tab(@guest1, @drink1)
    result = @venue1.pay_off_bar_tab(@bar1, @guest1, @guest3)
    assert_equal(95, @guest1.how_much_money)
    assert_equal(47, @guest3.how_much_money)
    assert_equal(true, @bartab1.tab_is_settled?)
    assert_equal("Jenn's tab is paid.", result)
    assert_equal(8, @venue1.how_much_in_till)
  end

  def test_pay_off_bar_tab__not_enough_money()
    @venue1.charge_entry_fee(@guest1)
    @bar1.start_new_tab(@guest1)
    @bar1.buy_drink_on_tab(@guest1, @drink1)
    result = @venue1.pay_off_bar_tab(@bar1, @guest1, @guest2)
    assert_equal(95, @guest1.how_much_money)
    assert_equal(1, @guest2.how_much_money)
    assert_equal(false, @bar1.bartabs[@guest1].tab_is_settled?)
    assert_equal("Not enough money", result)
    assert_equal(5, @venue1.how_much_in_till)
  end

  def test_guest_checked_in
    result = @venue1.guest_checked_in?(@guest1)
    assert_equal(false, result)
    @venue1.charge_entry_fee(@guest1)
    result = @venue1.guest_checked_in?(@guest1)
    assert_equal(false, result)
    @room1.add_guest_to_room(@guest1)
    result = @venue1.guest_checked_in?(@guest1)
    assert_equal(true, result)
  end

  def test_check_in_guest_to_room__guest_has_wristband
    @venue1.charge_entry_fee(@guest1)
    result = @venue1.check_in_guest_to_room(@guest1, @room1)
    assert_equal([@guest1], @room1.guests)
    assert_equal(true, @venue1.guest_checked_in?(@guest1))
    assert_equal("Guest checked in", result)
  end


  def test_check_in_guest_to_room__guest_doesnt_have_wristband
    result = @venue1.check_in_guest_to_room(@guest1, @room1)
    assert_equal([], @room1.guests)
    assert_equal("Guest needs a wristband", result)
    assert_equal(false, @venue1.guest_checked_in?(@guest1))
  end

  def test_check_in_guest_to_room__guest_in_another_room
    @venue1.charge_entry_fee(@guest1)
    @venue1.check_in_guest_to_room(@guest1, @room1)
    result = @venue1.check_in_guest_to_room(@guest1, @room2)
    assert_equal([], @room2.guests)
    assert_equal("Guest already checked in", result)
  end


  def test_check_in_guest__room_full
  @venue1.charge_entry_fee(@guest1)
  @venue1.charge_entry_fee(@guest8)
  @venue1.charge_entry_fee(@guest3)
  @venue1.charge_entry_fee(@guest4)
  @venue1.charge_entry_fee(@guest5)
  @venue1.charge_entry_fee(@guest6)
  @venue1.charge_entry_fee(@guest7)
  @venue1.check_in_guest_to_room(@guest1, @room1)
  @venue1.check_in_guest_to_room(@guest8, @room1)
  @venue1.check_in_guest_to_room(@guest3, @room1)
  @venue1.check_in_guest_to_room(@guest4, @room1)
  @venue1.check_in_guest_to_room(@guest5, @room1)
  @venue1.check_in_guest_to_room(@guest6, @room1)
  result = @venue1.check_in_guest_to_room(@guest7, @room1)
    assert_equal([@guest1, @guest8, @guest3, @guest4, @guest5, @guest6], @room1.guests)
    assert_equal("Room 1 is full.", result)
    assert_equal(false, @venue1.guest_checked_in?(@guest7))
  end

  def test_check_out_guest_from_room
    @venue1.charge_entry_fee(@guest1)
    @venue1.charge_entry_fee(@guest3)
    @venue1.check_in_guest_to_room(@guest1, @room1)
    @venue1.check_in_guest_to_room(@guest3, @room1)

    result = @venue1.check_out_guest__from_room(@guest1, @room1)
    assert_equal([@guest3], @room1.guests)
    assert_equal(false, @venue1.guest_checked_in?(@guest1))
    assert_equal("Guest checked out", result)
  end

  def test_check_out_guest__from_room__guest_not_checked_in
    @venue1.charge_entry_fee(@guest1)
    @venue1.charge_entry_fee(@guest3)
    @venue1.check_in_guest_to_room(@guest3, @room1)

    result = @venue1.check_out_guest__from_room(@guest1, @room1)
    assert_equal([@guest3], @room1.guests)
    assert_equal(false, @venue1.guest_checked_in?(@guest1))
    assert_equal("Guest was not checked into this room", result)
  end

end

class Venue

  attr_reader :entry_fee, :rooms
  def initialize(entry_fee, rooms)
    @rooms = rooms
    @entry_fee = entry_fee
    @till = 0
  end

  def how_much_in_till
    return @till
  end

  def add_to_till(money)
    @till += money
  end

  def charge_entry_fee(guest)
    income = guest.spend_money(@entry_fee)
     give_guest_wristband(guest) if income != 0
     @till += income
  end

  def give_guest_wristband(guest)
    guest.wristband = true
  end


end

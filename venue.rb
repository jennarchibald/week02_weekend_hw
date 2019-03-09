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
      if income == @entry_fee
        give_guest_wristband(guest)
        add_to_till(income)
      else
        return "Entry costs #{@entry_fee}"
      end

  end

  def give_guest_wristband(guest)
    guest.wristband = true
  end


end

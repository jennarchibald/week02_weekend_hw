class Venue

  attr_reader :entry_fee
  def initialize(entry_fee)
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
    guest.spend_money(@entry_fee)
  end
end

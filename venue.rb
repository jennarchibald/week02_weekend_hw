class Venue

  attr_reader :entry_fee, :rooms, :bar
  def initialize(entry_fee, rooms, bar)
    @rooms = rooms
    @entry_fee = entry_fee
    @bar = bar
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

  def guest_can_leave?(guest)
    guest_bartab = @bar.find_bartab(guest)
    return true if guest_bartab == nil
    return guest_bartab.tab_is_settled?
  end

  def pay_off_bar_tab(bar, guest, payer)
    bartab = bar.find_bartab(guest)
    if bartab == nil
      return "There's no tab for that person"
    else
      amount_to_pay = bartab.how_much_spent
      paid = payer.spend_money(amount_to_pay)
      return "Not enough money" if paid == 0
      bartab.reduce_debt(paid)
      add_to_till(paid)
    end
  return "#{guest.name}'s tab is paid."
  end
end

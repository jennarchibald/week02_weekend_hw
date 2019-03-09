require_relative("./bar")

class Bar

  attr_reader :drinks_menu, :bartabs

  def initialize(drinks_menu)

    @drinks_menu = drinks_menu

    @bartabs = Hash.new()

  end

  def add_tab(guest, bartab)
    if guest == bartab.guest
      @bartabs[guest] = bartab
      return "Tab added."
    else
      return "#{guest.name} does not own this bartab"
    end
  end

  def drink_on_menu?(drink)
    return @drinks_menu.any? { |option| option == drink}
  end

  def guest_has_tab?(guest)
    @bartabs.keys.any? {|owner| owner == guest}
  end

  def find_bartab(guest)
    if guest_has_tab?(guest)
      return @bartabs[guest]
    end
  end

  def buy_drink_on_tab(guest, drink)

    if drink_on_menu?(drink) == false
      return "We don't serve #{drink.type}"
    elsif guest_has_tab?(guest) == false
      return "You don't have a bartab."
    else
      bartab = find_bartab(guest)
      price = drink.price
    end

    result = bartab.spend_bartab(price)

    if result == "Not enough left"
      return "#{result} on your tab."
    else
      return "Here's your #{drink.type}. You have #{result} on your tab."
    end
  end



end

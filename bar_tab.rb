class BarTab
  attr_reader :guest
  def initialize(guest, limit = guest.how_much_money)
    @guest = guest
    @limit = limit
    @spent = 0
  end

  def what_is_limit()
    return @limit
  end

  def how_much_spent()
    return @spent
  end

  def increase_spent(amount)
    @spent += amount
  end

  def how_much_left()
    @limit - @spent
  end

  def spend_bartab(amount)
    if how_much_left() >= amount
      increase_spent(amount)
    else
      return "Not enough left"
    end
  end



end

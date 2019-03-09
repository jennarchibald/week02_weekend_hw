require("pry")

class BarTab
  attr_reader :guest
  def initialize(guest, limit = guest.how_much_money)
    @guest = guest
    @limit = limit
    @debt = 0
  end

  def what_is_limit()
    return @limit
  end

  def how_much_spent()
    return @debt
  end

  def increase_spent(amount)
    @debt += amount
  end

  def how_much_left()
    return @limit - @debt
  end

  def spend_bartab(amount)
    # binding.pry()
    if how_much_left() >= amount
      increase_spent(amount)
      return "#{how_much_left()} left"
    else
      return "Not enough left"
    end
  end

  def reduce_debt(amount)
    @debt -= amount
  end

  def tab_is_settled?
    if @debt == 0
      return true
    else
      return false
    end
  end

end

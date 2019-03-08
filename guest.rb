class Guest

  attr_reader :name

  def initialize(name, money)

    @name = name

    @money = money

  end

  def how_much_money()
    return @money
  end

  def spend_money(money)
    if @money >= money
      @money -= money
      return money
    else
      return 0
    end
  end

end

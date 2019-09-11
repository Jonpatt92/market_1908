class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def stock(item, quantity)
    if @inventory.has_key?(item)
      @inventory[item] += quantity
    elsif @inventory.has_key?(item) == false
      @inventory[item] = quantity
    end
  end

  def sell_helper(item, quantity)
    sold = 0
    if @inventory.has_key?(item)
      if @inventory[item] == quantity
        @inventory[item] -= quantity
        return true
      elsif @inventory[item] <= quantity
        sold = @inventory[item].upto(0)
        @inventory[item] -= sold
        return sold
      end
    else
      false
    end
  end

  def check_stock(item)
    @inventory[item]
  end
end

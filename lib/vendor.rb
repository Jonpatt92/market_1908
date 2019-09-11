class Vendor
  attr_reader :name, :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new(0)
  end

  def stock(item, quantity)
    #if item doesn't already exist
    if @inventory.has_key?(item)
      @inventory[item] += quantity
    elsif @inventory.has_key?(item) == false
      @inventory[item] = quantity
    end
  end

  def check_stock(item)
    @inventory[item]
  end
end

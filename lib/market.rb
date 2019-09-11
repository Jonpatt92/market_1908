require './lib/vendor'

class Market
attr_reader :name, :vendors, :vendor_names #:total_inventory

  def initialize(name)
    @name = name
    @vendors = []
    @vendor_names = []
    #@total_inventory = Hash.new(0)
  end

  def add_vendor(vendor)
    if @vendors.any?(vendor) == false
      @vendors << vendor
      @vendor_names << vendor.name
      # vendor.inventory.each do |item, quantity|
      #   if @total_inventory.has_key?(item)
      #     @total_inventory[item] += quantity
      #   else
      #     @total_inventory[item] = quantity
      #   end
      # end
    end
  end

  def vendors_that_sell(item)
    selling_vendors = []
    @vendors.each do |vendor|
      if vendor.inventory[item] > 0
        selling_vendors << vendor
      end
    end
    selling_vendors
  end

  def sorted_item_list
    sorted_list = []
    @vendors.each do |vendor|
      vendor.inventory.each_key do |item|
        sorted_list << item
      end
    end
    sorted_list.uniq!.sort!
  end

  def total_inventory
    total_inventory = Hash.new(0)
    @vendors.each do |vendor|
      vendor.inventory.each do |item, quantity|
        if total_inventory.has_key?(item)
          total_inventory[item] += quantity
        else
          total_inventory[item] = quantity
        end
      end
    end
    total_inventory
  end

  def sell(item, quantity)
    market_inventory = self.total_inventory
    want_to_sell = quantity
    already_sold = 0
    if market_inventory.each |thing, amount|
      if thing 
    until already_sold == quantity
      @vendors.each do |vendor|
        if vendor.sell_helper(item, quantity) == true
          already_sold = quantity
        elsif vendor.sell_helper(item, quantity) == Integer
          already_sold += vendor.sell_helper(item, quantity)
        end

  end


end

# def vendor_names
#   vendors_names = []
#   @vendors.each do |vendor|
#     vendors_names << vendor.name
#   end
# vendors_names.uniq!
# end

# def sell(item, quantity)
#   market_inventory = self.total_inventory
#   want_to_sell = quantity
#   already_sold = 0
#   if market_inventory[item] < quantity
#     false
#   elsif market_inventory[item] > quantity
#     until already_sold == want_to_sell
#       if @vendors.first.inventory[item] != 0
#         until @vendors.first.inventory[item] == 0
#           already_sold += @vendors.first.inventory[item].truncate(quantity)
#           @vendors.first.inventory[item] -= @vendors.first.inventory[item].truncate(quantity)
#         end
#       elsif @vendors[1].inventory[item] != 0
#         until @vendors[1].inventory[item] == 0
#           already_sold += @vendors[1].inventory[item].truncate(quantity)
#           @vendors[1].inventory[item] -= @vendors[1].inventory[item].truncate(quantity)
#         end
#       elsif @vendors[2].inventory[item] != 0
#         until @vendors[2].inventory[item] == 0
#           already_sold += @vendors[2].inventory[item].truncate(quantity)
#           @vendors[2].inventory[item] -= @vendors[2].inventory[item].truncate(quantity)
#         end
#       end
#     end
#   end
# end

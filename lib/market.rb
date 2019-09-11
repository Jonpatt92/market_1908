require './lib/vendor'

class Market
attr_reader :name, :vendors, :vendor_names, :total_inventory

  def initialize(name)
    @name = name
    @vendors = []
    @vendor_names = []
    @total_inventory = Hash.new(0)
  end

  def add_vendor(vendor)
    if @vendors.any?(vendor) == false
      @vendors << vendor
      @vendor_names << vendor.name
      vendor.inventory.each do |item, quantity|
        if @total_inventory.has_key?(item)
          @total_inventory[item] += quantity
        else
          @total_inventory[item] = quantity
        end
      end
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
end

# def vendor_names
#   vendors_names = []
#   @vendors.each do |vendor|
#     vendors_names << vendor.name
#   end
# vendors_names.uniq!
# end

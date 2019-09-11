require './lib/vendor'

class Market
attr_reader :name, :vendors, :vendor_names

  def initialize(name)
    @name = name
    @vendors = []
    @vendor_names = []
  end

  def add_vendor(vendor)
    if @vendors.any?(vendor) == false
      @vendors << vendor
      @vendor_names << vendor.name
    end
  end

  # def vendor_names
  #   vendors_names = []
  #   @vendors.each do |vendor|
  #     vendors_names << vendor.name
  #   end
  # vendors_names.uniq!
  # end

  def vendors_that_sell(item)
    selling_vendors = []
    @vendors.each do |vendor|
      if vendor.inventory[item] > 0
        selling_vendors << vendor
      end
    end
    selling_vendors
  end
end

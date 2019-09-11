require 'minitest/autorun'
require 'minitest/pride'
require './lib/market'
require 'pry'


class VendorTest < Minitest::Test

  def setup
    @market = Market.new("South Pearl Street Farmers Market")
  end

  def test_it_exists
    assert_instance_of Market, @market
  end

  def test_it_has_attributes
    expect_empty_array = []

    assert_equal "South Pearl Street Farmers Market", @market.name
    assert_equal expect_empty_array, @market.vendors
  end

  def test_it_can_add_vendors
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)
    @market.add_vendor(vendor_1)
    expected_vendors = [vendor_1, vendor_2, vendor_3]

    assert_equal expected_vendors, @market.vendors
  end

  def test_it_can_show_vendor_names
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)
    @market.add_vendor(vendor_1)
    expected_vendors_names = ["Rocky Mountain Fresh", "Ba-Nom-a-Nom", "Palisade Peach Shack"]

    assert_equal expected_vendors_names, @market.vendor_names
  end

  def test_it_can_reference_vendors_items
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)
    @market.add_vendor(vendor_1)
    expected_peach_vendors = [vendor_1, vendor_3]
    expected_banana_vendors = [vendor_2]

    assert_equal expected_peach_vendors, @market.vendors_that_sell("Peaches")
    assert_equal expected_banana_vendors, @market.vendors_that_sell("Banana Nice Cream")
  end

  def test_it_can_produce_sorted_item_list
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)
    @market.add_vendor(vendor_1)
    expected_list = ["Banana Nice Cream", "Peach-Raspberry Nice Cream", "Peaches", "Tomatoes"]

    assert_equal expected_list, @market.sorted_item_list
  end

  def test_it_can_show_total_inventory
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)
    @market.add_vendor(vendor_1)
    expected_inventory = {"Peaches"=>100, "Tomatoes"=>7, "Banana Nice Cream"=>50, "Peach-Raspberry Nice Cream"=>25}

    assert_equal expected_inventory, @market.total_inventory
  end

  def test_it_cant_sell_more_than_it_has
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)
    @market.add_vendor(vendor_1)

    assert_equal false, @market.sell("Peaches", 200)
    assert_equal false, @market.sell("Onions", 1)
    assert_equal true, @market.sell("Banana Nice Cream", 5)
    assert_equal true, @market.sell("Peaches", 40)
  end

  def test_it_can_sell_from_first_vendor_and_check_vendor_stock
    vendor_1 = Vendor.new("Rocky Mountain Fresh")
    vendor_1.stock("Peaches", 35)
    vendor_1.stock("Tomatoes", 7)
    vendor_2 = Vendor.new("Ba-Nom-a-Nom")
    vendor_2.stock("Banana Nice Cream", 50)
    vendor_2.stock("Peach-Raspberry Nice Cream", 25)
    vendor_3 = Vendor.new("Palisade Peach Shack")
    vendor_3.stock("Peaches", 65)
    @market.add_vendor(vendor_1)
    @market.add_vendor(vendor_2)
    @market.add_vendor(vendor_3)
    @market.add_vendor(vendor_1)
    @market.sell("Banana Nice Cream", 5)
    @market.sell("Peaches", 40)

    assert_equal 45, vendor_2.check_stock("Banana Nice Cream")
    assert_equal 0, vendor_1.check_stock("Peaches")
    assert_equal 60, vendor_3.check_stock("Peaches")
  end
end

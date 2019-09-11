require 'minitest/autorun'
require 'minitest/pride'
require './lib/vendor'
require 'pry'


class VendorTest < Minitest::Test

  def setup
    @vendor = Vendor.new("Rocky Mountain Fresh")
  end

  def test_it_exists
    assert_instance_of Vendor, @vendor
  end

  def test_has_attributes
    expected = {}
    assert_equal "Rocky Mountain Fresh", @vendor.name
    assert_equal expected, @vendor.inventory
  end

  def test_stock_check_returns_empty
    assert_equal 0, @vendor.check_stock("Peaches")
  end

  def test_it_can_stock
    @vendor.stock("Peaches", 30)
    assert_equal 30, @vendor.check_stock("Peaches")
  end

  def test_it_combines_stock
    @vendor.stock("Peaches", 30)
    @vendor.stock("Peaches", 25)
    assert_equal 55, @vendor.check_stock("Peaches")
  end

  def test_it_can_inventory_multiple_items
    @vendor.stock("Peaches", 30)
    @vendor.stock("Peaches", 25)
    @vendor.stock("Tomatoes", 12)
    expected = {"Peaches"=>55, "Tomatoes"=>12}

    assert_equal expected, @vendor.inventory
  end
  
end

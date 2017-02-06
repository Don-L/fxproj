require 'test_helper'

class ExchangeRateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "at returns 1.00 if base == counter" do
    rate = ExchangeRate.at(Date.parse('2017-02-05'), 'EUR', 'EUR')
    assert_equal(1.00, rate)
  end

  test "at returns rate from table if it exists" do
    rate = ExchangeRate.at(Date.parse('2017-02-05'), 'EUR', 'ZAR')
    assert_equal(2.0, rate)
  end

  test "at returns 1/ appropriate rate from table if counter is EUR" do
    rate = ExchangeRate.at(Date.parse('2017-02-05'), 'GBP', 'EUR')
    assert_equal(2.0, rate)
  end

  test "at returns appropriate cross rate if necessary" do
    rate = ExchangeRate.at(Date.parse('2017-02-05'), 'ZAR', 'GBP')
    assert_equal(0.25, rate)
  end

  test "all_currencies returns sorted array of all currencies" do
    arr = ExchangeRate.all_currencies
    assert_equal(3, arr.length)
    assert_equal('ZAR', arr[2])
  end

  test "given an invalid date in the form of a string YYYY-MM-DD, can return an alternative valid date string" do
    date_string = ExchangeRate.find_valid_date('2016-11-31')
    assert_equal(Date.parse('2016-11-30'), date_string)
  end

end

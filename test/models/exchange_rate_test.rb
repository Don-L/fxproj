require 'test_helper'

class ExchangeRateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "at returns 1.00 if base == counter" do
    rate = ExchangeRate.at(Date.parse('2017-02-04'), 'EUR', 'EUR')
    assert_equal(1.00, rate)
  end

  test "at returns rate from table if it exists" do
    rate = ExchangeRate.at(Date.parse('2017-02-04'), 'EUR', 'ZAR')
    assert_equal(2.0, rate)
  end

  test "at returns 1/ appropriate rate from table if counter is EUR" do
    rate = ExchangeRate.at(Date.parse('2017-02-04'), 'GBP', 'EUR')
    assert_equal(2.0, rate)
  end

  test "at returns appropriate cross rate if necessary" do
    rate = ExchangeRate.at(Date.parse('2017-02-04'), 'ZAR', 'GBP')
    assert_equal(0.25, rate)
  end

  test "all_currencies returns sorted array of all currencies" do
    arr = ExchangeRate.all_currencies
    assert_equal(3, arr.length)
    assert_equal('ZAR', arr[2])
  end

  test "given an invalid date in the form of a string YYYY-MM-DD, can return an alternative valid date string" do
    date = ExchangeRate.find_valid_date('2016-11-31')
    assert_equal(Date.parse('2016-11-30'), date)
  end

  test "given a valid date string that is earlier than the earliest record, returns the earliest date in the records" do
    date_string = '2016-01-01'
    assert_equal(Date.parse('2017-02-04'), ExchangeRate.select_date_from_records(date_string))
  end

  test "given a valid date string that is later than the latest record, returns the latest date in the records" do
    date_string = '2017-02-07'
    assert_equal(Date.parse('2017-02-06'), ExchangeRate.select_date_from_records(date_string))
  end

  test "given a valid date string that is from an in-range non-working day, returns the date of the next working day" do
    date_string = '2017-02-05'
    assert_equal(Date.parse('2017-02-06'), ExchangeRate.select_date_from_records(date_string))
  end

end

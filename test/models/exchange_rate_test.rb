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

end

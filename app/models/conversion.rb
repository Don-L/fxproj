class Conversion

  attr_reader(:converted_amount, :rate)

  def initialize(date, base, counter, amount)
    @date = date
    @base = base
    @counter = counter
    @amount = amount
    @converted_amount = amount * ExchangeRate.at(date, base, counter)
    @rate = ExchangeRate.at(date, base, counter)
  end


end

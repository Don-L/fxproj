class Conversion

  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def persisted?
    false
  end

  attr_reader(:converted_amount, :rate, :date, :base, :counter, :amount)

  def initialize(date, base, counter, amount)
    @date = date
    @base = base
    @counter = counter
    @amount = amount.to_f
    @converted_amount = @amount * ExchangeRate.at(@date, @base, @counter)
    @rate = ExchangeRate.at(@date, @base, @counter)
  end


end

class Conversion

  extend ActiveModel::Naming
  include ActiveModel::Conversion

  def persisted?
    false
  end

  attr_reader(:converted_amount, :rate, :date, :base, :counter, :amount, :year, :month, :day)

  def initialize(args)
    @base = args[:base]
    @counter = args[:counter]
    @amount = args[:amount].to_f
    if args[:year]
      @year = args[:year]
      @month = args[:month]
      @day = args[:day]
      @date = Date.parse(@year.to_s + '-' + @month.to_s + '-' + @day.to_s)
    else
      @date = args[:date]
      @year = @date.year
      @month = @date.month
      @day = @date.day
    end
    @converted_amount = @amount * ExchangeRate.at(@date, @base, @counter)
    @rate = ExchangeRate.at(@date, @base, @counter)
  end

  def self.get_months_for_select
    month_names = ExchangeRate.all_months_names
    month_numbers = ExchangeRate.all_months
    i = 0
    arr = []
    while i < month_names.length
      arr = arr.push([month_names[i], month_numbers[i]])
      i += 1
    end
    return arr
  end


end

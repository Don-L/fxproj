class ExchangeRate < ApplicationRecord

  def self.at(date, base, counter)
    if base == counter
      return 1.00
    end
    if base == 'EUR' || counter == 'EUR'
      if base == 'EUR'
        record = self.find_by date: date, counter: counter
        return record.rate
      end
      if counter == 'EUR'
        record = self.find_by date: date, counter: base
        return 1 / record.rate
      end
    else
      self.at_cross(date, base, counter)
    end
  end

  def self.at_cross(date, base, counter)
    record1 = self.find_by date: date, base: 'EUR', counter: base
    record2 = self.find_by date: date, base: 'EUR', counter: counter
    rate1 = record1.rate
    rate2 = record2.rate
    return rate2 / rate1
  end

  def self.all_currencies #returns array of all currencies
    bases = self.pluck(:base)
    counters = self.pluck(:counter)
    return bases.concat(counters).uniq.sort
  end

  def self.all_dates
    return self.pluck(:date).uniq.sort
  end

  def self.all_years
    years = self.all_dates.map {|date| date.year}
    return years.uniq
  end

  def self.all_months
    months = self.all_dates.map {|date| date.month}
    return months.uniq
  end

  def self.all_months_names
    months = self.all_months
    names = self.all_dates.map{|date| date.strftime("%B")}
    return names.uniq
  end

  def self.start_date
    return self.all_dates[0]
  end

  def self.end_date
    return self.all_dates.last
  end

  def self.lower_date_bound(period)
    date = self.start_date
    case period
    when 'day'
      return date.day
    when 'month'
      return date.month
    when 'year'
      return date.year
    end
  end

  def self.upper_date_bound(period)
    date = self.end_date
    case period
    when 'day'
      return date.day
    when 'month'
      return date.month
    when 'year'
      return date.year
    end
  end

  def self.select_date_from_records(date_string)
    arr = date_string.split('-')
    arr = arr.map{|item| item.to_i}
    if Date.valid_date?(arr[0], arr[1], arr[2]) == false
      date = self.find_valid_date(date_string)
    else
      date = Date.parse(date_string)
    end
    earliest = self.start_date
    latest = self.end_date
    all_dates = self.all_dates
    if date < earliest
      return earliest
    elsif date > latest
      return latest
    elsif all_dates.include?(date) == false
      while all_dates.include?(date) == false
        date = date.next_day(1)
      end
    end  
    return date
  end

  def self.find_valid_date(invalid_date_string)
    arr = invalid_date_string.split('-')
    arr = arr.map{|item| item.to_i}
    while Date.valid_date?(arr[0], arr[1], arr[2]) == false do
      arr[2] -=  1
    end
    return Date.parse(arr[0].to_s + '-' + arr[1].to_s + '-' + arr[2].to_s)
  end

end

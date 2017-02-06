class ConversionsController < ApplicationController

  def index
  end

  def new
    @currencies = ExchangeRate.all_currencies
    @start_date = ExchangeRate.start_date
    @start_day = ExchangeRate.lower_date_bound('day')
    @start_month = ExchangeRate.lower_date_bound('month')
    @start_year = ExchangeRate.lower_date_bound('year')
    @years = ExchangeRate.all_years
    @months = Conversion.get_months_for_select
    @days = (1..31).to_a
    @year = Date.today.year
    @month = Date.today.month
    @day = Date.today.day
  end

  def show
    if params[:id] #get request to conversions/show
      redirect_to '/conversions/new'
    else
      if params[:conversion] #post from conversions/show
        date_string = params[:conversion][:year] + '-' + params[:conversion][:month] + '-' + params[:conversion][:day]
        @base = params[:conversion][:base]
        @counter = params[:conversion][:counter]
        @amount = params[:conversion][:amount]
      else #post from conversions/new
        date_string = params[:year] + '-' + params[:month] + '-' + params[:day]
        @base = params[:base]
        @counter = params[:counter]
        @amount = params[:amount]
      end
      @date = ExchangeRate.select_date_from_records(date_string)
      @conversion = Conversion.new(date: @date, base: @base, counter: @counter, amount: @amount)
      @converted_amount = sprintf('%.2f', @conversion.converted_amount)
      @rate = sprintf('%.4f', @conversion.rate)
      @currencies = ExchangeRate.all_currencies
      @start_date = ExchangeRate.start_date
      @start_day = ExchangeRate.lower_date_bound('day')
      @start_month = ExchangeRate.lower_date_bound('month')
      @start_year = ExchangeRate.lower_date_bound('year')
      @years = ExchangeRate.all_years
      @months = Conversion.get_months_for_select
      @days = (1..31).to_a
      @day = @conversion.day
      @month = @conversion.date.month
      @year = @conversion.year
    end
  end



end

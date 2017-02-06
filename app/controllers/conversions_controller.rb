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
    @months = ExchangeRate.all_months_names
    @days = (1..31).to_a
    @year = Date.today.year
    @month = Date.today.strftime('%B')
    @day = Date.today.day
  end

  def show
    if params[:id] #get request to conversions/show
      redirect_to '/conversions/new'
    else
      if params[:conversion] #post from conversions/show
        @date = Date.parse(params[:conversion][:year] + '-' + params[:conversion][:month] + '-' + params[:conversion][:day])
        @base = params[:conversion][:base]
        @counter = params[:conversion][:counter]
        @amount = params[:conversion][:amount]
      else #post from conversions/new
        @date = Date.parse(params[:year] + '-' + params[:month] + '-' + params[:day])
        @base = params[:base]
        @counter = params[:counter]
        @amount = params[:amount]
      end
      @conversion = Conversion.new(date: @date, base: @base, counter: @counter, amount: @amount)
      @converted_amount = sprintf('%.2f', @conversion.converted_amount)
      @rate = sprintf('%.4f', @conversion.rate)
      @currencies = ExchangeRate.all_currencies
      @start_date = ExchangeRate.start_date
      @start_day = ExchangeRate.lower_date_bound('day')
      @start_month = ExchangeRate.lower_date_bound('month')
      @start_year = ExchangeRate.lower_date_bound('year')
      @years = ExchangeRate.all_years
      @months = ExchangeRate.all_months_names
      @days = (1..31).to_a
      @day = @conversion.day
      @month = @conversion.date.strftime("%B")
      @year = @conversion.year
    end
  end



end

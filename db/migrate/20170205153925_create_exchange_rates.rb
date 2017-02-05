class CreateExchangeRates < ActiveRecord::Migration[5.0]
  def change
    create_table :exchange_rates do |t|
      t.date :date
      t.string :base
      t.string :counter
      t.float :rate

      t.timestamps
    end
  end
end

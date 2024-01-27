class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  validates :name, :ticker, presence: true

  def self.new_lookup(ticker)
    if ticker && !ticker.empty?
      client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iexcloud[:public],
        secret_token: Rails.application.credentials.iexcloud[:secret],
        endpoint: 'https://cloud.iexapis.com/v1'
      )
      if ticker == "VOO"
        return new(ticker: "VOO", name: "Vanguard", last_price: 444)
      end
      begin
        new(ticker: ticker, name: client.company(ticker).company_name, last_price: client.price(ticker))
      rescue => exception
        return nil
      end
    end
  end

  def self.check_in_db (ticker)
    Stock.where(ticker: ticker).first
  end

end

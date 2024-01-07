class Stock < ApplicationRecord

  def self.new_lookup(ticker)
    if ticker && !ticker.empty?
      client = IEX::Api::Client.new(
        publishable_token: Rails.application.credentials.iexcloud[:public],
        secret_token: Rails.application.credentials.iexcloud[:secret],
        endpoint: 'https://cloud.iexapis.com/v1'
      )
      begin
        new(ticker: ticker, name: client.company(ticker).company_name, last_price: client.price(ticker))
      rescue => exception
        return nil
      end
    end
  end

end

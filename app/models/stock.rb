class Stock < ApplicationRecord

  def self.new_lookup(ticker)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iexcloud[:public],
      secret_token: Rails.application.credentials.iexcloud[:secret],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
    client.price(ticker)
  end

end

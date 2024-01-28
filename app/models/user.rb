class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  def has_stock(ticker)
    stock = Stock.check_in_db(ticker)
    return false unless stock
    !stocks.where(id: stock.id).blank?
  end

  def has_space
    stocks.count < 2
  end

  def can_track(ticker)
    has_space && !has_stock(ticker)
  end

  def full_name
    if first_name || last_name
      "#{first_name} #{last_name}"
    else
      "Anonymous"
    end
  end
end

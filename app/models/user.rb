class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_stocks
  has_many :stocks, through: :user_stocks
  has_many :friendships
  has_many :friends, through: :friendships

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

  def except_current_user(users)
    users.reject { |user| user.id == self.id}
  end

  def in_friendship_with?(id)
    self.friends.where(id: id).exists?
  end

  def self.search(search_param)
    cleaned = search_param.strip
    response = (matches('email', cleaned).or(matches('first_name', cleaned)).or(matches('last_name', cleaned))).uniq
    return nil unless response
    response
  end

  def self.matches(field_name, param)
    where("#{field_name} like ?", "%#{param}%")
  end

end

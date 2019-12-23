class Customer < ApplicationRecord
  has_many :orders, dependent: :destroy
  has_many :new_england_orders, ->{ where(address_state: %w{VT NH MA CT ME RI}) }, class_name: "Order"
  belongs_to :country, foreign_key: :country_code, primary_key: :code
  has_many :log_entries, as: :logeable

  validates :name, presence: true
  validates :email, presence: true

  KINDS = [
    :standard,
    :vip,
  ].freeze

  def lifetime_value
    orders.map(&:total_price).reduce(0, :+)
  end
end

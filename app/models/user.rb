class User < ApplicationRecord
  has_many :item_users
  has_many :expense_users
  has_many :payments
  has_many :users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  scope :available_users_item, (lambda do |item_id|
    User.where.not(id: ItemUser.where(item_id: item_id).pluck(:user_id))
  end)

  scope :available_users_expense, (lambda do |expense_id|
    User.where.not(id: ExpenseUser.where(expense_id: expense_id).pluck(:user_id))
  end)

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "#{SecureRandom.hex(15)}@common_expenses.com"
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.link = auth.info.urls.Facebook
      user.image = auth.info.image
    end
  end

  def self.select_field_item(item_id)
    available_users_item(item_id).map { |u| [u.name, u.id] }
  end

  def self.select_field_expense(expense_id)
    available_users_expense(expense_id).map { |u| [u.name, u.id] }
  end
end

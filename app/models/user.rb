class User < ApplicationRecord
  has_many :item_users
  has_many :expense_users
  has_many :payments
  has_many :users

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  scope :available_users_item, (lambda do |item_id|
    where.not(id: ItemUser.where(item_id: item_id).pluck(:user_id))
  end)

  scope :used_users_item, (lambda do |item_id|
    where(id: ItemUser.where(item_id: item_id).pluck(:user_id))
  end)

  scope :available_users_expense, (lambda do |expense_id|
    where.not(id: ExpenseUser.where(expense_id: expense_id).pluck(:user_id))
  end)

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "#{SecureRandom.hex(15)}@common_expenses.com"
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.link = auth.info.urls.Facebook
      user.image = auth.info.image
      user.confirmed_at = DateTime.now
      user.confirmation_sent_at = DateTime.now
      user.confirmation_token = "own-token-#{SecureRandom.hex(10)}"
    end
  end

  def self.select_field_expense(expense_id)
    available_users_expense(expense_id).map { |u| [u.name, u.id] }
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end

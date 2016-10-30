class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, omniauth_providers: [:facebook]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email || "#{SecureRandom.hex(15)}@common_expenses.com"
      user.password = Devise.friendly_token[0, 20]
      user.name = auth.info.name
      user.link = auth.info.urls.Facebook
      user.image = auth.info.image
    end
  end
end

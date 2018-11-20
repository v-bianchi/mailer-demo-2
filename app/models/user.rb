class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :restaurants

  after_create :send_welcome_email, :subscribe_to_newsletter



  private

  def subscribe_to_newsletter
    SubscribeToNewsletterService.new(self).call if self.wants_to_subscribe
  end

  def send_welcome_email
    UserMailer.welcome(self).deliver_now
  end
end

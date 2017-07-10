class User < ApplicationRecord
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, if: :new_record?
  has_many :wikis, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def set_default_role
    self.role ||= :user
  end
  # Override devise confirm! message
  # def confirm!
  #  welcome_email
  #  super
  # end

  # private

  # def welcome_email
  #  UserMailer.welcome_message(self).deliver
  # end
end

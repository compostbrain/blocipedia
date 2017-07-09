class User < ApplicationRecord
  has_many :wikis, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  #Override devise confirm! message
  #def confirm!
  #  welcome_email
  #  super
  #end

  #private

  #def welcome_email
  #  UserMailer.welcome_message(self).deliver
  #end
end

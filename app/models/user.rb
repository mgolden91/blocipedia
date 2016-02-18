class User < ActiveRecord::Base

  before_save { self.role ||= :standard }

  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis

  enum role: [:standard, :premium, :admin]
end

class User < ActiveRecord::Base

  before_save { self.role ||= :standard }
  validates :username, format: { with: /\A[a-zA-Z0-9]+\Z/ }, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :wikis, through: :collaborators
  has_many :collaborators

  enum role: [:standard, :premium, :admin]


end

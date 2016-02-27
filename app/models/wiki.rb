class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :users, through: :collaborators
  has_many :collaborators
  scope :visible_to, -> (user) { user && (user.premium? || user.admin?) ? all : where(private: false) }
  # scope :visible_to, -> (user) { user ? all : where(private: false) }
  # scope :visible_to, -> (current_user) { (current_user && current_user.role != "standard") ? all : where(private: false) }

  def users
    collaborators.collect(&:user)
  end

end

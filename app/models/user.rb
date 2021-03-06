class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_and_belongs_to_many :rides
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def email_required?
  	false
  end

  def email_changed?
  	false
  end

  validates :phone, uniqueness: true, length: { is: 10 }

  validates :firstname, :lastname, presence: true

  validates :phone, numericality: { only_integer: true }
end

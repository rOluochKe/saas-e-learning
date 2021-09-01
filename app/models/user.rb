class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable, :confirmable

  rolify

  has_many :courses

  def to_s
    email
  end

  def username
    email.split(/@/).first if email.present?
  end

  extend FriendlyId
  friendly_id :email, use: :slugged

  after_create :assign_default_role
  def assign_default_role
    if User.count == 1
      add_role(:admin) if roles.blank?
      add_role(:teacher)
      add_role(:student)
    else
      add_role(:student) if roles.blank?
      add_role(:teacher) # if you want any user to be able to create own courses
    end
  end

  validate :must_have_a_role, on: :update

  def online?
    updated_at > 2.minutes.ago
  end

  private

  def must_have_a_role
    errors.add(:roles, 'Must have at least one role') unless roles.any?
  end
end

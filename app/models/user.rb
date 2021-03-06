class User < ActiveRecord::Base
  after_create :welcome_email
  
  has_many :links
  # has_many :categories, through: :links

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :url, :bio, :email, :password, :password_confirmation, :remember_me

  validates_uniqueness_of :email, :username
  
  validates_presence_of :username

  protected
    def welcome_email
      UserMailer.welcome_email(self).deliver
    end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
				 :omniauthable, omniauth_providers: [:google_oauth2]
         #:omniauth_callbacks => "callbacks"


  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   user = User.where(email: data['email']).first
  #
  #   # Uncomment the section below if you want users to be created if they don't exist
  #   unless user
  #       user = User.create(name: data['name'],
  #          email: data['email'],
  #          password: Devise.friendly_token[0,20]
  #       )
  #   end
  #   user
  # end

  # def google_oauth2
  #   # You need to implement the method below in your model (e.g. app/models/user.rb)
  #   @user = User.from_omniauth(request.env['omniauth.auth'])
  #
  #   if @user.persisted?
  #     flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: 'Google'
  #     sign_in_and_redirect @user, event: :authentication
  #   else
  #     session['devise.google_data'] = request.env['omniauth.auth'].except(:extra) # Removing extra as it can overflow some session stores
  #     redirect_to new_user_registration_url, alert: @user.errors.full_messages.join("\n")
  #   end
  # end

  	has_many :user_tickets
	has_many :tickets, :through => :user_tickets

	validates :email, presence: true, format: {with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/}, uniqueness: true

	#validates :phone, length: {minimum: 9, maximum: 12}, allow_blank: true
  #validates :password, format: {with: /\A[a-zA-Z0-9\.]{8,12}\z/ , message: "assword must be between 8 to 12 alphanumeric characters"}

  def self.from_omniauth(auth)
    puts "---------- inicio -----------"
    where(provider:auth.provider, uid:auth.uid).first_or_create do |user|
      puts "-------- 1 ---------"
      user.uid = auth.uid
      user.email = auth.info.email
      user.name = auth.info.name
      user.provider = auth.provider
      user.password = Devise.friendly_token[0,20]
      puts "-------- 2 ---------"
    end
  end

end

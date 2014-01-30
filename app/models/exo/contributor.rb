class Exo
  class Contributor
    include ::Exo::Document

    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, #:registerable,
           :recoverable, :rememberable, :trackable, :validatable

    field :email,              :type => String, :default => ""
    field :encrypted_password, :type => String, :default => ""

    ## Recoverable
    field :reset_password_token,   :type => String
    field :reset_password_sent_at, :type => Time

    ## Rememberable
    field :remember_created_at, :type => Time

    ## Trackable
    field :sign_in_count,      :type => Integer, :default => 0
    field :current_sign_in_at, :type => Time
    field :last_sign_in_at,    :type => Time
    field :current_sign_in_ip, :type => String
    field :last_sign_in_ip,    :type => String
    
    ##Other stuff
    
    field :name
    #field :is_able_to, type: Roles, default: Roles.new
    
    def name
      self[:name] || email.split('@').first
    end
    
    def avatar_url
      ::Gravatar.new(email).image_url
    end
    
    has_and_belongs_to_many :sites, class_name: 'Exo::Site', inverse_of: :contributors
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  attr_accessible :email, :password, :password_confirmation, :avatar, :remove_avatar, :remember_me, :username, :public_fields, :partei, :polit_amt, :verwaltung, :nutzungsbedingung, :ortsteil, :notes, :verein
  has_many :sympathies, :class_name => "Supporter"
  has_many :subscriptions, :dependent => :destroy
  has_many :quarter_subscriptions, :dependent => :destroy

  validates_presence_of :username
  validate :username_format, :unless => proc { username == email }
  validates_uniqueness_of :username, :case_sensitive => false
  validates_presence_of :nutzungsbedingung

  mount_uploader :avatar, AvatarUploader
  has_many :initiatives
  has_many :blogs
  has_many :neuigkeiten

  has_many :comments, :dependent => :destroy

  scope :moderators, -> { where(role: 'moderator') }

  def username_format
    all_valid_characters = username =~ /^[a-zA-Z0-9_-]{5,25}\z/i
    errors.add(:username, "Der Benutzername darf zwischen 5 und 20 Buchstaben und Zahlen und folgende Sonderzeichen enthalten: - _") unless all_valid_characters
  end

  def superadmin?
    role == 'superadmin'
  end

  def admin?
    role == 'admin'
  end

  def moderator?
    role == 'moderator'
  end

  def blocked?
    role == 'blocked'
  end

  def public_fields
    (super || '').split(',')
  end

  def public_fields=(fields)
    super(Array(fields).join(','))
  end

  def all_fields
    %w(username partei verein polit_amt verwaltung ortsteil_name)
  end

  def fields_visible_to(user)
    if user && (user.moderator? || user.admin? || user.superadmin?)
      all_fields
    else
      public_fields
    end
  end

  def ortsteil_name
    Quarter.find(ortsteil).name if ortsteil.present?
  end

  def update_with_password(params={})
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end
    update_attributes(params)
  end

  before_save do
    self.email.downcase! if self.email
  end

end

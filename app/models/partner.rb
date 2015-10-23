class Partner < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable
  has_paper_trail

  validates_presence_of :name
  validate :password_complexity

  belongs_to :site
  has_many :ivcontacts
  has_and_belongs_to_many :practices
  has_many :events, dependent: :destroy do
    def appointments
      self.where("schedule_dt >= ?", Date.today)
    end
  end

  def admin?
    role == 1
  end

  def supervisor?
    role == 1 || role == 3
  end

  ROLE_VALS = {
    "GHRI Staff" => 1,
    "Standard Access" => 2,
    "Supervisor Access" => 3
  }

  private
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-zA-z])(?=.*[\d@%& \!\.\$\^\*\(\)\+\?])/)
      errors.add :password, "must include at least one letter and one digit or special character"
    end
  end

end
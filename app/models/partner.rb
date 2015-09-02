class Partner < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable
  validates_presence_of :name

  validate :password_complexity

  has_paper_trail

  belongs_to :site
  has_many :practices, dependent: :destroy

  has_many :events, dependent: :destroy do
    def appointments
      self.where("schedule_dt >= ?", Date.today)
    end
  end

  enum role: {
    :ghri_staff => 1,
    :recruiter_standard => 2
  }

  def admin?
    role == "ghri_staff"
  end

  private
  def password_complexity
    if password.present? and not password.match(/^(?=.*[a-zA-z])(?=.*[\d@%& \!\.\$\^\*\(\)\+\?])/)
      errors.add :password, "must include at least one letter and one digit or special character"
    end
  end

end
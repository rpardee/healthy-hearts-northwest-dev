class Partner < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable
  belongs_to :site
  has_many :practices, dependent: :destroy
  has_many :events, dependent: :destroy do

    def appointments
      self.where("schedule_dt >= ?", Date.today)
    end

  end
end
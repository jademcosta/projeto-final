class AdministrativeActivity < Input
    attr_accessible :title, :institution, :date, :end_date

    validates :title, presence: true
    validates :institution, presence: true

end

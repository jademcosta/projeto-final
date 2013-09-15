class Research < Input
    attr_accessible :title, :date, :end_date, :subtype

    validates :subtype, presence: true
end

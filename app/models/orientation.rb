# encoding: utf-8

class Orientation < Input
    attr_accessible :status, :date, :institution, :end_date, :subtype, :student, :title, :text

    STATUS_VALUES = ['início', 'cancelamento', 'conclusão']
    SUBTYPE_VALUES = ['IC', 'PFC', 'M.Sc.', 'D.Sc.']

    validates :student, presence: true
    validates :status, inclusion: { in: STATUS_VALUES, message: "%{value} não é válido" }
    validates :subtype, inclusion: { in: SUBTYPE_VALUES, message: "%{value} não é válido" }

end

# encoding: utf-8

class Degree < Input
    attr_accessible :status, :subtype, :institution, :date

    STATUS_VALUES = ['início', 'qualificação', 'obtenção']

    validates :subtype, presence: true
    validates :status, inclusion: { in: STATUS_VALUES, message: "%{value} não é válido" }
end

# encoding: utf-8

class Award < Input
    attr_accessible :text, :status, :date, :institution

    STATUS_VALUES = ['indicado para', 'recebido']

    validates :text, presence: true
    validates :status, inclusion: { in: STATUS_VALUES, message: "%{value} não é válido" }
end

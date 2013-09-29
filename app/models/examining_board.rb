# encoding: utf-8

class ExaminingBoard < Input
    attr_accessible :text, :date, :subtype

    SUBTYPE_VALUES = ['concurso público', 'exame de qualificação (M.Sc.)', 'exame de qualificação (D.Sc.)', 'defesa de PFC', 'defesa de dissertação de mestrado', 'defesa de tese de doutorado']

    validates :subtype, inclusion: { in: SUBTYPE_VALUES, message: "%{value} não é válido" }
    validates :text, presence: true
    validates :date, presence: true
end

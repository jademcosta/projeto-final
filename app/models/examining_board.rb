# encoding: utf-8

class ExaminingBoard < Input
    attr_accessible :text, :date, :subtype, :authors_attributes

    has_many :authors, inverse_of: :input, foreign_key: "input_id"

    accepts_nested_attributes_for :authors, allow_destroy: true, reject_if: proc { |attributes| attributes['name'].blank? }

    SUBTYPE_VALUES = ['concurso público', 'exame de qualificação (M.Sc.)', 'exame de qualificação (D.Sc.)', 'defesa de PFC', 'defesa de dissertação de mestrado', 'defesa de tese de doutorado']

    validates :subtype, inclusion: { in: SUBTYPE_VALUES, message: "%{value} não é válido" }
    validates :text, presence: true
    validates :date, presence: true
end

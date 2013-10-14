# encoding: utf-8

class EventParticipation < Input
    attr_accessible :title, :city, :country, :date, :event_type, :subtype

    SUBTYPE_VALUES = ['organização (steering committee)', 'apresentação oral de trabalho', 'apresentação de poster', 'membro de comitê avaliador', 'participante']

    EVENT_TYPE_VALUES = ['congresso', 'simpósio', 'seminário', 'palestra', 'visita técnica']

    validates :title, presence: true
    validates :subtype, inclusion: { in: SUBTYPE_VALUES, message: "%{value} não é válido" }
    validates :event_type, inclusion: { in: EVENT_TYPE_VALUES, message: "%{value} não é válido" }, allow_blank: true
end

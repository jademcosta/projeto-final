# encoding: utf-8

class ExtensionActivity < Input
    attr_accessible :title, :subtype, :text, :date, :end_date

    validates :title, presence: true
end

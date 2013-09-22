# encoding: utf-8

class Author < ActiveRecord::Base
    attr_accessible :name

    belongs_to :input
end

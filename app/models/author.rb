# encoding: utf-8

class Author < ActiveRecord::Base
    attr_accessible :name #, :input_id

    belongs_to :input
end

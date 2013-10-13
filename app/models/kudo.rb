class Kudo < ActiveRecord::Base

    attr_accessible :input, :input_id

    belongs_to :input
    belongs_to :user

    validates :input_id, presence: true
    validates :user_id, presence: true
end

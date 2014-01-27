class Input < ActiveRecord::Base
    #self.per_page = 10
    #attr_accessible :type
    belongs_to :user
    has_many :kudos, dependent: :destroy
	default_scope order: 'inputs.created_at DESC'
end

class Input < ActiveRecord::Base
    
    belongs_to :user
    has_many :kudos, dependent: :destroy
	default_scope order: 'inputs.created_at DESC'
end

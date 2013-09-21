class Input < ActiveRecord::Base
    
    belongs_to :user
	default_scope order: 'inputs.created_at DESC'
end

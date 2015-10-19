class Counter < ActiveRecord::Base
	self.primary_key = 'updated_at'
end
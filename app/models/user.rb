class User < ActiveRecord::Base
	before_save :set_permission
	has_many :spaces, foreign_key: "poster_id"
	has_one :recent_claim, class_name: "Space", foreign_key: "claimer_id"

	def recent_post
		self.spaces[-1].id
	end

	private


	def set_permission
		if self.spaces_posted/self.spaces_consumed < 0.8
			self.can_consume = false
      true
		else
			self.can_consume = true
		end
	end
end

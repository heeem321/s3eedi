module PostsHelper
	def user_allowed
  		user_signed_in? && (current_user.id == @job.user_id)
	end
end

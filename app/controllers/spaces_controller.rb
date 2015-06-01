class SpacesController < ApplicationController
	before_action :allow_cross_domain

	def index
		@spaces = Space.where(created_at: 90.minutes.ago..Time.now, active: true)
		render json: @spaces
		# filter spaces based on location
		# display all nearby spaces to user
	end

	def create
		@space = Space.new(space_params)
		@space.save_js_time
		@space.save
		render json: @space
	end

	def update
		@space = Space.find(params[:id])
		if @space.toggle!(:active)
			render json: @space
		end
	end

	# def destroy
	# 	# destroy bad markers?
	# end

	private

	def space_params
		params.require(:space).permit(:latitude, :longitude, :active, :note)
	end

	def allow_cross_domain
	  headers['Access-Control-Allow-Origin'] = '*'
	  headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
	  headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, X-Prototype-Version, Content-Type, Accept, Authorization, Token'
	end
end

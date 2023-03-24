class ActivitiesController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_error_msg
    
def index
        render json: Activity.all
    end

    def destroy
        activity = Activity.find(params[:id])
        activity.destroy
        head :no_content
    end

    private 

    def render_error_msg(invalid)
        render json: {error: "Activity not found"}, status: :not_found
    end
end
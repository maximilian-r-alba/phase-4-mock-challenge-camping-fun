class CampersController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_error_msg
rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_msg
    def index
        render json: Camper.all
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, include: [:activities]
    end

    def create
        camper = Camper.create!(camper_params)
        render json: camper, status: :created
    end

    private

    def render_invalid_msg(invalid)
        render json:{errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_error_msg(invalid)
        render json: {error: "Camper not found"}, status: :not_found
    end

    def camper_params
        params.permit(:name, :age)
    end
end

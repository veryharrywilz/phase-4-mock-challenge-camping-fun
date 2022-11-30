class CampersController < ApplicationController

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

    def index
        campers = Camper.all 
        render json: campers, status: :ok 
    end

    def show
        camper = Camper.find(params[:id])
        render json: camper, serializer: CamperWithActivitiesSerializer 
    end

    def create 
        camper = Camper.create!(camper_params)
        render json: camper, status: :created 
    end

    private

    def camper_params
        params.permit(:name, :age)
    end

    def record_not_found
        render json: {error: "Camper not found" }, status: :not_found 
    end

    def handle_record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages }, status: 422
    end 
end

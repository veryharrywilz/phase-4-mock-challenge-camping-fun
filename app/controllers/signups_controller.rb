class SignupsController < ApplicationController

    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid

    def create
        signup = Signup.create!(signup_params)
        render json: signup.activity, status: :created 
    end

    private

    def signup_params
        params.permit(:time, :activity_id, :camper_id)
    end

    def handle_record_invalid(invalid)
        render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity 
    end 

end

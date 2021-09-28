class ApplicationController < ActionController::API
  include ActionController::Cookies
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid_message
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_message

  private

    def record_not_found_message
      render json: {error: instance.message}, status: 404
    end

    def record_invalid_message(instance)
      render json: {errors: [instance.message]}, status: 422
    end

    #one possibility for authorization- the ||= makes sure that you won't constantly be querying the server because it will check if the variable is already set
    # def current_user
    #   @current_user ||= User.find_by(id: session[:id])
    # end

end

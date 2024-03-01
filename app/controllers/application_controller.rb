class ApplicationController < ActionController::API
    rescue_from CanCan::AccessDenied do |exception|
        respond_to do |format|
          format.json { render json: { error: "Access denied", message: exception.message }, status: :forbidden }
        end
      end
end

    
  
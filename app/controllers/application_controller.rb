class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :date_of_birth, :role, 
            address_attributes: [:street_number, :street_name, :postcode, :suburb, 
                state_attributes: [:name, 
                    country_attributes: [:name]]]])
    end
end

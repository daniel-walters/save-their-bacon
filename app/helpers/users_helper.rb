module UsersHelper
    def get_user_role_on_signup
        params[:role] ? params[:role] : resource.role
    end
end
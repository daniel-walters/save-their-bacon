module ApplicationHelper
    def display_post_animal
        return "disabled" if !user_signed_in? || current_user.sponsor? 
    end
end

module ApplicationHelper
    def display_post_animal
        return "disabled" if !user_signed_in? || current_user.sponsor? || !current_user.approved
    end

    def set_nav_item_active(page)
        return "active" if current_page?(page)
    end
end

module AnimalsHelper
    def image_select(animal)
        return animal.profile_picture if animal.profile_picture.attached?
        #use placeholder if no img attached
        return "animal_placeholder.png"
    end

    def user_is_sanctuary_and_owner(animal)
        current_user&.sanctuary? && animal.owner_id == current_user&.id && current_user&.approved?
    end

    def user_is_animal_sponsor(animal)
        current_user&.sponsor? && animal&.sponsorship&.sponsor == current_user
    end
end

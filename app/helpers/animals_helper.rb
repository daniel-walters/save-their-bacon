module AnimalsHelper
    def image_select(animal)
        return animal.profile_picture if animal.profile_picture.attached?
        #use placeholder if no img attached
        return "animal_placeholder.png"
    end
end

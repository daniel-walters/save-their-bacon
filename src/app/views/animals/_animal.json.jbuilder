json.extract! animal, :id, :name, :year_born, :weight, :bio, :species, :sponsored, :sponsor_price, :category_id, :owner_id, :created_at, :updated_at
json.url animal_url(animal, format: :json)

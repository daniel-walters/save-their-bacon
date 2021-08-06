# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if Country.count == 0
    Country.create(name: "Australia")
end

if State.count == 0
    state = State.create(name: "Western Australia", country_id: 1)
end

if Address.count == 0
    address = Address.new(street_number: "123", street_name: "Admin St", postcode: "1234", suburb: "Admington")
    address.state = State.first
    address.save

    address = Address.new(street_number: "123", street_name: "Sponsor St", postcode: "2345", suburb: "Sponsor Lake")
    address.state = State.first
    address.save

    address = Address.new(street_number: "123", street_name: "Sanctuary St", postcode: "3456", suburb: "Sanctuary Hills")
    address.state = State.first
    address.save
end

if User.count == 0
    user = User.new(
        email: "admin@admin.com",
        password: "password",
        role: 2,
        first_name: "Admin",
        last_name: "Admins",
        date_of_birth: "01-01-1980",
        approved: true
    )
    user.address = Address.first
    user.save

    user = User.new(
        email: "sponsor@sponsor.com",
        password: "password",
        role: 0,
        first_name: "Spon",
        last_name: "Sor",
        date_of_birth: "01-01-1980",
        approved: true
    )
    user.address = Address.find(2)
    user.save

    user = User.new(
        email: "sanctuary@sanctuary.com",
        password: "password",
        role: 1,
        first_name: "Sanc",
        last_name: "Tuary",
        date_of_birth: "01-01-1980",
        approved: true
    )
    user.address = Address.find(2)
    user.save    
end

if Category.count == 0
    Category.create(name: "Pig")
    Category.create(name: "Cow")
    Category.create(name: "Sheep")
    Category.create(name: "Chicken")
    Category.create(name: "Horse")
    Category.create(name: "Goat")
    Category.create(name: "Duck")
    Category.create(name: "Turkey")
end

if Animal.count == 0
    a = Animal.new(name: "Pete the Pig", year_born: 2010, weight: 100, bio: "he a pig oink oink mf", species: "big oinker", sponsored: false, sponsor_price: 2000)
    a.category = Category.first
    a.owner = User.first
    a.save
end

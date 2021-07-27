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
    state = State.new(name: "Western Australia")
    state.country = Country.first
    state.save
end

if Address.count == 0
    address = Address.new(street_number: "123", street_name: "Fake St", postcode: "1234", suburb: "fake burb")
    address.state = State.first
    address.save

    address = Address.new(street_number: "456", street_name: "Fake St", postcode: "1234", suburb: "fake burb")
    address.state = State.first
    address.save
end

if User.count == 0
    user = User.new(
        email: "admin@admin.com",
        password: "password",
        role: 2,
        first_name: "admin",
        last_name: "admington",
        date_of_birth: "01-01-1980",
        approved: true
    )
    user.address = Address.first
    user.save

    user = User.new(
        email: "sponsor@sponsor.com",
        password: "password",
        role: 0,
        first_name: "sponsor",
        last_name: "sponny",
        date_of_birth: "01-01-1980",
        approved: true
    )
    user.address = Address.last
    user.save
end

if Category.count == 0
    Category.create(name: "Pig")
end

if Animal.count == 0
    a = Animal.new(name: "Pete the Pig", year_born: 2010, weight: 100, bio: "he a pig oink oink mf", species: "big oinker", sponsored: false, sponsor_price: 2000)
    a.category = Category.first
    a.owner = User.first
    a.save
end

if Sponsorship.count == 0
    s = Sponsorship.new(receipt: "blah")
    s.owner = User.first
    s.sponsor = User.last
    s.animal = Animal.first
    s.save
end
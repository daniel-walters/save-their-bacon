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
end
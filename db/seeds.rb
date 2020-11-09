# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(name: "Yukimi", email: "y.honda@buysell-technologies.com")
Task.create(name: "掃除", description: "掃除", user_id: user.id)
Admin.create(name: "Yukimi", mail: "y.honda@buysell-technologies.com", password: "1234")

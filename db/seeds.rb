# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name:  "Anuya",
             email: "aspadte17@gmail.com",
             password:              "anuya17",
             password_confirmation: "anuya17",
            )

User.create!(name:  "Neha",
             email: "neha@gmail.com",
             password:              "anuya17",
             password_confirmation: "anuya17",
            )

Category.create!(name: "Salary",
                 cat_type: "Income",
                 user_id: nil
                )

Category.create!(name: "Grocery",
                 cat_type: "Expense",
                 user_id: nil
                )

Category.create!(name: "Rent",
                 cat_type: "Expense",
                 user_id: nil
                )

Category.create!(name: "Miscellaneous",
                 cat_type: "Expense",
                 user_id: nil
                )
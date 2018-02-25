# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Question.destroy_all

Question.create(content: "How many states in Indonesia?", answer: "33")
Question.create(content: "How many members of Power Ranger?", answer: "5")
Question.create(content: "How many vowels are there in the English alphabet?", answer: "5")
Question.create(content: "How many members of Power Ranger?", answer: "5")
Question.create(content: "What is the height of the Ultraman Gaia in meters?", answer: "50")

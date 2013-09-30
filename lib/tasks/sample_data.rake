# encoding: utf-8

namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		make_users
		make_relationships
        make_inputs
	end
end

def make_users
	eu = User.create!(name: "Jade Costa", email: "jademcosta@gmail.com",
		password: "1234", password_confirmation: "1234")
	prof = User.create!(name: "Vinícius Gusmão", email: "vigusmao@gmail.com",
		password: "1234", password_confirmation: "1234")

	99.times do |n|
		name = Faker::Name.name
		email = "exemplo-#{n+1}@gmail.com"
		password = "senha"
		
		User.create!(name: name, email: email, password: password, password_confirmation: password)
	end
end

def make_relationships
	users = User.all
	user = users.first
	followed_users = users[2..50]
	followers = users[3..40]
	followed_users.each { |followed| user.follow!(followed) }
	followers.each { |follower| follower.follow!(user) }
end

def make_inputs
    prof = User.find_by_email("vigusmao@gmail.com")
    novo_input = prof.inputs.build
    novo_input.status = Orientation::STATUS_VALUES[0]
    novo_input.date = Time.now.midnight - 9.months
    novo_input.subtype = Orientation::SUBTYPE_VALUES[1]
    novo_input.student = "Jade Moreira da Costa"
    novo_input.title = "Ruby on rails para construir uma rede social"
    novo_input.type = "Orientation"
    novo_input.save!
end

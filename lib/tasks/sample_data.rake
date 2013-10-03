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
	followed_users = users[1..50]
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

    outro_input = prof.inputs.build
    outro_input.status = Degree::STATUS_VALUES[2]
    outro_input.subtype = "Doutorado"
    outro_input.institution = "UFRJ"
    outro_input.type = "Degree"
    outro_input.save!
    outro_input.created_at = 3.day.ago
    outro_input.save!

    eu = User.find_by_email("jademcosta@gmail.com")
    meu_input = eu.inputs.build
    meu_input.subtype = EventParticipation::SUBTYPE_VALUES[4]
    meu_input.event_type = EventParticipation::EVENT_TYPE_VALUES[3]
    meu_input.title = "Agile in Rio"
    meu_input.type = "EventParticipation"
    meu_input.save!
    meu_input.created_at = 1.day.ago
    meu_input.save!


end

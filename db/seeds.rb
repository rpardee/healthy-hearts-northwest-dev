# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

ActiveRecord::Base.connection.disable_referential_integrity do
	Event.delete_all
	Practice.delete_all
	Site.delete_all
	Partner.delete_all
end

sites = Site.create([{ name: 'ORPRN' }, { name: 'Qualis' }])

partner1 = Partner.new(site_id: sites.first.id, name: 'Marcelina Hilpert', email: 'marcelina@orprn.org', password: 'password', password_confirmation: 'password')
partner1.save!
partner2 = Partner.new(site_id: sites.second.id, name: 'Luther Brock', email: 'luther@ghc.org', password: 'password', password_confirmation: 'password')
partner2.save!
partner3 = Partner.new(site_id: sites.second.id, name: 'Stefan Daniella', email: 'stefan@qualis.org', password: 'password', password_confirmation: 'password')
partner3.save!

practices = Practice.create! ([
	{ partner_id: partner1.id, name: 'Bigger Practice',
		address: '100 Main St, Big City, USA', phone: '1-800-555-5555',
		url: 'http://www.microsoft.com', prac_state: 2 },
	{ partner_id: partner2.id, name: 'Smaller Clinic',
		address: '200 Main St, Smallville, USA', phone: '1-800-888-5555',
		url: 'http://www.google.com', prac_state: 3 },
	{ partner_id: partner2.id, name: 'Middling Medical',
		address: '300 Main St, Midtown, USA', phone: '1-800-888-5555',
		url: 'http://www.google.com', prac_state: 3 }
])

Event.create ([
	{ partner_id: partner1.id, practice_id: practices.first.id,
		schedule_dt: '2015-01-01', schedule_tm: '14:00:00', contact_type: 1,
		outcome: 1, description: 'First meeting' },
	{ partner_id: partner2.id, practice_id: practices.second.id,
		schedule_dt: '2016-01-01', schedule_tm: '15:00:00', contact_type: 2,
		outcome: 0, description: 'Second meeting' }
])
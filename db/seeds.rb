# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Event.delete_all
Practice.delete_all
Partner.delete_all
Site.delete_all

sites = Site.create([{ name: 'ORPRN' }, { name: 'Qualis' }])

partner1 = Partner.new(site_id: sites.first.id, name: 'Marcelina Hilpert', email: 'test@ghc.org', password: 'password', password_confirmation: 'password')
partner1.save!
partner2 = Partner.new(site_id: sites.first.id, name: 'Luther Brock', email: 'luther@ghc.org', password: 'password', password_confirmation: 'password')
partner2.save!

practices = Practice.create ([
	{ partner_id: partner1.id, name: 'First Clinic', address: '100 Main St, Big City, USA', phone: '1-800-555-5555', url: 'http://www.microsoft.com' },
	{ partner_id: partner1.id, name: 'Second Clinic', address: '200 Main St, Smallville, USA', phone: '1-800-888-5555', url: 'http://www.google.com' }
])

Event.create ([
	{ partner_id: partner1.id, practice_id: practices.first.id, schedule_dt: '2015-01-01', schedule_tm: '14:00:00', category: 1, outcome: 1, outcome_dt: '2015-01-02', description: 'First meeting' },
	{ partner_id: partner1.id, practice_id: practices.first.id, schedule_dt: '2016-01-01', schedule_tm: '15:00:00', category: 2, description: 'Second meeting' }
])
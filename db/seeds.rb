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

sites = Site.create([
	{ id: 0, name: 'GHRI' }, { id: 1, name: 'ORPRN' }, { id: 2, name: 'Qualis' }
])

Partner.create([
	{ id: 1, site_id: sites.first.id, name: 'Christopher Mack', email: 'mack.c@ghc.org',
		password: 'audience drawn dress all', password_confirmation: 'audience drawn dress all', role: 1 },
	{ id: 2, site_id: sites.first.id, name: 'Michael Parchman', email: 'parchman.m@ghc.org',
		password: 'must clock guard cat', password_confirmation: 'must clock guard cat', role: 1 },
	{ id: 3, site_id: sites.first.id, name: 'Allen Cheadle', email: 'cheadle.a@ghc.org',
		password: 'letter combine valuable furniture', password_confirmation: 'letter combine valuable furniture', role: 1 },
	{ id: 4, site_id: sites.first.id, name: 'Rob Penfold', email: 'penfold.r@ghc.org',
		password: 'blue throw remarkable out', password_confirmation: 'blue throw remarkable out', role: 1 },
	{ id: 5, site_id: sites.first.id, name: 'Fei Wan', email: 'wan.f@ghc.org',
		password: 'team yes public whistle', password_confirmation: 'team yes public whistle', role: 1 },
	{ id: 6, site_id: sites.first.id, name: 'Tali Klima', email: 'klima.t@ghc.org',
		password: 'huge fought blew block', password_confirmation: 'huge fought blew block', role: 1 },
	{ id: 7, site_id: sites.first.id, name: 'Erika Holden', email: 'holden.e@ghc.org',
		password: 'affect oil seeing mainly', password_confirmation: 'affect oil seeing mainly', role: 1 },
	{ id: 8, site_id: sites.first.id, name: 'Leah Tuzzio', email: 'tuzzio.l@ghc.org',
		password: 'explain ought enjoy nor', password_confirmation: 'explain ought enjoy nor', role: 1 }
])
Partner.create([
	{ id: 100, site_id: sites.second.id, name: '(not assigned: ORPRN)', email: 'na@ohsu.edu',
		password: 'ay0xF52XhsXN7HHh0XH1', password_confirmation: 'ay0xF52XhsXN7HHh0XH1', role: 2 },
	{ id: 101, site_id: sites.second.id, name: 'LeAnn Michaels', email: 'michaell@ohsu.edu',
		password: 'problem shown sweet waste', password_confirmation: 'problem shown sweet waste', role: 2 },
	{ id: 102, site_id: sites.second.id, name: 'Caitlin Dickinson', email: 'summerca@ohsu.edu',
		password: 'two finally pile rain', password_confirmation: 'two finally pile rain', role: 2 },
	{ id: 103, site_id: sites.second.id, name: 'Beth Sommers', email: 'sommers@ohsu.edu',
		password: 'zoo mood railroad fair', password_confirmation: 'zoo mood railroad fair', role: 2 },
	{ id: 104, site_id: sites.second.id, name: 'Raja Cholan', email: 'cholanr@ohsu.edu',
		password: 'handsome melted unusual store', password_confirmation: 'handsome melted unusual store', role: 2 },
	{ id: 105, site_id: sites.second.id, name: 'Shelby Martin', email: 'martshe@ohsu.edu',
		password: 'measure tune pitch molecular', password_confirmation: 'measure tune pitch molecular', role: 2 },
	{ id: 106, site_id: sites.second.id, name: 'Maggie McDonnell', email: 'mclainma@ohsu.edu',
		password: 'carried buried pony gate', password_confirmation: 'carried buried pony gate', role: 2 },
	{ id: 107, site_id: sites.second.id, name: 'Cullen Conway', email: 'conwaytemp@ohsu.edu',
		password: 'perfect build immediately railroad', password_confirmation: 'perfect build immediately railroad', role: 2 },
	{ id: 108, site_id: sites.second.id, name: 'Kristin Chatfield', email: 'chatfieldtemp@ohsu.edu',
		password: 'tie shade like broke', password_confirmation: 'tie shade like broke', role: 2 }
])
Partner.create([
	{ id: 200, site_id: sites.third.id, name: '(not assigned: Qualis)', email: 'na@qualishealth.org',
		password: 'qekpUNPM6cS1pUZxTkgg', password_confirmation: 'qekpUNPM6cS1pUZxTkgg', role: 2 },
	{ id: 201, site_id: sites.third.id, name: 'Ross Howell', email: 'rossh@qualishealth.org',
		password: 'toward wore that east', password_confirmation: 'toward wore that east', role: 2 },
	{ id: 202, site_id: sites.third.id, name: 'Shauna Banner', email: 'shaunab@qualishealth.org',
		password: 'trace circus sail clothes', password_confirmation: 'trace circus sail clothes', role: 2 },
	{ id: 203, site_id: sites.third.id, name: 'Jeff Sobotka', email: 'jeffs@qualishealth.org',
		password: 'duck personal cookies though', password_confirmation: 'duck personal cookies though', role: 2 },
	{ id: 204, site_id: sites.third.id, name: 'Tara Kline', email: 'tarak@qualishealth.org',
		password: 'putting pot teach fire', password_confirmation: 'putting pot teach fire', role: 2 },
	{ id: 205, site_id: sites.third.id, name: 'Rose Lauck', email: 'rosel@qualishealth.org',
		password: 'last winter flies box', password_confirmation: 'last winter flies box', role: 2 },
	{ id: 206, site_id: sites.third.id, name: 'Carolyn Brill', email: 'carolynb@qualishealth.org',
		password: 'especially east character he', password_confirmation: 'especially east character he', role: 2 },
	{ id: 207, site_id: sites.third.id, name: 'Zach Hodges', email: 'ZachH@qualishealth.org',
		password: 'railroad third swept man', password_confirmation: 'railroad third swept man', role: 2 }
])

# Dummy data below
# partner1 = Partner.new(site_id: sites.first.id, name: 'Marcelina Hilpert', email: 'marcelina@orprn.org',
# 	password: 'password', password_confirmation: 'password', role: 2)
# partner1.save!
# partner2 = Partner.new(site_id: sites.second.id, name: 'Luther Brock', email: 'luther@ghc.org',
# 	password: 'password', password_confirmation: 'password', role: 2)
# partner2.save!
# partner3 = Partner.new(site_id: sites.second.id, name: 'Stefan Daniella', email: 'stefan@qualis.org',
# 	password: 'password', password_confirmation: 'password', role: 2)
# partner3.save!

# practices = Practice.create! ([
# 	{ partner_id: partner1.id, name: 'Bigger Practice',
# 		address: '100 Main St, Big City, USA', phone: '1-800-555-5555',
# 		url: 'http://www.microsoft.com', prac_state: 2 },
# 	{ partner_id: partner2.id, name: 'Smaller Clinic',
# 		address: '200 Main St, Smallville, USA', phone: '1-800-888-5555',
# 		url: 'http://www.google.com', prac_state: 3 },
# 	{ partner_id: partner2.id, name: 'Middling Medical',
# 		address: '300 Main St, Midtown, USA', phone: '1-800-888-5555',
# 		url: 'http://www.google.com', prac_state: 3 }
# ])

# Event.create ([
# 	{ partner_id: partner1.id, practice_id: practices.first.id,
# 		schedule_dt: '2015-01-01', schedule_tm: '14:00:00', contact_type: 1,
# 		outcome: 1, description: 'First meeting' },
# 	{ partner_id: partner2.id, practice_id: practices.second.id,
# 		schedule_dt: '2016-01-01', schedule_tm: '15:00:00', contact_type: 2,
# 		outcome: 0, description: 'Second meeting' }
# ])
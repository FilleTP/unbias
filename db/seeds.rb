# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "deleting users"
User.destroy_all

puts "creating users"

User.create!(email: "tom.johnson@unbias.global",
             password: "123456",
             first_name: "Tom",
             last_name: "Johnson")

User.create!(email: "anna.flemming@unbias.global",
             password: "123456",
             first_name: "Anna",
             last_name: "flemming")

User.create!(email: "javier@unbias.global",
             password: "123456",
             first_name: "Javier",
             last_name: "Suay")

puts "created #{User.count} users"

puts "deleting articles"
Article.destroy_all

Source.destroy_all
puts "creating sources"

# SOURCES :

Source.create!(name: "ChinaDigitalTimes",
               source_keyword: "chinadigitaltimes",
               address: "China",
               img: "china-times.png",
               img_cloudinary: "china-times_fvvbel.png")

Source.create!(name: "Independent Online",
               source_keyword: "IOL",
               address: "South Africa",
               img: "independent-online.png",
               img_cloudinary: "independent-online_sykzex.png")

Source.create!(name: "The Journal",
               source_keyword: "thejournal",
               address: "Dublin",
               img: "journal-logo.png",
               img_cloudinary: "journal-logo_norfkd.png")

Source.create!(name: "India Times",
               source_keyword: "Indiatimes",
               address: "Mumbai, Maharastra, India",
               img: "indiatimes-logo.png",
               img_cloudinary: "indiatimes-logo_nyv1jb.png")

Source.create!(name: "Sputnik",
               source_keyword: "en",
               address: "Krasnoyarsk, Russia",
               img: "sputnik-logo.png",
               img_cloudinary: "sputnik-logo_tdgakc.png")

Source.create!(name: "WAtoday",
               source_keyword: "watoday",
               address: "Perth, Australia",
               img: "watoday-logo.png",
               img_cloudinary: "watoday-logo_zhbu6c.png")

Source.create!(name: "The Slovak Spectator",
               source_keyword: "spectator",
               address: "Bratislava, Slovakia",
               img: "slovak-logo.png",
               img_cloudinary: "slovak-logo_y67hag.png")

Source.create!(name: "Nigerian Tribune",
               source_keyword: "tribune",
               address: "Nigeria",
               img: "tribune-online.png",
               img_cloudinary: "tribune-online_xgaec6.png")

Source.create!(name: "SunLive",
               source_keyword: "sunlive",
               address: "Tauranga, New Zealand",
               img: "sunlive.png",
               img_cloudinary: "sunlive_nyknmn.png")

Source.create!(name: "Dutchnews",
               source_keyword: "dutchnews",
               address: "Amsterdam, Netherlands",
               img: "dutchnews.png",
               img_cloudinary: "dutchnews_awhyjl.png")

Source.create!(name: "Independent",
               source_keyword: "independent",
               address: "Manchester, England",
               img: "independent.png",
               img_cloudinary: "independent_ppkdcu.png")

Source.create!(name: "Daily Mail",
               source_keyword: "Mail",
               address: "Oxford, UK",
               img: "daily-mail-logo.png",
               img_cloudinary: "daily-mail-logo_vanniw.png")

Source.create!(name: "Manila Bulletin",
               source_keyword: "manila-bulletin",
               address: "Manila, Philippines",
               img: "manila-bulletin.png",
               img_cloudinary: "manila-bulletin_ejvjfn.png")

Source.create!(name: "The Hindu",
               source_keyword: "the-hindu",
               address: "Chennai, India",
               img: "the-hindu.png",
               img_cloudinary: "the-hindu_zghttr.png")

Source.create!(name: "Pakistan Today",
               source_keyword: "pakistan-today",
               address: "Pakistan",
               img: "pakistan-today.png",
               img_cloudinary: "pakistan-today_y11et1.png")

Source.create!(name: "The Korea Herald",
               source_keyword: "the-korea-herald",
               address: "Seoul, Korea",
               img: "korea-herald.png",
               img_cloudinary: "korea-herald_g4jj60.png")

Source.create!(name: "Thailand Business News",
               source_keyword: "thailand-business-news",
               address: "Bangkok, Thailand",
               img: "thailand-news.png",
               img_cloudinary: "thailand-news_k9fjpv.png")

Source.create!(name: "The Star online",
               source_keyword: "the-star-online",
               address: "Malaysia",
               img: "the-star.png",
               img_cloudinary: "the-star_t0xn5o.png")

Source.create!(name: "The Japan Times",
               source_keyword: "search",
               address: "Tokyo, Japan",
               img: "japan-times.png",
               img_cloudinary: "japan-times_ws2ruq.png")

Source.create!(name: "Jerusalem Post",
               source_keyword: "jerusalem-post",
               address: "Jerusalem, Israel",
               img: "jerusalem-post.png",
               img_cloudinary: "jerusalem-post_dmgw4v.png")

# SPECIAL ONES:
Source.create!(name: "The New York Times",
               source_keyword: "nytimes",
               address: "New York",
               img: "new-york-times.png",
               img_cloudinary: "new-york-times_vuuzjn.png")

Source.create!(name: "CNN",
               source_keyword: "cnn",
               address: "Atlanta, USA",
               img: "cnn-logo.png",
               img_cloudinary: "cnn-logo_cswxba.png")

Source.create!(name: "BBC",
               source_keyword: "bbc",
               address: "London, United Kingdom",
               img: "bbc-logo.png",
               img_cloudinary: "bbc-logo_tm8tgd.png")

Source.create!(name: "FOX",
               source_keyword: "foxnews",
               address: "Texas, USA",
               img: "fox-logo.png",
               img_cloudinary: "fox-logo_ksjhat.png")


# STILL NOT WORKING:

# Source.create!(name: "Haaretz",
#                source_keyword: "Haaretz - Science &amp; Health",
#                address: "Israel")

# Source.create!(name: "El País",
#                source_keyword: "el-pais-english", # no
#                address: "Madrid, Spain")

#  Source.create!(name: "Chinaworker",
#                 source_keyword: "chinaworker", # no
#                 address: "Beijing, China")

# WHISLIST:

# Source.create!(name: "Khabar Online",
#                source_keyword: "????",
#                address: "Iran")

puts "Created #{Source.count} sources."

puts "have a lovely day, your friend and savior Øyvind"

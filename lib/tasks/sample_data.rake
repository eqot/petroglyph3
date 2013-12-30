namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_videos
    make_playlists
    make_contains
    make_video_likes
  end
end

def make_users
  admin = User.create!(name: "Example User",
                      email: "example@example.com",
                      password: "foobar",
                      password_confirmation: "foobar",
                      admin: true)
  99.times do |n|
    name = Faker::Name.name
    email = "example-#{n+1}@example.com"
    password = "password"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_videos
  users = User.all[0..5]

  50.times do
    url = "http://www.youtube.com/"
    title = Faker::Lorem.sentence(1)
    description = Faker::Lorem.sentence(5)
    duration = 12 * 60 + 34
    users.each do |user|
      user.videos.create!(url: url, title: title, description: description, duration: duration)
    end
  end
end

def make_playlists
  users = User.all[0..5]

  10.times do
    title = Faker::Lorem.sentence(1)
    description = Faker::Lorem.sentence(5)
    users.each do |user|
      user.playlists.create!(title: title, description: description)
    end
  end
end

def make_contains
  playlists = Playlist.all
  playlist = playlists.first
  videos = Video.all[2..49]
  videos.each_with_index do |v, index|
    playlist.add!(v, index)
  end
end

def make_video_likes
  users = User.all[0..5]
  videos = Video.all[0..4]
  users.each do |user|
    videos.each { |video| user.video_like!(video) }
  end
end

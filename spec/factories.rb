FactoryGirl.define do
  factory :user do
    sequence(:name)  { |n| "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@example.com" }
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :video do
    url "http://youtube.com/"
    title "Video"
    description "Video Description"
    user
  end

  factory :playlist do
    title "Playlist"
    description "Playlist Description"
    user
  end

end

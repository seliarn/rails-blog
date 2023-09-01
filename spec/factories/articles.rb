FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    short_body { Faker::Lorem.paragraph }
    url { Faker::Internet.slug }
  end
end

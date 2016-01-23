FactoryGirl.define do |f|
    factory :user do |f|
    f.sequence(:email) {|n| "user#{n}@example.com"}
    f.password 'test1234'
    f.password_reset_token 'something'
    end
end
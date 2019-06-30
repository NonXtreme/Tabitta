FactoryBot.define do
  factory :tweet do
    content {"Hello World"}
    retweet_id {nil}
    reply_id {nil}
  end
end

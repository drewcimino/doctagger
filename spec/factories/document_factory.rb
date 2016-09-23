FactoryGirl.define do
  factory :document do
    provided_tags 'README, Active Record, layer'
    content 'Sample README Content? Active Record has more than one layer. Some other words.'
  end
end

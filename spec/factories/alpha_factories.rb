FactoryGirl.define do
  factory :community do
    sequence(:name) { |n| "community#{n}" }
    abbreviation  ''
    description   ''
    website       ''
    slug          ''
    active        true
    privacy       100
    status        0
    verified      false
  end

  factory :game do
    sequence(:name) { |n| "game#{n}" }
    slug          ''
    abbreviation  ''
    active        true
  end

  factory :gamer do
    user_id               { SecureRandom.uuid }
    username              ''
    description           ''
    slug                  ''
    dedication            0
    weekday_availability  0
    weekend_availability  0
    swearing              0
    swearing_tolerance    0
    first_name            ''
    middle_name           ''
    last_name             ''
    birth_date            { Date.today }
    sex                   0
    age                   1
    active                true
    privacy               100
    verified              false
  end

  factory :identity do
    user_id { SecureRandom.uuid }
    sequence(:uid) { |n| "UID-#{n}" }
    sequence(:provider) { |n| "P-#{n}" }
  end

  factory :membership do
    type          1
    community_id  { SecureRandom.uuid }
    team_id       { SecureRandom.uuid }
    gamer_id      { SecureRandom.uuid }
    role_id       { SecureRandom.uuid }
    active        true
    privacy       100
    status        0
  end

  factory :role do
    sequence(:name) { |n| "Role#{n}" }
    slug          ''
    abbreviation  ''
    active        true
  end

  factory :team do
    name          ''
    abbreviation  ''
    description   ''
    slug          ''
    active        true
    privacy       100
    status        0
    verified      false
  end

  factory :user do
    active                  true
    is_core                 true
    locale                  'en'
    time_zone               ''
    sequence(:email) { |n| "email#{n}@example.com" }
    password                'qwerty'
    # encrypted_password      ''
    reset_password_token    ''
    # reset_password_sent_at  { Date.today }
    # remember_created_at     { Date.today }
    # sign_in_count           1
    # current_sign_in_at      { Date.today }
    # last_sign_in_at         { Date.today }
    # current_sign_in_ip      ''
    # last_sign_in_ip         ''
    # confirmation_token      ''
    confirmed_at            { Date.today }
    # confirmation_sent_at    { Date.today }
    # unconfirmed_email       ''
    # failed_attempts         1
    # unlock_token            ''
    # locked_at               { Date.today }
  end
end

nonprofits_list = {
    "Charity Water" => {
      :year_completed => 1901
    },
    "American Red Cross" => {
      :year_completed => 1995
    },
    "Do Something" => {
      :year_completed => 2014
    },
    "Doctors Without Borders" => {
      :year_completed => 1058
    },
    "Livestrong" => {
      :year_completed => 2015
    },
    "American Cancer Society" => {
      :year_completed => 1951
    },
    "Human Rights Watch (HRW)" => {
      :year_completed => 1964
    },
    "United Nations Children's Fund (UNICEF)" => {
      :year_completed => 1902
    },
    "Samaritan's Purse" => {
      :year_completed => 1883
    }
  }

nonprofits_list.each do |name, nonprofit_hash|
  n = Nonprofit.new
  n.name = name
  nonprofit_hash.each do |attribute, value|
      n[attribute] = value
  end
  n.save
end
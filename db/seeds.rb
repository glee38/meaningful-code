nonprofits_list = {
    "Charity: Water" => {
      :cause => "It’s hard not to think about water today. In the western world, we face growing concerns about our stewardship of the world’s most precious resource. There’s talk of shortages, evidence of reservoirs and aquifers drying up, and of course, plenty of people who simply don’t care.

        But forget about us.

        Most of us have never really been thirsty. We’ve never had to leave our houses and walk five miles to fetch water. We simply turn on the tap, and water comes out. Clean. Yet there are 663 million people on the planet who don’t have clean water.

        That’s a huge number. In fact, it’s twice the number of people who live in the United States. 1 in 10 people in our world doesn’t have access to the most basic of human needs. Something we can’t imagine going 12 hours without.

        Here, we’d like to introduce you to a few of those 663 million. They are very real, and they need our help. They didn’t choose to be born into a village where the only source of water is a polluted swamp. And we didn’t choose to be born in a country where even the homeless have access to clean water and a toilet.

        We invite you to put yourself in their shoes. Follow them on their daily journey. Carry 80 pounds of water in yellow fuel cans. Dig with their children in sand for water. Line up at a well and wait eight hours for a turn.

        Now, make a decision to help. We’re not offering grand solutions and billion dollar schemes, but instead, simple things that work. Things like freshwater wells, rainwater catchments and sand filters. For about $30 a person, we know how to help millions.",

      :tagline => "Bringing clean, safe drinking water to people in developing nations",
      :website => "https://my.charitywater.org/donate/home"
      :username => "charitywater"
      :password_digest => "charitywater"
      :email => "charitywater@charitywater.com"
    },
    "American Red Cross" => {
      :cause =>
      :tagline =>
      :website =>
      :username =>
      :password_digest =>
      :email =>
    },
    "Do Something" => {
      :cause =>
      :tagline =>
      :website =>
      :username =>
      :password_digest =>
      :email =>
    },
    "Doctors Without Borders" => {
      :cause =>
      :tagline =>
      :website =>
      :username =>
      :password_digest =>
      :email =>
    },
    "Livestrong" => {
      :cause =>
      :tagline =>
      :website =>
      :username =>
      :password_digest =>
      :email =>
    },
    "American Cancer Society" => {
      :cause =>
      :tagline =>
      :website =>
      :username =>
      :password_digest =>
      :email =>
    },
    "Human Rights Watch (HRW)" => {
      :cause =>
      :tagline =>
      :website =>
      :username =>
      :password_digest =>
      :email =>
    },
    "United Nations Children's Fund (UNICEF)" => {
      :cause =>
      :tagline =>
      :website =>
      :username =>
      :password_digest =>
      :email =>
    },
    "Samaritan's Purse" => {
      :cause =>
      :tagline =>
      :website =>
      :username =>
      :password_digest =>
      :email =>
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
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
      :website => "https://my.charitywater.org/donate/home",
      :username => "charitywater",
      :password_digest => Nonprofit.digest('charitywater'),
      :email => "charitywater@charitywater.com"
    },
    "American Red Cross" => {
      :cause => "The American Red Cross exists to provide compassionate care to those in need. Our network of generous donors, volunteers and employees share a mission of preventing and relieving suffering, here at home and around the world, through five key service areas: Disaster Relief, Supporting America’s Military Families, Lifesaving Blood, Health and Safety Services, and International Services.",
      :tagline => "Make a Difference & Help People Affected By Disasters Big & Small.",
      :website => "http://www.redcross.org/",
      :username => "americanredcross",
      :password_digest => Nonprofit.digest('americanredcross'),
      :email => "americanredcross@redcross.org"
    },
    "Do Something" => {
      :cause => "One of the largest global orgs for young people and social change, our 5.2 million members in 130 countries tackle volunteer campaigns that impact every cause. Poverty. Discrimination. The environment. And everything else. Our promise: Any cause, anytime, anywhere.",
      :tagline => "We make the world suck less.",
      :website => "https://www.dosomething.org/us",
      :username => "dosomething",
      :password_digest => Nonprofit.digest('dosomething'),
      :email => "dosomething@dosomething.org"
    },
    "Doctors Without Borders" => {
      :cause => "We are Doctors Without Borders/Médecins Sans Frontières (MSF). We help people worldwide where the need is greatest, delivering emergency medical aid to people affected by conflict, epidemics, disasters, or exclusion from health care.",
      :tagline => "Medical aid where it is needed most. Independent. Neutral. Impartial.",
      :website => "http://www.doctorswithoutborders.org/",
      :username => "doctorswithoutborders",
      :password_digest => Nonprofit.digest('doctorswithoutborders'),
      :email => "doctorswithoutborders@dwob.org"
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

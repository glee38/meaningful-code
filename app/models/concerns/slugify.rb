module Slugify  
  def slug
    self.username.downcase.strip.gsub(" ", "-")
  end

  def find_by_slug(slug)
    self.all.find {|obj| obj.slug == slug}
  end
end
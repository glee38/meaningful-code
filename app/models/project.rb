class Project < ActiveRecord::Base
  validates_presence_of :name, :project_specs, :due_date
  
  belongs_to :nonprofit
  has_many :developer_projects
  has_many :developers, through: :developer_projects

  def slug
    self.name.downcase.strip.gsub(" ", "-")
  end

  def self.find_by_slug(slug)
    self.all.find {|obj| obj.slug == slug}
  end
end
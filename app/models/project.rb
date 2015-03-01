class Project < ActiveRecord::Base

  # Validations
  extend UrlValidator

  validates :name,
    presence: true,
    length: {:minimum => 2, :maximum => 250 }

  validates :description,
    length: {:minimum => 3, :maximum => 2050 },
    unless: proc {|project| project.description.blank?}

  validate_url :pretty_url

  # Callbacks
  before_validation :format_pretty_url, unless: proc {|project| project.pretty_url.blank?}

  # Associations
  belongs_to :client
  has_many :project_links, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :users, through: :roles
  has_one :logo, as: :imageable, dependent: :destroy, class_name: "Image::ProjectLogo"

  # return an active record relation object with the search query in its where clause
  # Return the ActiveRecord::Relation object
  # == Examples
  #   >>> project.search(query)
  #   => ActiveRecord::Relation object
  scope :search, lambda {|query| where("LOWER(projects.name) LIKE LOWER('%#{query}%') OR LOWER(projects.description) LIKE LOWER('%#{query}%')")}

  # * Adds a member to the project team
  # == Examples
  #   >>> project.add_role(user, "Scrum Master")
  #   => Returns Role Object
  def add_role(user, role_name)
    role = Role.new(name: role_name, user: user)
    self.roles << role
    return role
  end

  # * Remove a role
  # == Examples
  #   >>> project.remove_role(role)
  #   => Returns nil
  def remove_role(role)
    self.roles.destroy(role)
  end

  # * Adds a project link
  # == Examples
  #   >>> project.add_link(@link_type, "http://www.google.com", true)
  #   => Returns Project Link Object
  def add_link(link_type, url, under_construction=false)
    link = ProjectLink.new(url: url, under_construction: under_construction, project: self, link_type: link_type)
    self.project_links << link
    return link
  end

  # * Remove a project link
  # == Examples
  #   >>> project.remove_link(project_link)
  #   => Returns nil
  def remove_link(project_link)
    self.project_links.destroy(project_link)
  end

  def format_pretty_url
    self.pretty_url = "http://" + pretty_url if pretty_url && !pretty_url.start_with?("http")
  end
end

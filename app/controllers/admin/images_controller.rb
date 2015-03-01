class Admin::ImagesController < Poodle::ImagesController
  before_filter :require_admin
end

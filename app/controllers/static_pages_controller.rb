class StaticPagesController < ApplicationController
  def index
    redirec_to authors_root_path
  end
end

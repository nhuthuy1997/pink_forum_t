class StaticPagesController < ApplicationController
  def index
    redirect_to authors_root_path
  end
end

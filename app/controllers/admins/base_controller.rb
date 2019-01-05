module Admins
  class BaseController < ApplicationController
    def search users
      users.search(params[:search]).page(params[:page] || 1).per(Settings.page.per_page)
    end
  end
end

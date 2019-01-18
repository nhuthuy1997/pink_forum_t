module Admins
  class ImagesController < BaseController
    def create
      @media = uploader params

      if @media.save!
        respond_to do |format|
          format.json{ render json: @media }
          format.js
        end
      else 
        respond_to do |format|
          format.json{ render json: {error: 'Failed to process' }}
        end
      end
    end
  end
end

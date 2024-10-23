class UrlsController < ApplicationController
    before_action :set_url, only: [:show, :update, :destroy, :stats]
  
    def create
        @url = Url.new(url_params)
        
        if @url.save
          render json: { short_url: @url.short_code }, status: :created
        else
          render json: { errors: @url.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
  
      def show
        @url.increment!(:access_count)
        redirect_to @url.original_url, status: :moved_permanently
      end
  
      def update
        if @url.update(url_params)
          render json: @url, status: :ok
        else
          render json: { errors: @url.errors.full_messages }, status: :unprocessable_entity
        end
      end
      
  
    def destroy
      @url.destroy
      head :no_content
    end
  
    def stats
      render json: { access_count: @url.access_count }, status: :ok
    end
  
    private
  
    def set_url
        @url = Url.find_by!(short_code: params[:short_code])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Short URL not found' }, status: :not_found
      end
  
    def url_params
        { original_url: params[:url] }
      end
  end
  
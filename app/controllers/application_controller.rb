class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, :with => :render_404

  def render_404
    respond_to do |format|
      format.json do
        render json: {}, status: :not_found
      end

      format.html do
        render file: "public/404.html", status: :not_found
      end
    end
  end
end

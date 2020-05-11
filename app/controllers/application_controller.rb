# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :cache_buster
  rescue_from ActionController::InvalidAuthenticityToken, with: :redirect_to_root

  def status(code)
    respond_to do |format|
      format.html { render template: 'errors/generic', layout: false, status: code }
    end
  end

  def redirect_to_root
    redirect_to('/')
  end

  def cache_buster
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Pragma'] = 'no-cache'
    response.headers['Expires'] = 'Fri, 31 Dec 1999 00:00:00 GMT'
  end
end

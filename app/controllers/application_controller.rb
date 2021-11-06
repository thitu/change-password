# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :no_caching

  rescue_from ActionController::InvalidAuthenticityToken, with: :redirect_to_root

  def error_status(code)
    reset_cookies

    respond_to do |format|
      format.html { render(template: 'errors/generic', layout: false, status: code) }
    end
  end

  def reset_cookies
    %i[email_address state nonce checksum].each do |x|
      cookies.delete(x)
    end
  end

  def redirect_to_root
    redirect_to('/')
  end

  def no_caching
    response.headers['Cache-Control'] = 'no-cache, no-store, max-age=0, must-revalidate'
    response.headers['Expires'] = 'Fri, 31 Dec 1999 00:00:00 GMT'
    response.headers['Pragma'] = 'no-cache'
  end
end

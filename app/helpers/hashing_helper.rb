# frozen_string_literal: true

module HashingHelper
  def checksum(arr)
    Digest::SHA2.hexdigest(arr.join('|'))
  end

  def current_salt
    CURRENT_SALT
  end
end

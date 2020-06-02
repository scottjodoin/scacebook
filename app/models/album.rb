class Album < ApplicationRecord
  #:title
  #:description
  has_many :pictures
end

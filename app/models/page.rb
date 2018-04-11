class Page < ApplicationRecord
  belongs_to :book
  include ImageUploader::Attachment.new(:image)
end

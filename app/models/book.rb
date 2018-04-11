class Book < ApplicationRecord
  include ImageUploader::Attachment.new(:pdf)
  
end

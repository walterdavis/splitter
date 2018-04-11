class Book < ApplicationRecord
  has_many :pages, dependent: :destroy
  include ImageUploader::Attachment.new(:pdf)
  
  after_save :burst_pages

  private
    
  def burst_pages
    return unless saved_change_to_pdf_data?
    temp = pdf.download.path
    FileUtils.mkdir_p('tmp/pages')
    if temp
      self.page_ids = []
      all = Magick::Image.read(temp)
      all.each_with_index do |img, idx|
        all[idx].write("tmp/pages/#{id}_#{idx}.png")
        pg = File.open("tmp/pages/#{id}_#{idx}.png")
        page = self.pages.build image: pg
        page.save
        File.delete pg
      end
    end
  end
end

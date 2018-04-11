class ImageUploader < Shrine
  # plugins and uploading logic
  
  plugin :versions
  plugin :processing
  
  process(:store) do |io, context|
    original = io.download
    image = MiniMagick::Image.new(original.path)
    versions = []
    
    image.pages.each_with_index do |page, idx|
      page_file = Tempfile.new(["book-#{context[:record].id}-page-#{idx}-", '.jpg'], binmode: true)
      MiniMagick::Tool::Convert.new do |convert|
        convert << page.path
        convert << '-density' << '180'
        convert << '-quality' << '75'
        convert << '-flatten'
        convert << page_file.path
        Rails.logger.info convert.args.join(' ')
      end
      page_file.open
      versions << page_file
    end
    versions
  end
  
end
class ImageUploader < Shrine
  # plugins and uploading logic
  
  plugin :versions
  plugin :processing
  
  process(:store) do |io, context|
    original = io.download
    image = MiniMagick::Image.new(original.path)
    versions = []
    
    image.pages.each_with_index do |page, idx|
      page_file = Tempfile.new(["versions-#{idx}", '.jpg'], binmode: true)
      MiniMagick::Tool::Convert.new do |convert|
        convert << page.path
        convert << '-density' << '180'
        convert << page_file.path
      end
      page_file.open
      versions << page_file
    end
    versions
  end
  
end
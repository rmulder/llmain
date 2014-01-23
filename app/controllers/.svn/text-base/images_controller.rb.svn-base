class ImagesController < ApplicationController

  require 'RMagick'
  require 'open-uri'
  require 'digest/md5'

  URL_PATH = "/images/tmp"
  TEMP_FILE_PATH = File.join("#{::Rails.root.to_s}/public", URL_PATH)

  layout 'avatar_editor'

  def image_upload

    upload = params[:upload]

    name =  sanitize_filename upload['datafile'].original_filename
    path = File.join(TEMP_FILE_PATH,name)
    logger.debug "path=#{path}"
    File.open(path, "wb") { |f| f.write(upload['datafile'].read) }

    @business_id= params['id']

    original_image = Magick::Image.read(path).first
    logger.debug "image rows = #{original_image.rows}"
    @image = composite(original_image, "uploaded image", @business_id)

    redirect_to crop_images_url(:id=>@business_id, :image=>File.join(URL_PATH,@image) )
  end

  def image_download
    @image = params['image']
    if @image['?q=tbn'] && @image[':http://']
      idx = @image.index(':http://') + 1
      @image = @image[idx, @image.length-idx]
    end
    @business_id = params['id']

    logger.info "-->Preparing to pull image from external website: url=#{@image} business_id=#{@business_id}"

    # grab image from website
    original_image = Magick::Image.from_blob(open(@image).read).first

    # pad the image with transparent stuff
    @image = composite(original_image, @image, @business_id)
    redirect_to crop_images_url(:id=>@business_id, :image=>File.join(URL_PATH, @image) )
  end

  def crop
    @image = params['image']
    @business_id = params["id"]
  end

  def save
    @image = params['image_name']
    @business_id = params["business_id"]
    @x = Integer(params["x1"])
    @y = Integer(params["y1"])
    @width = Integer(params["width"])
    @height = Integer(params["height"])
    @file_name = Digest::MD5.hexdigest(@business_id)

    # crop the image
    composited_image = Magick::Image.read(File.join("#{RAILS_ROOT}/public", @image))[0]
    #composited_image.alpha(Magick::DeactivateAlphaChannel)

    composited_image.crop!(@x, @y, @width, @height)
    composited_image.write("#{AppConf.image_file_path}#{AppConf.image_path_originalcrop}#{@file_name}.png")
    File.chmod(0666, "#{AppConf.image_file_path}#{AppConf.image_path_originalcrop}#{@file_name}.png")

    resized = composited_image.resize(50, 50)
    resized.write("#{AppConf.image_file_path}#{AppConf.image_path_square50}#{@file_name}.png")
    File.chmod(0666, "#{AppConf.image_file_path}#{AppConf.image_path_square50}#{@file_name}.png")

    resized = composited_image.resize(100, 100)
    resized.write("#{AppConf.image_file_path}#{AppConf.image_path_square100}#{@file_name}.png")
    File.chmod(0666, "#{AppConf.image_file_path}#{AppConf.image_path_square100}#{@file_name}.png")

    resized = composited_image.resize(200, 200)
    resized.write("#{AppConf.image_file_path}#{AppConf.image_path_square200}#{@file_name}.png")
    File.chmod(0666, "#{AppConf.image_file_path}#{AppConf.image_path_square200}#{@file_name}.png")

    @cropped_image = "#{AppConf.image_server}#{AppConf.image_url}#{AppConf.image_path_square100}#{@file_name}.png"

    #update the business record
    business = Business.find @business_id
    business.default_image_file_path = "#{@file_name}.png"
    business.save
    logger.error "-->Wrote cropped file to #{AppConf.image_file_path}.../#{@file_name}.png"

  end

  private

  def sanitize_filename(file_name)
    just_filename = File.basename(file_name)
    just_filename.sub(/[^\w\.\-]/, '_')
  end

  def composite(original_image, image_name, business_id)
    max_dimension = [original_image.rows, original_image.columns].max + 20
    logger.info "-->Generating composite, size (x,y)= #{max_dimension}, #{max_dimension}"
    dst = Magick::Image.new(max_dimension, max_dimension) {self.background_color='transparent'}
    result = dst.composite(original_image, Magick::CenterGravity, Magick::OverCompositeOp)
    @image = Digest::MD5.hexdigest("#{image_name}_#{business_id}").to_s + ".png"
    out_file_name = File.join(TEMP_FILE_PATH, @image)
    result.write(out_file_name)
    logger.info "-->wrote composited image as <#{out_file_name}>"
    @image
  end

end

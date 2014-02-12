module Exo::Admin
  class CkeditorAssetsController < Exo::AdminController
    skip_before_filter :verify_authenticity_token
    before_filter :expose_ckeditor_stuff

    MODEL = Exo::Asset

    layout false

    expose(:ckeditor_function_num) { params[:CKEditorFuncNum] }
    expose(:asset) do
      MODEL.new.tap do |a|
        a.site = exo_site
        a.content = params[:upload]
      end
    end

    def create
      unless asset.save
        puts asset.inspect
      end
    end

    protected
    def expose_ckeditor_stuff
      ckeditor_function_num
    end
  end
end

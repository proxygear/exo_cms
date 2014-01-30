module Exo::Admin
  class PagesController < ::Exo::Admin::ApplicationController
    REMOVAL_REGEXP = /\Ahttps?:\/\/([a-z0-9.-:]+)\//i
    expose(:mercury_path) do
      File.join '/', params[:url].gsub(REMOVAL_REGEXP, '')
    end
    expose(:current_page) { current_site.routes.find_by path: mercury_path }

    def mercury_update
      params[:content].each do |slug, mercure|
        block = current_page.blocks.where(slug: slug).first
        block = Exo::Block.new unless block
        block.slug = slug
        block.content = mercure[:value]
        block.block_type = mercure[:type]
        block.data = mercure[:data]
        block.page = current_page unless block.page
        block.save!
      end
      render text: '', status: 200
    end
  end
end

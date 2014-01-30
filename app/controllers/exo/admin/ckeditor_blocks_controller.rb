module Exo::Admin
  class CkeditorBlocksController < ApplicationController
    expose(:targeted_page) do
      _route = nil
      Exo::PathMatcher.route_for(current_site.routes, params) do |route|
        _route = Exo::RoutePresenter.new route
      end
      _route
    end

    def update
      params[:blocks].each do |block_id, inner_html|
        block = targeted_page.blocks.where(slug_id: block_id).first
        block = Exo::Block.new unless block
        block.slug_id = block_id
        block.content = inner_html
        block.page = targeted_page.route unless block.page
        block.save!
      end
      render text: '', status: 200
    end
  end
end
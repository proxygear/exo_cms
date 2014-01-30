module Exo::BlockHelper
  def exo_block_tag id, options=nil, &default_content
    options ||= {}
    options['contenteditable'] = "true" if params[:preview]
    options[:id] = id
    options[:class] = "#{options[:class]} _block"
    block = tick.route.block id

    if block
      content_tag 'div', options do
        raw block.content
      end
    elsif default_content
      content_tag 'div', options, &default_content
    else
      content_tag 'div', options do
        "Lorem ipsum"
      end
    end
  end
end
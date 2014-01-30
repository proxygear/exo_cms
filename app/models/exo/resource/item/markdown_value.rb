class Exo
  class Resource::Item
    class MarkdownValue < AbstractValue
      SPLIT = '---PREVIEW---'

      field :html_value
      field :intro_html_value
      field :raw_value
      
      def value_update value
        self.raw_value = value
        intro, content = self.raw_value.split(SPLIT)
        if content
          self.intro_html_value = markdown_to_html intro
          self.html_value = markdown_to_html content
        else
          self.intro_html_value = ''
          self.html_value = markdown_to_html self.raw_value
        end
      end
      
      def value
        self.intro_html_value + "<hr/>" + self.html_value #FIXME
      end

      def form_value
        raw_value
      end

      protected
      class HTMLwithPygments < Redcarpet::Render::HTML
        def block_code(code, language)
          Pygments.highlight(code, lexer: language) #, options: {linenos: true}
        end
      end

      def markdown_to_html md
        options = {
          hard_wrap: true,
          filter_html: true,
          autolink: true,
          no_intraemphasis: true,
          fenced_code: true,
          fenced_code_blocks: true,
          gh_blockcode: true
        }
        renderer = HTMLwithPygments.new(:hard_wrap => true)
        Redcarpet::Markdown.new(renderer, options).render md.to_s
      end
    end
  end
end
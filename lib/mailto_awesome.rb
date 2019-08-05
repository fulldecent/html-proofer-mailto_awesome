require "html/proofer/mailto_awesome/version"

module Html
  module Proofer
    module MailtoAwesome
      class Error < StandardError; end
      class MailToAwesome < ::HTMLProofer::Check
        def mailto?
          return false if @link.ignore? || @link.href.nil?
          @link.href.match /^mailto:/i
        end
      
        def awesome?
          @link.href.downcase.include? 'subject=' and @link.href.downcase.include? 'body='
        end
      
        def run
          return unless @options[:check_mailto_awesome]
          @html.css('a').each do |node|
            @link = create_element(node)
            line = node.line
            content = node.to_s
      
            if mailto? && !awesome?
              add_issue("This is a not-awesome mailto link!", line: line, content: content)
            end
          end
        end
      end      
    end
  end
end

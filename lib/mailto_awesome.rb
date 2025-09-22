# frozen_string_literal: true

require "html/proofer/mailto_awesome/version"

module HTMLProofer
  class Check
    class MailtoAwesome < HTMLProofer::Check
      def mailto?
        return false if @link.ignore? || @link.href.nil?
        @link.href.match(/^mailto:/i)
      end
    
      def awesome?
        @link.href.downcase.include?('subject=') && @link.href.downcase.include?('body=')
      end
    
      def run
        # Check if the mailto awesome check is enabled via runner options
        return unless @runner && @runner.instance_variable_get('@options')&.fetch(:check_mailto_awesome, false)
        
        @html.css('a').each do |node|
          @link = create_element(node)
    
          if mailto? && !awesome?
            add_failure("This is a not-awesome mailto link!", element: @link)
          end
        end
      end
    end
  end
end

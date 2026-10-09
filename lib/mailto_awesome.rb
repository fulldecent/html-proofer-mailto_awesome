# frozen_string_literal: true

require "html/proofer/mailto_awesome/version"
# Ruby 4.0 removed logger from the default gems. html-proofer still loads it.
# https://stdgems.org/libraries/logger/
require "logger"
require "html-proofer"
require "uri"

module HTMLProofer
  class Check
    # Reports mailto links that omit the header fields a recipient asked for.
    # Header field names follow RFC 6068: hfname is case-insensitive.
    # https://www.rfc-editor.org/rfc/rfc6068#section-2
    class MailtoAwesome < HTMLProofer::Check
      DEFAULT_REQUIRED_PARAMETERS = ["subject", "body"].freeze

      # WHATWG URL parsing removes leading and trailing C0 controls and spaces
      # before it reads the scheme. " mailto:support@example.com" is a mailto link.
      # https://url.spec.whatwg.org/#url-parsing
      LEADING_OR_TRAILING_URL_SPACE = /\A[\x00-\x1F ]+|[\x00-\x1F ]+\z/

      def run
        @html.css("a").each do |node|
          @link = create_element(node)
          next if @link.ignore?

          href = node["href"]
          next unless href.is_a?(String)

          href = href.gsub(LEADING_OR_TRAILING_URL_SPACE, "")
          next unless href.match?(/\Amailto:/i)

          begin
            names = header_names(href)
          rescue URI::InvalidURIError
            add_failure("mailto: link is malformed and could not be parsed.", element: @link)
            next
          end

          missing = required_parameters.reject { |name| names.include?(name) }
          next if missing.empty?

          add_failure("mailto: link is missing required parameters: #{missing.join(", ")}", element: @link)
        end
      end

      private

      def required_parameters
        configured = @runner.options[:mailto_awesome]
        names = configured[:required_parameters] || configured["required_parameters"] if configured.is_a?(Hash)
        names = DEFAULT_REQUIRED_PARAMETERS if names.nil?
        Array(names).map { |name| name.to_s.downcase }
      end

      def header_names(href)
        # Nokogiri has already decoded &amp;. A caller that passes the source
        # text still has the entity, which RFC 6068 requires in HTML.
        semantic = href.gsub("&amp;", "&").gsub("&lt;", "<").gsub("&gt;", ">")
        uri = URI.parse(semantic)
        raise URI::InvalidURIError, semantic unless uri.is_a?(URI::MailTo)

        Array(uri.headers).map { |name, _value| name.to_s.downcase }
      end
    end
  end
end

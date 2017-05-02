class MailtoAwesome < ::HTMLProofer::Check
  def mailto?
    return false if @link.ignore? || @link.href.nil?
    @link.href.match /mailto/
  end

  def awesome?
    @link.href.include? 'subject' and @link.href.include? 'body'
  end

  def run
    @html.css('a').each do |node|
      @link = create_element(node)
      line = node.line
      content = node.to_s

      if mailto? && !awesome?
        add_issue("This is a not-awesome mailto link!", line: line, content: content)
      end
    end
  end
  endclass MailtoAwesome
end
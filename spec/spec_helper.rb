require "bundler/setup"
require "html-proofer-mailto_awesome"
require "stringio"
require "tmpdir"

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def check_html(html, options = {})
  proofer = nil
  Dir.mktmpdir do |dir|
    path = File.join(dir, "page.html")
    File.write(path, html)
    proofer = HTMLProofer.check_file(path, {
      checks: ["MailtoAwesome"],
      log_level: :error,
    }.merge(options))
    # html-proofer prints the failures and then calls exit(1).
    begin
      capture_output { proofer.run }
    rescue SystemExit
    end
  end
  proofer
end

def capture_output
  original_stdout = $stdout
  original_stderr = $stderr
  $stdout = StringIO.new
  $stderr = StringIO.new
  yield
ensure
  $stdout = original_stdout
  $stderr = original_stderr
end

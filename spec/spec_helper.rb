require 'bundler/setup'
require 'vcr'
require 'timecop'
require 'html-proofer'
require_relative '../lib/mailto_awesome'

FIXTURES_DIR = 'spec/fixtures'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def capture_stderr(*)
  original_stderr = $stderr
  original_stdout = $stdout
  $stderr = fake_err = StringIO.new
  $stdout = fake_out = StringIO.new unless ENV['VERBOSE']
  begin
    yield
  rescue RuntimeError, SystemExit
    # Catch both RuntimeError and SystemExit from HTMLProofer
  ensure
    $stderr = original_stderr
    $stdout = original_stdout unless ENV['VERBOSE']
  end
  fake_err.string
end

def make_proofer(item, type, opts)
  opts[:log_level] ||= :error
  
  # Add our custom check when the check_mailto_awesome option is enabled
  if opts[:check_mailto_awesome]
    opts[:checks] ||= ['Scripts', 'Links', 'Images']
    opts[:checks] << 'MailtoAwesome' unless opts[:checks].include?('MailtoAwesome')
  end
  
  case type
    when :file
      HTMLProofer.check_file(item, opts)
    when :directory
      HTMLProofer.check_directory(item, opts)
    when :directories
      HTMLProofer.check_directories(item, opts)
    when :links
      HTMLProofer.check_links(item, opts)
  end
end

def run_proofer(item, type, opts = {})
  proofer = make_proofer(item, type, opts)
  cassette_name = make_cassette_name(item, opts)
  VCR.use_cassette(cassette_name, :record => :new_episodes) do
    capture_stderr { proofer.run }
    proofer
  end
end

def make_cassette_name(file, opts)
  filename = if file.is_a? Array
               file.join('_')
             else
               file.split('/')[-2..-1].join('/')
             end
  (filename += opts.inspect) unless opts.empty?
  filename
end

VCR.configure do |config|
  config.cassette_library_dir = "#{FIXTURES_DIR}/vcr_cassettes"
  config.hook_into :typhoeus
end
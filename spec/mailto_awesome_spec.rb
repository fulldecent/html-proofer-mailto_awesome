require_relative 'spec_helper'

RSpec.describe ::MailtoAwesome do

  it 'accepts an awesome mailto link' do
    file = "#{FIXTURES_DIR}/mailto_awesome.html"
    proofer = run_proofer(file, :file, {:check_mailto_awesome => true})
    expect(proofer.failed_checks).to be_empty
  end

  it 'rejects a not-awesome mailto link' do
    file = "#{FIXTURES_DIR}/mailto_not_awesome.html"
    proofer = run_proofer(file, :file, {:check_mailto_awesome => true})
    expect(proofer.failed_checks).not_to be_empty
    expect(proofer.failed_checks.last.description).to match(%r{This is a not-awesome mailto link!})
  end
end

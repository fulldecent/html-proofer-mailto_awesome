require_relative 'spec_helper'

RSpec.describe ::MailtoAwesome do

  it 'Good mailto link' do
    file = "#{FIXTURES_DIR}/mailto_awesome.html"
    proofer = run_proofer(file, :file)
    expect(proofer.failed_tests.last).to eq nil
  end

  it 'Bad mailto link' do
    file = "#{FIXTURES_DIR}/mailto_not_awesome.html"
    proofer = run_proofer(file, :file)
    expect(proofer.failed_tests.last).to match(%r{This is a not-awesome mailto link!})
  end
end

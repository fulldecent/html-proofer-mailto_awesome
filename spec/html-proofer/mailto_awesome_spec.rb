require 'spec_helper'

describe 'Mailto awesome test' do
  it 'Good mailto link' do
    file = "#{FIXTURES_DIR}/links/mailto_awesome.html"
    proofer = run_proofer(file, :file, {:check_sri => true})
    expect(proofer.failed_tests).to eq []
  end

  it 'Bad mailto link' do
    file = "#{FIXTURES_DIR}/links/mailto_not_awesome.html"
    proofer = run_proofer(file, :file, {:check_sri => true})
    expect(proofer.failed_tests.first).to match(%r{This is a not-awesome mailto link})
  end

  it 'Empty mailto link' do
    file = "#{FIXTURES_DIR}/links/mailto_empty.html"
    proofer = run_proofer(file, :file, {:check_sri => true})
    expect(proofer.failed_tests.first).to match(%r{This is a not-awesome mailto link})
  end
end

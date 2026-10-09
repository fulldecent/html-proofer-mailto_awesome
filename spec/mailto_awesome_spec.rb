require_relative "spec_helper"

RSpec.describe HTMLProofer::Check::MailtoAwesome do
  def descriptions_for(html, options = {})
    check_html(html, options).failed_checks.map(&:description)
  end

  it "accepts the awesome fixture" do
    html = File.read("spec/fixtures/mailto_awesome.html")
    expect(descriptions_for(html)).to eq([])
  end

  it "reports the parameter the not-awesome fixture omits" do
    html = File.read("spec/fixtures/mailto_not_awesome.html")
    expect(descriptions_for(html)).to eq(["mailto: link is missing required parameters: body"])
  end

  it "reports every default parameter a bare mailto link omits" do
    html = '<a href="mailto:support@example.com">Email us</a>'
    expect(descriptions_for(html)).to eq(["mailto: link is missing required parameters: subject, body"])
  end

  it "reports a bare mailto link when spaces pad the href" do
    html = '<a href=" mailto:support@example.com ">Email us</a>'
    expect(descriptions_for(html)).to eq(["mailto: link is missing required parameters: subject, body"])
  end

  it "does not treat header-like text in the address as a header field" do
    html = '<a href="mailto:subject=trick@example.com">Email us</a>'
    expect(descriptions_for(html)).to eq(["mailto: link is missing required parameters: subject, body"])
  end

  it "treats header field names as case-insensitive" do
    html = '<a href="mailto:support@example.com?Subject=Hi&amp;Body=Hello">Email us</a>'
    expect(descriptions_for(html)).to eq([])
  end

  it "reports a mailto value that is not a URI" do
    html = '<a href="mailto:%">Email us</a>'
    expect(descriptions_for(html)).to eq(["mailto: link is malformed and could not be parsed."])
  end

  it "skips links html-proofer was told to ignore" do
    html = '<a href="mailto:support@example.com" data-proofer-ignore>Email us</a>'
    expect(descriptions_for(html)).to eq([])
  end

  it "ignores links that are not mailto links" do
    html = '<a href="https://example.com/contact">Contact</a>'
    expect(descriptions_for(html)).to eq([])
  end

  it "uses required_parameters when the caller sets them" do
    html = '<a href="mailto:support@example.com?cc=desk@example.com">Email us</a>'
    options = { mailto_awesome: { required_parameters: ["cc"] } }
    expect(descriptions_for(html, options)).to eq([])
  end
end

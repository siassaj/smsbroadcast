require 'spec_helper'

describe Smsbroadcast::Sms do

  before(:all) {
    Smsbroadcast.configure do |config|
      config.url      = "https://api.smsbroadcast.com.au"
      config.from     = "0411111111"
      config.delay    = 0
      config.maxsplit = 1
      config.username = "fakeuser"
      config.password = "fakepassword"
    end
  }

  after(:all) {
    Smsbroadcast.configure do |config|
      config.delay    = nil
      config.from     = nil
      config.maxsplit = nil
      config.url      = nil
    end
  }

  let(:ref)        { "123" }
  let(:recipient)  { "0499999999" }
  let(:recipients) { ["0499999999", "0488888888", "0477777777"] }
  let(:sender)     { "0411111111" }
  let(:message)    { "A good text message" }
  let(:maxsplit)   { "1" }
  let(:delay)      { "0" }
  let(:username)   { "fakeuser"}
  let(:password)   { "fakepassword"}
  let(:request_body) do
    {to: recipient,
     message: message,
     ref: ref,
     from: sender,
     maxsplit: maxsplit,
     delay: delay,
     username: username,
     password: password
    }
  end
  let(:stub) {
    stub_request(:post, "https://api.smsbroadcast.com.au/apiadv.php")
    .with(:body => request_body)
  }

  subject(:subject) {
    described_class.new(to: recipient,
                        message: message,
                        ref: ref)
  }

  describe "::new" do
    it "builds a new, unsent sms" do
      expect(subject).to_not be_nil
      expect(subject.from).to eq sender
    end
  end

  describe "#deliver" do
    it "makes a https request to smsbroadcast" do
      stub
      .to_return(body: "a response to post")

      subject.deliver

      expect(stub).to have_been_requested
    end

    it "delivers to many numbers" do
      subject = described_class.new(to: recipients,
                                    message: message,
                                    ref: ref)
      request_body[:to] = recipients.join(",")

      stub
      .with(body: request_body)
      .to_return(body: "a response to post")

      subject.deliver

      expect(stub).to have_been_requested
    end

    it "raises if recipients count > 1000" do
      recipients = 1.upto(1001)
      subject = described_class.new(to: recipients,
                                    message: message,
                                    ref: ref)

      expect{subject.deliver}.to raise_error Smsbroadcast::TooManyRecipientsError
    end

    it "returns an SmsResponse object" do
      stub
      .to_return(:status => 200, :body => "OK:61411111111:123")

      resp = subject.deliver

      expect(resp).to be_a_kind_of Smsbroadcast::SmsResponse
    end
  end
end

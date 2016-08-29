require 'spec_helper'

describe Smsbroadcast::Status do

  before(:all) {
    Smsbroadcast.configure do |config|
      config.url      = "https://api.smsbroadcast.com.au"
      config.username = "fakeuser"
      config.password = "fakepassword"
    end
  }

  after(:all) {
    Smsbroadcast.configure do |config|
      config.url      = nil
      config.username = nil
      config.password = nil
    end
  }

  let(:username)   { "fakeuser"}
  let(:password)   { "fakepassword"}
  let(:request_body) do
    {action: "balance",
     username: username,
     password: password}
  end

  let(:stub) {
    stub_request(:get, "https://api.smsbroadcast.com.au/api-adv.php")
    .with(:body => request_body)
  }

  subject(:subject) {
    described_class.new()
  }

  describe "#call" do
    it "returns balance on success" do
      stub
      .to_return(:status => 200, :body => "OK:5000")

      subject.call

      expect(subject.status).to eq :ok
      expect(subject.balance).to eq "5000"
    end

    it "returns excuse on error" do
      stub
      .to_return(:status => 200, :body => "ERROR:An excuse")

      subject.call

      expect(subject.status).to eq :error
      expect(subject.message).to eq "An excuse"
    end
  end
end

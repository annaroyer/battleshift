require "rails_helper"

RSpec.describe RegistrationMailer, type: :mailer do
  describe "activate" do
    let(:user) { create(:user) }
    let(:mail) { RegistrationMailer.activate(user) }

    before(:each) do
      allow_any_instance_of(User).to receive(:api_key).and_return("P5ThQc/y5nr34mDZWrU+FQ==")
    end

    it 'queues the email' do
      expect { mail.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end

    it "renders the headers" do
      expect(mail.subject).to eq("Activate Account")
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(["app92045074@heroku.com"])
    end

    it "renders the body" do
      text_body = File.read('spec/fixtures/registration_mailer/activate.txt')
      html_body = File.read('spec/fixtures/registration_mailer/activate.html')
      expect(mail.text_part.body.to_s.chomp).to match(text_body)
      expect(mail.html_part.body.to_s.gsub(/[[:space:]]/, '')).to match(html_body.gsub(/[[:space:]]/, ''))
    end
  end
end

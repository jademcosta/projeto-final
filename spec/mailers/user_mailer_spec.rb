require "spec_helper"

Mail.defaults do
    delivery_method :test # in practice you'd do this in spec_helper.rb
end

describe "sending an email" do
    include Mail::Matchers

    before(:each) do
        Mail::TestMailer.deliveries.clear

        Mail.deliver do
            to ['mikel@me.com', 'mike2@me.com']
            from 'you@you.com'
            subject 'testing'
            body 'hello'
        end
    end

    it { should have_sent_email } # passes if any email at all was sent

    it { should have_sent_email.from('you@you.com') }
    it { should have_sent_email.to('mikel@me.com') }

    it { should have_sent_email.with_subject('testing') }
    it { should have_sent_email.with_body('hello') }

    it { should have_sent_email.from('you@you.com').to('mikel@me.com').matching_body(/hell/) }

    pending "Fazer os testes de email aqui"
end

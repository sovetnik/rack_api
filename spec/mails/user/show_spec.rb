require_relative '../../spec_helper'

describe Mails::User::Show do
  subject { Mails::User::Show.new.call(req) }

  let(:req) { Rack::Request.new(params) }
  let(:params) { { 'PATH_INFO': "/user/#{uuid}" } }

  describe 'success' do
    let(:uuid) { Mails::User::Repo.insert email: email }
    let(:email) { 'name@mail.com' }

    before { uuid }

    it { expect(subject.success?).must_equal true }
    it { expect(subject).must_equal Success(id: uuid, email: email) }
  end

  describe 'uuid is not exist' do
    let(:uuid) { '7e7eeffe-b348-48dd-a402-f788d93bf8a5' }

    it { expect(subject.failure?).must_equal true }
    it { expect(subject).must_equal Failure(:not_found) }
  end
end

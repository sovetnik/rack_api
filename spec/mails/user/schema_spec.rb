require_relative '../../spec_helper'

describe Mails::User::Schema do
  subject { Mails::User::Schema.call(params) }

  let(:params) { { email: email } }
  let(:email) { 'name@mail.com' }

  describe 'success' do
    it { expect(subject.success?).must_equal true }
    it { expect(subject.output).must_equal email: email }
  end

  describe 'email is not unique' do
    before { Mails::User::Repo.insert(email: email) }
    it { expect(subject.success?).must_equal false }
    it { expect(subject.errors).must_equal email: ['must be unique'] }
  end

  describe 'email is not correct' do
    let(:email) { 'wrong_email' }
    it { expect(subject.success?).must_equal false }
    it { expect(subject.errors).must_equal email: ['must be a valid email address'] }
  end
end

require_relative '../../spec_helper'

describe Mails::User::List do
  subject { Mails::User::List.new.call(nil) }

  let(:email_one) { 'one@mail.com' }
  let(:email_two) { 'two@mail.com' }
  let(:uuid_one) { Mails::User::Repo.insert email: email_one }
  let(:uuid_two) { Mails::User::Repo.insert email: email_two }

  describe 'success' do
    before do
      uuid_one
      uuid_two
    end

    it { expect(subject.success?).must_equal true }
    it { expect(subject.value!).must_be_instance_of Array }
    it 'returns list of hashes' do
      expect(subject).must_equal Success(
        [
          { id: uuid_one, email: email_one },
          { id: uuid_two, email: email_two }
        ]
      )
    end
  end

  describe 'users is not existed' do
    it { expect(subject.failure?).must_equal true }
    it { expect(subject).must_equal Failure('Repo is empty') }
  end
end

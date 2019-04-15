require_relative '../spec_helper'

describe Mails::App, 'a Rack api app' do
  # subject { Mails::App.call(env) }

  let(:app) { Mails::App.new }

  let(:email_one) { 'one@mail.com' }
  let(:email_two) { 'two@mail.com' }
  let(:uuid_one) { Mails::User::Repo.insert email: email_one }
  let(:uuid_two) { Mails::User::Repo.insert email: email_two }

  describe 'POST /users create' do
    before { post '/users', "email": 'john@example.com' }
    it { expect(last_response).must_be_ok }

    describe 'email taken' do
      before { post '/users', "email": 'john@example.com' }
      it { expect(last_response).must_be_unprocessable_entity }
      it do
        expect(last_response.body)
          .must_equal '{"error":{"email":["must be unique"]}}'
      end
    end

    describe 'missing email' do
      before { post '/users' }
      it { expect(last_response).must_be_unprocessable_entity }
      it do
        expect(last_response.body)
          .must_equal '{"error":{"email":["is missing"]}}'
      end
    end

    describe 'wrong_email' do
      before { post '/users', "email": 'wrong_email' }
      it { expect(last_response).must_be_unprocessable_entity }
      it do
        expect(last_response.body)
          .must_equal '{"error":{"email":["must be a valid email address"]}}'
      end
    end
  end

  describe 'GET /users list' do
    before do
      uuid_one
      uuid_two
      get '/users', {}, {}
    end

    it { expect(last_response).must_be_ok }
  end

  describe 'GET /user/:id show' do
    before do
      uuid_one
      get "/user/#{uuid_one}"
    end
    it { expect(last_response).must_be_ok }
  end
end

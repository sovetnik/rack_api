require_relative '../spec_helper'
require 'dry/monads/result'
require_relative '../../lib/mails'

describe Mails::Router, 'a Rack api app' do
  include Dry::Monads::Result::Mixin

  subject { Mails::Router.new.call(req) }

  let(:req) { Rack::Request.new(headers) }

  describe 'POST /users' do
    let(:headers) { { 'REQUEST_METHOD' => 'POST', 'PATH_INFO' => '/users' } }
    it 'success with User::Create instance' do
      expect(subject.value!).must_be_instance_of Mails::User::Create
    end
  end

  describe 'GET /users' do
    let(:headers) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/users' } }
    it 'success with  User::List instance' do
      expect(subject.value!).must_be_instance_of Mails::User::List
    end
  end

  describe 'GET /user/:id' do
    let(:headers) do
      { 'REQUEST_METHOD' => 'GET',
        'PATH_INFO' => '/user/7e7eeffe-b348-48dd-a402-f788d93bf8a5' }
    end

    it 'success with User::Show instance' do
      expect(subject.value!).must_be_instance_of Mails::User::Show
    end
  end

  describe 'GET root' do
    let(:headers) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/' } }
    it 'failure with  no match found' do
      expect(subject.failure).must_equal 'not_found'
    end
  end
end

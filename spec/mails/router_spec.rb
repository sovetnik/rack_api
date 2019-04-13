require 'minitest/autorun'
require 'dry/monads/result'
require_relative '../../mails'

describe Mails::Router, 'a Rack api app' do
  include Dry::Monads::Result::Mixin
  subject { Mails::Router.new.call(verb, path) }

  describe 'POST /users' do
    let(:verb) { 'POST' }
    let(:path) { '/users' }
    it 'success with User::Create instance' do
      expect(subject.value!).must_be_instance_of Mails::User::Create
    end
  end

  describe 'GET /users' do
    let(:verb) { 'GET' }
    let(:path) { '/users' }
    it 'success with  User::List instance' do
      expect(subject.value!).must_be_instance_of Mails::User::List
    end
  end

  describe 'GET /user/:id' do
    let(:verb) { 'GET' }
    let(:path) { '/user/xxx-yyy' }
    it 'success with User::Show instance' do
      expect(subject.value!).must_be_instance_of Mails::User::Show
    end
  end

  describe 'GET root' do
    let(:verb) { 'GET' }
    let(:path) { '/' }
    it 'failure with  no match found' do
      expect(subject.failure).must_equal :not_found
    end
  end
end

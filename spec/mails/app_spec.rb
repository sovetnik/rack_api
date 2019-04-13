require 'minitest/autorun'
require_relative '../../mails/app'

describe Mails::App, 'a Rack api app' do
  subject { Mails::App.call(env) }

  let(:status) { subject[0] }
  let(:body) { subject[2][0] }

  describe 'get to /hello' do
    let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/hello' } }

    it 'returns the status 200' do
      expect(status).must_equal 200
    end

    it 'returns the body' do
      expect(body).must_equal 'Hello world'
    end
  end

  describe '/users' do
    let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/users' } }
    it 'route request' do
      expect(body).must_equal :users
    end
  end
end

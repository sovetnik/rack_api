require 'minitest/autorun'
require_relative './mails'

describe Mails, 'a Rack api app' do
  describe 'get to /hello' do
    let(:app) { Mails }
    let(:env) { { 'REQUEST_METHOD' => 'GET', 'PATH_INFO' => '/hello' } }
    let(:response) { app.call(env) }
    let(:status) { response[0] }
    let(:body) { response[2][0] }

    it 'returns the status 200' do
      expect(status).must_equal 200
    end

    it 'returns the body' do
      expect(body).must_equal 'Hello world'
    end
  end
end

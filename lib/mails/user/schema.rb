require 'dry-validation'

module Mails::User
  Schema = Dry::Validation.Params do
    configure do
      config.messages_file = 'lib/mails/user/errors.yml'

      def email?(value)
        !/.*@.*/.match(value).nil?
      end

      def unique?(value)
        Repo.where(email: value).empty?
      end
    end

    required(:email).filled(:str?, :email?, :unique?)
  end
end

module Mails::User
  class Show < Base
    UUID_REGEXP = %r{^/user/([a-z0-9]{8}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{4}-[a-z0-9]{12})$}.freeze

    def call(request)
      fetch_uuid(request).bind do |uuid|
        Try(Sequel::DatabaseError) do
          Repo.first(id: uuid)
        end.bind do |user|
          return Success(user) if user
        end
      end
      Failure(:not_found)
    end

    def fetch_uuid(request)
      Maybe(
        request
        .env
        .transform_keys(&:to_sym)
        .fetch(:PATH_INFO)
      ).bind do |path|
        Maybe(path.match(UUID_REGEXP)[1])
      end
    end
  end
end

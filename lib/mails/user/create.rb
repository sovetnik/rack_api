module Mails::User
  class Create < Base
    def call(request, repo: Repo)
      validation = Schema.call(request.params)
      return Failure(validation.errors) if validation.failure?

      Success(repo.insert(validation.output))
    end
  end
end

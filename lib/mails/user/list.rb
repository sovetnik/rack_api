module Mails::User
  class List < Base
    def call(_request)
      Repo.any? ? Success(Repo.all) : Failure('Repo is empty')
    end
  end
end

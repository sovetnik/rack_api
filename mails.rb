class Mails
  def self.call(env)
    [200, {}, ['Hello world']]
  end
end

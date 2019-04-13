class Mails
  def self.call(_env)
    [200, {}, ['Hello World']]
  end
end

# eagerly initialized attribute

# before

class Employee

  def emails
    @emails ||= []
  end

  def voice_mails
    @voice_mails ||= []
  end

end

# after

class Employee
  def initialize(emails, voice_mails)
    @emails = []
    @voice_mails = []
  end
end


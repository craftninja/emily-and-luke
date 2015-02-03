class AdminMailer < ActionMailer::Base
  default from: 'emilyplatzer@example.com'

  def fail_find_invitee(fail_names)
    @fail_names = fail_names
    mail(to: 'emilyplatzer@gmail.com', subject: 'Someone is trying to be invited')
  end

end

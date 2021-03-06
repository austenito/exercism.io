class Notify
  def self.everyone(submission, regarding, options = {})
    except = Array(options[:except])
    cohort = Cohort.for(submission.user)
    users = cohort.sees(submission.exercise) + participants_in(submission) - except
    users.each do |to|
      SubmissionNotification.on(submission, to: to, regarding: regarding)
    end
  end

  def self.participants_in(submission)
    Participants.in(submission.user_exercise.submissions)
  end

  def self.about(note, options)
    data = {
      note: note,
      regarding: 'custom',
      user: options[:to]
    }
    Notification.create(data)
  end

  def self.source(submission, regarding)
    SubmissionNotification.on(submission, to: submission.user, regarding: regarding)
  end
end


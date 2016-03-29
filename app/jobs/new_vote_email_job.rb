class NewVoteEmailJob < ActiveJob::Base
  queue_as :email

  def perform(movie, email, name, vote_type, link)
    VotesMailer.new_vote(movie, email, name, vote_type, link)
  end
end

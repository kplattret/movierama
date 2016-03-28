# ==========================================================================
#   Corresponding email template on Mandrill
# ==========================================================================
#
# <p>Hello *|OWNER_NAME|*,</p>
#
# <p>Someone just *|VOTE_TYPE|* your movie <strong>'*|MOVIE_TITLE|*'</strong>.</p>
#
# <p>Check out your votes now: <a href="*|OWNER_URL|*">*|OWNER_URL|*</a></p>
#
# <p>Thanks, The MovieRama team</p>
#
# ==========================================================================

class VotesMailer < BaseMailer

  def new_vote(movie, email, name, vote_type, link)
    return if email.blank?

    template_name = "movierama-new-vote"
    message = {
      subject: "New vote for '#{movie}'",
      to: [
        {
          email: email,
          name: name.present? ? name : ""
        }
      ],
      global_merge_vars: [
        {
          name: "OWNER_NAME",
          content: name.present? ? name : "there"
        },
        {
          name: "VOTE_TYPE",
          content: "#{vote_type}d"
        },
        {
          name: "MOVIE_TITLE",
          content: movie
        },
        {
          name: "OWNER_URL",
          content: link
        }
      ]
    }

    mandrill_send_email(template_name, message)
  end

end

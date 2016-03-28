class VotesController < ApplicationController
  def create
    authorize! :vote, _movie

    _voter.vote(_type)
    # Arguments expected: movie, email, name, vote_type, link
    VotesMailer.new_vote(_movie.title, _movie.user.email, _movie.user.name, _type.to_s, user_movies_url(_movie.user))
    redirect_to root_path, notice: 'Vote cast'
  end

  def destroy
    authorize! :vote, _movie

    _voter.unvote
    redirect_to root_path, notice: 'Vote withdrawn'
  end

  private

  def _voter
    VotingBooth.new(current_user, _movie)
  end

  def _type
    case params.require(:t)
    when 'like' then :like
    when 'hate' then :hate
    else raise
    end
  end

  def _movie
    @_movie ||= Movie[params[:movie_id]]
  end
end

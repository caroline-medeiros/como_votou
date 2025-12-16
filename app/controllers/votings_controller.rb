class VotingsController < ApplicationController
  def index
    @votings = Voting.includes(:proposition).order(datetime: :desc).limit(20)

    render json: @votings.as_json(
      include: {
        proposition: { only: [ :title, :description ] }
      },
      except: [ :created_at, :updated_at ]
    )
  end

  def show
    @voting = Voting.includes(votes: { deputy: :party }).find_by("id = ? OR api_id = ?", params[:id], params[:api_id])

    if @voting
      render json: @voting.as_json(
        include: {
          proposition: { only: [ :title, :status ] },
          votes: {
            include: {
              deputy: {
                only: [ :name, :photo_url, :state ],
                include: { party: { only: [ :acronym ] } }
              }
            },
            only: [ :vote_type ]
          }
        }
      )
    else
      render json: { error: "Votação não encontrada" }, status: :not_found
    end
  end
end

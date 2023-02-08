class BranchesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    render json: Branch.all, 
           status: :ok,
           except: %i[created_at updated_at ]
  end
end

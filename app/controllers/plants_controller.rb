# class PlantsController < ApplicationController
#     # GET /plants
#   def index
#     plants = Plant.all
#     render json: plants
#   end

#   # GET /plants/:id
#   def show
#     plant = Plant.find_by(id: params[:id])
#     render json: plant
#   end

#   # POST /plants
#   def create
#     plant = Plant.create(plant_params)
#     render json: plant, status: :created
#   end

#   private

#   def plant_params
#     params.permit(:name, :image, :price)
#   end
# end

# BOTH METHODS WORKS

# STEP 1:add reponse if the plant is not found 
# STEP 2:define in private "render_reponse_not_found and find_plant"
# STEP 3:replace accodingly to find_plant and render_response_not_found
# STEP 4: add rescue ActiveRecord::RecordNotFound and run in postman it and watch
# STEP 5: add rescue ActiveRecord::RecordNotFound,with....at the top to wrap up and clear




class PlantsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    # GET /plants
  def index
    plants = Plant.all
    render json: plants
  end

  # GET /plants/:id
  def show
    plant = find_plant
    render json: plant
  end
  

  # POST /plants
  def create
    plant = Plant.create(plant_params)
    render json: plant, status: :created
  end

  private

  def plant_params
    params.permit(:name, :image, :price)
  end

  def render_not_found_response
    render json: { error: "Plant not found"}, status: :not_found
  end

  def find_plant
    plant = Plant.find_by!(id: params[:id]) 
  end

end



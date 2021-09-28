class RecipesController < ApplicationController

    def index
        if User.find_by(id: session[:user_id])
            recipes = Recipe.all
            render json: recipes
        else
            render json: {errors: ["Unauthorized"]}, status: 401
        end
    end

    def create
        user = User.find_by(id: session[:user_id])
        if user
            recipe = Recipe.new(recipe_params)
            user.recipes << recipe
            recipe.save!
            render json: recipe, status: 201
        else
            render json: {errors: ["Unauthorized"]}, status: 401
        end
    end

    private

    def recipe_params
        params.permit(:title,:instructions,:minutes_to_complete)
    end

end

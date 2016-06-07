class TvsController < ApplicationController
  before_action :logged_in_user, only: [:create]
  before_action :set_user, only: [:edit, :update]
  
  def show
    @tv = Tv.find(params[:id])
    @tvshows = @tv.tvshows.order(created_at: :asc)
    @tvshow = @tv.tvshows.build
    @user = @tv.user
  end

  def create
    @tv = current_user.tvs.build(tv_params)
    if @tv.save
      flash[:success] = "Tv created!"
      redirect_to current_user
    else
      flash[:danger] = "Tv didn't create!"
      render 'users/show'
    end
  end

  def destroy
    @tv = current_user.tvs.find_by(id: params[:id])
    return redirect_to user_url(params[:id]) if @tv.nil?
    @tv.destroy
    flash[:success] = "Tv deleted"
    redirect_to request.referrer || current_user
  end
  
  private
  def tv_params
    params.require(:tv).permit(:title, :introduction, :theme_color)
  end

  def set_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = "別のユーザーの編集はできません。"
      redirect_to @user
    end
  end
end

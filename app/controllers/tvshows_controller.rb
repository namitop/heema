class TvshowsController < ApplicationController
  before_action :logged_in_user, only: [:create]
 #  before_action :set_tv, only: [:create]
  before_action :set_user, only: [:edit, :update]

  def create
    #if !(current_user.tvshow.find?(params[:id]))
      @tvshow = @tv.tvshows.build(tvshow_params)
    #else
    #  flash[:danger] = "【遷移はテキトー】他のユーザーは作成できません。"
    #  render 'tops/index'
    #end
    
    if @tvshow.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      flash[:danger] = "Tvshow didn't create!"
      render 'tops/index'
    end
  end
  
  private
  def tvshow_params
    params.require(:tvshow).permit(:introduction, :video_url)
  end

#  def set_tv
#    @tv = Tvshow.find(params[:id]).tv
#  end

  def set_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = "別のユーザーの編集はできません。"
      redirect_to @user
    end
  end
end

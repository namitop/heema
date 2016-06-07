class TvshowsController < ApplicationController
  include ActionView::Helpers::OutputSafetyHelper
  before_action :logged_in_user, only: [:create]
 #  before_action :set_tv, only: [:create]
  before_action :set_user, only: [:edit, :update, :delete]

  def update
    @tvshow = Tvshow.find(tvshow_params[:front_tvshow_id])
    @tv = @tvshow.tv
    @tvshows = @tv.tvshows
#    @video_url = raw @tvshow.video_url
#    @video_url = raw "<iframe frameborder='0' width='480' height='270' src='//www.dailymotion.com/embed/video/x3w5fk7' allowfullscreen></iframe><br /><a href='http://www.dailymotion.com/video/x3w5fk7_%25E6%25A4%258E%25E5%2590%258D%25E6%259E%2597%25E6%25AA%258E-%25E4%25B8%25B8%25E3%2581%25AE%25E5%2586%2585%25E3%2582%25B5%25E3%2583%2587%25E3%2582%25A3%25E3%2582%25B9%25E3%2583%2586%25E3%2582%25A3%25E3%2583%2583%25E3%2582%25AF_music' target='_blank'>椎名林檎　「丸の内サディスティック」</a> <i>投稿者 <a href='http://www.dailymotion.com/poppo28282828' target='_blank'>poppo2828"
#    @video_url = "<iframe frameborder='0' width='480' height='270' src='//www.dailymotion.com/embed/video/x3w5fk7' allowfullscreen></iframe><br /><a href='http://www.dailymotion.com/video/x3w5fk7_%25E6%25A4%258E%25E5%2590%258D%25E6%259E%2597%25E6%25AA%258E-%25E4%25B8%25B8%25E3%2581%25AE%25E5%2586%2585%25E3%2582%25B5%25E3%2583%2587%25E3%2582%25A3%25E3%2582%25B9%25E3%2583%2586%25E3%2582%25A3%25E3%2583%2583%25E3%2582%25AF_music' target='_blank'>椎名林檎　「丸の内サディスティック」</a> <i>投稿者 <a href='http://www.dailymotion.com/poppo28282828' target='_blank'>poppo28282828</a></i>"
    @video_url = @tvshow.video_url.gsub(/\"/, "'")

     #binding.pry

    #redirect_to @tv
    render 'test'
  end

  def create
    @tv = Tv.find(tvshow_params[:tv_id])
    @tvshow = @tv.tvshows.build(tvshow_params)
    #  flash[:danger] = "【遷移はテキトー】他のユーザーは作成できません。"
    #  render 'tops/index'
    #end
    
    if @tvshow.save
      flash[:success] = "Tvshow created!"
      redirect_to @tv
    else
      flash[:danger] = "Tvshow didn't create!"
      render 'tvs/show'
    end
  end
  

  def destroy
    @tv = Tv.find(tvshow_params[:tv_id])
    @tvshow = @tv.tvshows.find_by(id: params[:id])
    if @tv.nil?
      flash[:success] = "Didn't Tvshow delete"
      return redirect_to @tv
    end
    @tvshow.destroy
    flash[:success] = "Tvshow deleted"
    redirect_to request.referrer || current_user
  end
  
  private
  def tvshow_params
    params.require(:tvshow).permit(:introduction, :video_url, :tv_id, :front_tvshow_id)
  end

#  def set_tv
#    @tv = Tvshow.find(params[:id]).tv
#  end

  def set_user
    @tv = Tvshow.find(tvshow_params[:front_tvshow_id]).tv
    @user = @tv.user
    if @user != current_user
      flash[:danger] = "別のユーザーの編集はできません。"
      redirect_to @user
    end
  end
end

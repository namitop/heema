class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]
  
  def show
    @user = User.find(params[:id])
    @tvs = @user.tvs.order(created_at: :desc)
    
    @tv = current_user.tvs.build if logged_in?
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def edit
  end
  
  def update
    if params[:user][:new_password].blank? || params[:user][:new_password_confirmation].blank?
      if @user.update(user_params)
        # 保存に成功した場合はトップページへリダイレクト
        flash[:success] = 'メッセージを編集しました'
        redirect_to user_path(@user)
      else
        # 保存に失敗した場合は編集画面へ戻す
        flash[:danger] = "失敗１"
        render 'edit'
      end 
    elsif @user && @user.authenticate(params[:user][:password_for_edit]) && params[:user][:new_password]==params[:user][:new_password_confirmation]
      params[:user][:password] = params[:user][:new_password]
      params[:user][:password_confirmation] = params[:user][:new_password_confirmation]
      if @user.update(user_params)
        # 保存に成功した場合はトップページへリダイレクト
        flash[:success] = "メッセージを編集しました"
        redirect_to user_path(@user)
      else
        # 保存に失敗した場合は編集画面へ戻す
        flash[:danger] = "失敗２"
        render 'edit'
      end
    else
      flash[:danger] = '現在のパスワードor確認用パスワードが間違っています。'
      render 'edit'
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :introduction, :theme_color)
  end
  
  def set_user
    @user = User.find(params[:id])
    if @user != current_user
      flash[:danger] = "別のユーザーの編集はできません。"
      redirect_to @user
    end
  end
end

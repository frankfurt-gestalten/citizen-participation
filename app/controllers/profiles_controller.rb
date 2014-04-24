class ProfilesController < ApplicationController
  load_and_authorize_resource class: User

  def edit_note
    @user = User.find(params[:id])
  end

  def update_note
    @user = User.find(params[:id])
    @user.update_attributes!(notes: params[:notes])
    redirect_to note_profile_path(@user), notice: "Notiz erfolgreich gespeichert."
  end

  def index
    @users = User.order(:created_at).page(params[:page]).per(25)
  end

  def manage_users
    @users = User.order('last_sign_in_at desc').page(params[:page]).per(25)
  end

  def assign_moderator
    @user = User.find(params[:id])
    authorize! :assign_moderator, @user
    @user.update_column(:role, 'moderator')

    respond_to do |format|
      format.js { render 'update_user_actions' }
    end
  end

  def remove_moderator
    @user = User.find(params[:id])
    authorize! :remove_moderator, @user
    @user.update_column(:role, nil) if @user.moderator?

    respond_to do |format|
      format.js { render 'update_user_actions' }
    end
  end

  def block
    @user = User.find(params[:id])
    authorize! :block, @user
    @user.update_column(:role, 'blocked')

    respond_to do |format|
      format.js { render 'update_block_buttons' }
    end
  end

  def unblock
    @user = User.find(params[:id])
    authorize! :unblock, @user
    @user.update_column(:role, nil) if @user.blocked?

    respond_to do |format|
      format.js { render 'update_block_buttons' }
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    redirect_to manage_users_path
  end
end
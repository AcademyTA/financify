class FriendshipsController < ApplicationController
  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])

    if @friendship.destroy
      flash[:notice] = 'Friend was successfully removed.'
      redirect_to :back
    else
      flash[:error] = 'Something went wrong while removing Friend'
      redirect_to :back
    end
  end
end

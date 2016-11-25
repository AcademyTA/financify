class FriendshipsController < ApplicationController
  def destroy
    @friendship = current_user.friendships.find_by(friend_id: params[:id])
    @friendship.destroy

    respond_to do |format|
      format.html { redirect_to my_friends_path, alert: 'Friend was successfully removed'}
    end
  end
end

class ConversationsController < ApplicationController
  before_action :logged_in_user

  def index
    @conversations = Conversation.includes(:post).paginate(page: params[:conversations_page], per_page: 10)
  end

  def find_or_create
    if params[:conversation][:receiver_id] == current_user.id.to_s
      flash[:warning] = "This advertisement is posted by you!"
      redirect_to user_post_path(params[:conversation][:receiver_id], params[:conversation][:post_id]) 
    else
      if Conversation.between(current_user.id, params[:conversation][:receiver_id], params[:conversation][:post_id]).present?
        @conversation = Conversation.between(current_user.id, params[:conversation][:receiver_id], params[:conversation][:post_id]).pluck(:id).first
      else
        params[:conversation][:sender_id] = current_user.id
        @conversation = Conversation.new(conversation_params)
        @conversation.save
      end
      
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private  
    # Permiseble parameters.
    def conversation_params
      params.require(:conversation).permit(:sender_id, :receiver_id, :post_id)
    end
end
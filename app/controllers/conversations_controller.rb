class ConversationsController < ApplicationController
  before_action :logged_in_user

  def index
    @conversations = Conversation.includes(:post).paginate(page: params[:conversations_page], per_page: 10)
  end

  def create
    if Conversation.between(params[:conversation][:sender_id], params[:conversation][:receiver_id], params[:conversation][:post_id]).present?
      @conversation = Conversation.between(params[:conversation][:sender_id], params[:conversation][:receiver_id], params[:conversation][:post_id]).pluck(:id).first
    else
      @conversation = Conversation.new(conversation_params)
      @conversation.save
    end
    
    redirect_to conversation_messages_path(@conversation)
  end

  private  
    # Permiseble parameters.
    def conversation_params
      params.require(:conversation).permit(:sender_id, :receiver_id, :post_id)
    end
end
class MessagesController < ApplicationController
  before_action :find_conversation

  def index
    @messages = @conversation.messages.ordering.paginate(page: params[:messages_page], per_page: 20)
    @message = @conversation.messages.new
    @conversation_count = @messages.size

    if @conversation.sender_id == current_user.id
      @user = User.find_by(id: @conversation.receiver_id)
    else
      @user = User.find_by(id: @conversation.sender_id)
    end
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    if @message.save
      redirect_to conversation_messages_path(@conversation)
    end
  end

  private
    # Permiseble parameters.
    def message_params
      params.require(:message).permit(:message_body, :user_id)
    end

    # Find Conversation
    def find_conversation
        @conversation = Conversation.find(params[:conversation_id])
    end
end
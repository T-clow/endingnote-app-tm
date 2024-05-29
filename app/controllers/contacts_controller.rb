class ContactsController < ApplicationController
  def index
    @contact = Contact.new
    if user_signed_in?
      @contact.email = current_user.email
      @contact.name = current_user.username
    end
  end

  def confirm
    @contact = Contact.new(contact_params)
    if @contact.valid?
      render :confirm
    else
      flash.now[:alert] = '必須項目を入力してください。'
      render :index, status: :unprocessable_entity
    end
  end

  def done
    @contact = Contact.new(contact_params)
    if params[:back]
      render :index
    else
      ContactMailer.send_mail(@contact).deliver_now
      render :done
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :content)
  end
end

# module ControllerHelpers
#   def sign_in(user = double('user'))
#     if user.nil?
#       allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
#       allow(controller).to receive(:current_user).and_return(nil)
#     else
#       allow(request.env['warden']).to receive(:authenticate!).and_return(user)
#       allow(controller).to receive(:current_user).and_return(user)
#     end
#   end
# end

# module ControllerHelpers
#   def login_with(user = double('user'), scope = :user)
#     current_user = "current_#{scope}".to_sym
#     if user.nil?
#       allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => scope})
#       allow(controller).to receive(current_user).and_return(nil)
#     else
#       allow(request.env['warden']).to receive(:authenticate!).and_return(user)
#       allow(controller).to receive(current_user).and_return(user)
#     end
#   end
# end

module ControllerHelpers
  def sign_in(user = FactoryGirl.create(:user))
    if user.nil?
      allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      allow(controller).to receive(:current_user).and_return(nil)
    else
      allow(request.env['warden']).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end
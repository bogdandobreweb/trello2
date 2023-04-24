require '../rails_helper.rb'

RSpec.describe BoardsController, type: :controller do
  describe '#index' do
    context 'when user is logged in' do
      let(:user) { instance_double(User, id: 1, boards: [instance_double(Board, title: 'Board 1'), instance_double(Board, title: 'Board 2')]) }

      before do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(user)
      end

      it 'returns the boards' do
        get :index
        expect(assigns(:boards)).to eq(user.boards)
      end
    end

    context 'when user is not logged in' do
      before do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
      end

      it 'redirects to the sign in page' do
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
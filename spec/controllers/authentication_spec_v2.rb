require '../rails_helper.rb'

RSpec.describe BoardsController, type: :controller do
  describe '#index' do
    context 'when user is logged in' do
        let(:user) { FactoryBot.create(:user) }
        let(:user_double) { instance_double(User, id: user.id, boards: [instance_double(Board, title: 'Board 1'), instance_double(Board, title: 'Board 2')]) }
        
        before { sign_in user }

        it 'returns the boards' do
            get :index
            expect(assigns(:boards)).to eq(user.boards)
          end
    end

    context 'when user is not logged in' do
        it 'redirects to the sign in page' do
          get :index
          expect(response).to redirect_to(new_user_session_path)
        end
      end
  end
end
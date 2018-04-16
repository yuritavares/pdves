require 'rails_helper'

RSpec.describe DvesController, type: :controller do

  describe 'As guest user' do
    before do
      @dve = create(:dve)
    end

    context 'GET #index' do
      subject { get :index }

      it 'Response should be 302(not authorized)' do
        expect(subject).to have_http_status(302)
      end
    end

    context 'GET #new' do
      subject { get :new }

      it 'response should be 302 (not authorized)' do
        expect(subject).to have_http_status(302)
      end
    end

    context 'GET #show' do

      it 'response should be 302 (not authorized)' do
        get :show, params: { id: @dve.id }

        expect(response).to have_http_status(302)
      end
    end

    context 'GET #edit' do

      it 'response should be 302 (not authorized)' do
        get :edit, params: { id: @dve.id }

        expect(response).to have_http_status(302)
      end
    end

    context 'PUT #update' do

      it 'response should be 302 (not authorized)' do
        put :update, params: { id: @dve.id, event_name: 'E o bambu?'}

        expect(response).to have_http_status(302)
      end
    end

    context 'DELETE #destroy' do

      it 'response should be 302 (not authorized)' do
        delete :destroy, params: { id: @dve.id }

        expect(response).to have_http_status(302)
      end
    end

    context 'GET #month_detail' do
      subject { get :create }

      it 'response should be 302 (not authorized)' do
        expect(subject).to have_http_status(302)
      end
    end
  end

  describe 'As loggued user' do
    before do
      @user = create(:user)
      @dve = create(:dve, user_id: @user.id, event_date: '01/04/2018')
      @dve2 = create(:dve, user_id: @user.id, event_date: '02/04/2018')
      sign_in @user
    end

    let!(:dve_attributes) { attributes_for(:dve) }
    let!(:invalid_dve_attributes) { attributes_for(:dve, event_name: nil) }
    let(:new_attributes) { attributes_for(:dve, event_name: 'Chimbinha o Jesus das guitarra!') }

    context 'GET #index' do
      subject { get :index }

      it 'response should be 200' do
        expect(subject).to have_http_status(200)
      end

      it 'renders the index template' do
        expect(subject).to render_template(:index)
      end

      it 'when there is no event_date params passed' do
        get :index
        expect(assigns(:month)).to eq(Date.today.month)
      end

      it 'when a event_date is passed' do
        get :index, params: { date: { month: '2' } }
        expect(assigns(:month)).to eq('2')
      end

      it '@total_month' do
        get :index, params: { date: { month: '4' } }

        expect(assigns(:total_month)).to eq(72)
      end

      it '@total_count' do
        get :index, params: { date: { month: '4' } }

        expect(assigns(:total_count)).to eq(2)
      end
    end

    context 'GET #new' do
      subject { get :new }

      it "response should be 200" do
        expect(subject).to have_http_status(200)
      end

      it 'renders the new template' do
        expect(subject).to render_template(:new)
      end

      it 'Cheking presence of of params event_date' do
        get :new, params: { event_date: '14/02/2018' }

        expect(controller.params[:event_date]).to eq '14/02/2018'
      end
    end

    context 'POST #create' do
      context 'with valid params' do
        it 'creates a new Dve' do
          expect do
            post :create, params: { dve: dve_attributes }
          end.to change(Dve, :count).by(1)
        end

        it 'redirects to the created' do
          post :create, params: { dve: dve_attributes }
          expect(response).to redirect_to(Dve.last)
        end

        it 'flash notice' do
          post :create, params: { dve: dve_attributes }
          expect(flash[:notice]).to eq('Dve criada com sucesso!')
        end
      end

      context 'with invalid params' do
        it "a new Dve can't be created" do
          expect do
            post :create, params: { dve: invalid_dve_attributes }
          end.not_to change(Dve, :count)
        end

        it 'render the new form again' do
          post :create, params: { dve: invalid_dve_attributes }
          expect(response).to render_template(:new)
        end
      end
    end

    context 'GET #show' do
      it 'response should be 200' do
        get :show, params: { id: @dve.id }

        expect(response).to  be_success
      end
    end

    context 'GET #edit' do
      it 'response should be 200' do
        get :edit, params: { id: @dve.id }

        expect(response).to  be_success
      end
    end

    context 'PUT #update' do
      context 'with valid params' do
        it 'updates the requested Dve' do
          put :update, params: { id: @dve.id, dve: new_attributes }
          @dve.reload
          expect(@dve.event_name).to eq('Chimbinha o Jesus das guitarra!')
        end

        it 'redirects to the month_detail' do
          put :update, params: { id: @dve, dve: new_attributes }
          month = @dve.event_date.month
          expect(response).to redirect_to(month_detail_path(month: month))
        end

        it 'flash notice' do
          put :update, params: { id: @dve, dve: new_attributes }
          expect(flash[:notice]).to eq('Dve atualizada com sucesso!')
        end
      end

      context 'with invalid params' do
        it "event can't be updated" do
          put :update, params: { id: @dve.id, dve: invalid_dve_attributes }
          expect(response).to render_template(:edit)
        end
      end
    end

    context 'DELETE #destroy' do
      it 'destroys the requested Dve' do
        expect do
          delete :destroy, params: { id: @dve.id }
        end.to change(Dve, :count).by(-1)
      end

      it 'redirects to the month_detail' do
        delete :destroy, params: { id: @dve.id }
        month = @dve.event_date.month
        expect(response).to redirect_to(month_detail_path(month: month))
      end
    end

    context 'GET #month_detail' do

      it 'when there is no event_date params passed' do
        get :month_detail
        expect(assigns(:month)).to eq(Date.today.month)
      end

      it '@month check month when a event_date is passed' do
        get :month_detail, params: { month: '2' }
        expect(assigns(:month)).to eq('2')
      end

      it '@month_dves should contains total of days with dves' do
        get :month_detail, params: { month: '4' }

        expect(assigns(:month_dves).count).to eq(2)
      end
    end
  end
end

require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  tests Clearance::UsersController

  should_filter_params :password

  context "when signed out" do
    setup { sign_out }

    context "on GET to #new" do
      setup { get :new }
      should_deny_access
    end

    context "on POST to #create with valid attributes" do
      setup do
        user_attributes = Factory.attributes_for(:user)
        post :create, :user => user_attributes
      end
      should_deny_access
    end
  end

  signed_in_user_context do
    context "GET to new" do
      setup { get :new }

      should_respond_with :success
      should_render_template :new
      should_not_set_the_flash

      should_display_a_sign_up_form
    end

    context "POST to create" do
      setup do
        user_attributes = Factory.attributes_for(:user)
        post :create, :user => user_attributes
      end
      should_create_user_successfully
      should_set_the_flash_to /account was created/
      should_redirect_to('new_user_url') { new_user_url }
    end
  end
end

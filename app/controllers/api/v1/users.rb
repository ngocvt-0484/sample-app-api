module API
  module V1
    class Users < Grape::API
      include API::V1::Defaults

      resource :users do
        desc "Return all users"
        get "", root: :users do
          User.all
        end

        desc "Return a user"
        params do
          requires :id, type: String, desc: "ID of the user"
        end
        get ":id", root: "user" do
          user = User.find_by_id params[:id]
          if user
            UserSerializer.new(user).serializable_hash
          else
            api_error! "User not found", "failure", 404, {}
          end
        end
      end
    end
  end
end

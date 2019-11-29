require "spec_helper"
require "active_support/core_ext/string/inflections"
require "support/constant_helpers"
require "administrate/resource_resolver"

describe Administrate::ResourceResolver do
  before do
    module Library; class User; end; end
    class User; end
  end

  after do
    remove_constants :Library
    remove_constants :User
  end

  describe "#dashboard_class" do
    it "handles global-namepsace models" do
      begin
        class UserDashboard; end
        resolver = Administrate::ResourceResolver.new("admin/users")

        expect(resolver.dashboard_class).to eq(UserDashboard)
      ensure
        remove_constants :UserDashboard
      end
    end

    it "handles namespaced models" do
      begin
        module Library; class UserDashboard; end; end
        resolver = Administrate::ResourceResolver.new("admin/library/user")

        expect(resolver.dashboard_class).to eq(Library::UserDashboard)
      end
    end
  end

  describe "#namespace" do
    it "detects the namespace" do
      resolver = Administrate::ResourceResolver.new("management/library/users")

      expect(resolver.namespace).to eq("management")
    end

    it "detects that there is no namespace" do
      resolver = Administrate::ResourceResolver.new("users")

      expect(resolver.namespace).to be_nil
    end
  end

  describe "#resource_class" do
    it "handles global-namepsace models" do
      begin
        resolver = Administrate::ResourceResolver.new("admin/users")

        expect(resolver.resource_class).to eq(User)
      end
    end

    it "handles namespaced models" do
      begin
        module Library; class User; end; end
        resolver = Administrate::ResourceResolver.new("admin/library/user")

        expect(resolver.resource_class).to eq(Library::User)
      end
    end
  end

  describe "#resource_title" do
    it "handles global-namepsace models" do
      resolver = Administrate::ResourceResolver.new("admin/users")

      expect(resolver.resource_title).to eq("User")
    end

    it "handles namespaced models" do
      resolver = Administrate::ResourceResolver.new("admin/library/user")

      expect(resolver.resource_title).to eq("Library User")
    end
  end

  describe "#resource_name" do
    it "handles global-namepsace models" do
      resolver = Administrate::ResourceResolver.new("admin/users")

      expect(resolver.resource_name).to eq(:user)
    end

    it "handles namespaced models" do
      resolver = Administrate::ResourceResolver.new("admin/library/user")

      expect(resolver.resource_name).to eq(:library__user)
    end

    it "respects plural namespaces" do
      begin
        module Managers; class Owner; end end
        resolver = Administrate::ResourceResolver.new("admins/managers/owner")
        expect(resolver.resource_name).to eq(:managers__owner)
      ensure
        remove_constants :Managers
      end
    end
  end
end

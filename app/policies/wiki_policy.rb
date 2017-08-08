class WikiPolicy < ApplicationPolicy

  class Scope < Scope
    attr_reader :user, :scope

    def initialize(user,scope)
      @user = user
      @scope = scope
    end

    def resolve
      wikis = []
      if user.admin?
        scope.all # if admin user show all the wikis
      elsif user.role == 'vip'

        all_wikis = scope.all
        all_wikis.each do |wiki|
          if wiki.private? == false || wiki.user == user || wiki.collaborators.include?(user) # show vip public
            wikis << wiki
          end
        end
      else # standard user
        all_wikis = scope.all
        wikis = []
        all_wikis.each do |wiki|
          if wiki.private? == false || wiki.collaborators.include?(user)
            wikis << wiki
          end
        end
      end
      wikis
    end
  end

  def update?
    user.admin? || user.vip?
  end


end

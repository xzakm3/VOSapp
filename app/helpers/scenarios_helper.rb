module ScenariosHelper
  def get_my_scenarios
    @scenarios = Scenario.where(user_id: current_user).order(power: :desc)
  end
end

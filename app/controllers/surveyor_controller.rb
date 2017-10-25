# encoding: UTF-8

include ApplicationHelper

module SurveyorControllerCustomMethods
  def self.included(base)
    # base.send :before_filter, :require_user   # AuthLogic
    # base.send :before_filter, :login_required  # Restful Authentication
    base.send :layout, 'surveyor_custom'
    base.send :before_filter, :authenticate_user!, :only => :new
  end

  # Actions
  def welcome
  end

  def new
    super
    survey_taken

    pid13 = current_user.email.split('@').first
    @uinfo = get_user_info(pid13)

    @title = "Welcome to BPS Happy Money Survey"

    if @flag == true
      redirect_to "/surveys/refinance/#{@taken.first.access_code}?uinfo=#{@uinfo}"
    elsif @flag == false
      redirect_to "/surveys/refinance/#{@taken.first.access_code}/take?uinfo=#{@uinfo}"
    end

  end

  def create
    super
  end

  def show
    super
  end

  def edit
    super
  end

  def update
    super
  end

  def survey_taken
    @flag = nil
    @taken = ResponseSet.select("access_code,completed_at").where(:user_id => current_user.id)
    if @taken.first
      completed = @taken.first.completed_at
      if completed
        @flag = true
      else
        @flag = false
      end
    end
  end

  # Paths
  def surveyor_index
    # most of the above actions redirect to this method
    super # surveyor.available_surveys_path
  end
  def surveyor_finish
    # the update action redirects to this method if given params[:finish]
    super # surveyor.available_surveys_path
  end
end

class SurveyorController < ApplicationController
  include Surveyor::SurveyorControllerMethods
  include SurveyorControllerCustomMethods
end

# encoding: UTF-8
require 'pry-nav'

include ApplicationHelper

module SurveyorControllerCustomMethods
  def self.included(base)
    # base.send :before_filter, :require_user   # AuthLogic
    # base.send :before_filter, :login_required  # Restful Authentication
    base.send :layout, 'surveyor_custom'
    base.send :before_filter, :authenticate_user!, :only => :new
  end

  # Actions
  def result
    @revenue = 0
    @expense = 0
    @exp_a = 0
    @exp_b = 0
    @exp_c = 0
    @exp_d = 0

    # find response_set_id for current user
    rs_id = ResponseSet.where(:user_id => current_user.id).first.id

    # revenue now is string_value from answer_id 166-172
    (166..172).each do |a|
      o = Response.where(:response_set_id => rs_id,:answer_id => a).limit(1).first
      if o and o.string_value
        rev = o.string_value.to_s.tr(',','').to_i
      else
        rev = 0
      end
      @revenue += rev
    end

    # mortgage loan for house
    o = Response.where(:response_set_id => rs_id, :answer_id => 173).limit(1).first
    if o and o.string_value
      @exp_a = o.string_value.to_s.tr(',','').to_i
    else
      @exp_a = 0
    end

    # other debts
    o = Response.where(:response_set_id => rs_id, :answer_id => 174).limit(1).first
    if o and o.string_value
      @exp_b = o.string_value.to_s.tr(',','').to_i
    else
      @exp_b = 0
    end

    # other expenses
    o = Response.where(:response_set_id => rs_id, :answer_id => 175).limit(1).first
    if o and o.string_value
      @exp_c = o.string_value.to_s.tr(',','').to_i
    else
      @exp_c = 0
    end

    # investment (LTF RMF) per year MUST divided by 12.0 per month
    o = Response.where(:response_set_id => rs_id, :answer_id => 176).limit(1).first
    if o and o.string_value
      @exp_d = o.string_value.to_s.tr(',','').to_i / 12.0
    else
      @exp_d = 0
    end

    @balance = @revenue - (@exp_a + @exp_b + @exp_c + @exp_d)

    # criteria @ 50%
    pct_1 = (@exp_a + @exp_b) * 100.0 / @revenue

    # criteria @ 30%
    pct_2 = @exp_a * 100.0 / @revenue

    if @exp_a == 0 and @exp_b == 0.0
      @status = "ไม่มีหนี้สิน"
      @result_bg = 'lightgreen'
      @result_fg = 'green'
    elsif pct_1 < 50.0 and pct_2 < 30.0
      @status = "เหมาะสม"
      @result_bg = 'lightblue'
      @result_fg = 'blue'
    elsif pct_1 > 50.0 and pct_2 > 30.0
      @status = "วิกฤติ"
      @result_bg = 'pink'
      @result_fg = 'red'
    elsif pct_1 > 50.0 or pct_2 > 30.0
      @status = "ไม่เหมาะสม"
      @result_bg = 'lightyellow'
      @result_fg = 'brown'
    end
    # render view result.html.erb
  end

  def welcome
  end

  def new
    super
    survey_taken

    pid13 = current_user.email.split('@').first
    @title = "Welcome to BPS Happy Money Survey"

    if @flag == true
      redirect_to "/surveys/refinance/#{@taken.first.access_code}"
    elsif @flag == false
      redirect_to "/surveys/refinance/#{@taken.first.access_code}/take"
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
    "/surveyor/result"
  end
end

class SurveyorController < ApplicationController
  include Surveyor::SurveyorControllerMethods
  include SurveyorControllerCustomMethods
end

class HomeController < ApplicationController
  def index
    @result = ExamList.all.select{|exam| exam.sub_count > 0}
  end

  def submit
    @exam = ExamList.where(:exam_title => params[:title]).first
    @exam.update_attributes(:sub_count => @exam.sub_count + 1)
    @result = ExamList.all.select{|exam| exam.sub_count > 0}
  end
end

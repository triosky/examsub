class HomeController < ApplicationController
  def index
    @result = ExamList.all.select{ |exam| exam.sub_count > 0 }
  end

  def submit
    @exam = nil
    if params[:title].split(":").count == 2
      code = params[:title].to_s.split(":")[0]
      title = params[:title].to_s.split(":")[1]
      @exam = ExamList.where(:exam_code => code, :exam_title => title).first
    else
      @exam = ExamList.where(:exam_title => params[:title]).first
    end
    @result = []
    if @exam.nil? == false
      @exam.update_attributes(:sub_count => @exam.sub_count + 1)
      @result = ExamList.all.select { |exam| exam.sub_count > 0 }
    end
  end
end

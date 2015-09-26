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
    elsif params[:title].split(":").count == 3
      code = params[:title].to_s.split(":")[0]
      lang = params[:title].to_s.split(":")[1]
      title = params[:title].to_s.split(":")[2]
      @exam = ExamList.where(:exam_code => code, :exam_title => title, :exam_lang => lang).first
    else
      @exam = ExamList.where(:exam_title => params[:title]).first
    end
    @result = []
    @available = 1
    if @exam.user_ids.include? session.id
      @available = 0
      @result = ExamList.all.select { |exam| exam.sub_count > 0 }
    else
      if @exam.nil? == false
        @exam.update_attributes(:sub_count => @exam.sub_count + 1)
        @exam.update_attributes(:user_ids => @exam.user_ids + ",#{session.id}")
        @result = ExamList.all.select { |exam| exam.sub_count > 0 }
      end
    end
  end
end

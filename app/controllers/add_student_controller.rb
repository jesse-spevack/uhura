class AddStudentController < ApplicationController
  def new
    @group = Group.find(params[:id])
  end

  def create
    student = Student.find(params[:student])
    group = Group.find(params[:id])
    Enrollment.create(student: student, group: group)
    redirect_to group_path(group)
  end
end

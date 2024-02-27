class Api::V1::StudentsController < ApplicationController
  def index
    students = Student.all
    render json: students, status: 200
  end

  def show
    student = Student.find_by(id: params[:id])
    if student
      render json: student, status: 200
    else
      render json:{
        error: "Student not found"
      }
    end
  end

  def create
    student = Student.new(
      name: stu_params[:name],
      address: stu_params[:address],
      email: stu_params[:email]
    )
    if student.save
      render json: student, status: 200
    else
      render json:{
        error: "Error Creating.."
      }
    end
  end

  def update
    student = Student.find_by(id: params[:id])
    if student
      student.update(name: params[:name], address: params[:address], email: params[:email])
      render json: "Student Record Updated Successfully"
    else
      render json:{
        error: "Student Not Found"
      }
    end
  end

  def destroy
    student = Student.find_by(id: params[:id])
    if student
      student.destroy
      render json: "Student has been deleted"
    end
  end
  
  private
  def stu_params
    params.require(:student).permit([
      :name,
      :address,
      :email
    ])
  end
end


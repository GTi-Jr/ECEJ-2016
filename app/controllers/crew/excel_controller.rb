class Crew::ExcelController < ApplicationController
  before_action :authenticate_crew_admin!

  layout 'admin_layout'

  def users
    @users = User.all.order(:name)

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "Lista de congressistas.csv" }
      format.xls
    end
  end

  def lot_users
    @lot = Lot.find(params[:id])
    @users = @lot.users.order(:name)

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "Lista de congressistas no lote #{@lot.name}.csv" }
      format.xls
    end
  end

  def event_users
    @event = Event.find(params[:id])
    @users = @event.users

    respond_to do |format|
      format.html
      format.csv { send_data @event.users.to_csv, filename: "Congressistas em #{@event.name}.csv" }
      format.xls
    end
  end

  def payments
    @payments = []
    @total = 0
    @date = Date.today
    users = User.select {|user| !user.payment.nil? }

    users.each do |user|
      payment = user.payment
      payment_data = {  name: user.name,
                        method: payment.method,
                        portions: payment.portions,
                        portion_paid: payment.portion_paid,
                        amount_paid: payment.amount_paid }

      @total += payment_data[:amount_paid]
      @payments << payment_data
    end

    respond_to do |format|
      format.xls
    end
  end

  def users_after_third_lot_expiration
    deadline = Lot.third.deadline_1
    @users = User.select { |user| user.created_at > deadline }

    respond_to do |format|
      format.xls
    end
  end

  def non_paid_users
    @users = User.select { |user| user.payment.nil? || !user.payment.partially_paid? }

    respond_to do |format|
      format.xls
    end
  end

  def users_federation
    @users = User.all.order(:federation)

    respond_to do |format|
      format.html
      format.csv { send_data @users.to_csv, filename: "Lista de congressistas por federacao.csv" }
      format.xls
    end
  end

  def current_payments
    @payments = []
    @total = 0
    @date = Date.today
    users = User.select {|user| !user.payment.nil? }

    users.each do |user|
      payment = user.payment
      payment_data = {  name: user.name,
                        email: user.email,
                        method: payment.method,
                        portions: payment.portions,
                        portion_paid: payment.portion_paid,
                        amount_paid: payment.amount_paid }

      @total += payment_data[:amount_paid]
      @payments << payment_data
    end

    respond_to do |format|
      format.xls
    end
  end

  def last_x_days_users
    @users = User
             .order(:name)
             .select { |user| user.created_at >= params[:days_ago].to_i.days.ago }
  end

  def excel_handler
    excel = ExcelHandler.new model: User
    @possible_columns = excel.possible_columns
  end

  def generate_xls
    excel = ExcelHandler.new model: User
    @columns = excel.get_selected_columns_from_params(params, :selected_columns)
    @users = User.all
  end

  def required_transportation_users
    @users = User.where(transport_required: 'Sim').includes(:payment).select do |user|
      !user.payment.nil? && user.payment.partially_paid?
    end

    respond_to do |format|
      format.xls
    end
  end

  def paid_and_transport
    @users = User.includes(:payment).select do |user|
      !user.payment.nil? && user.payment.paid? && user.transport_required == 'Sim'
    end

    respond_to do |format|
      format.xls
    end
  end

  def paid
    @users = User.includes(:payment).select do |user|
      !user.payment.nil? && user.payment.paid?
    end

    respond_to do |format|
      format.xls
    end
  end

  def rooms_users
    @hotels = Hotel.includes(rooms: [:users]).order(:name).each do |hotel|
      hotel.rooms = hotel.rooms.order(:number)
    end
  end
end

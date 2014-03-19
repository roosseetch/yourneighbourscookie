class IpAddressesController < ApplicationController
  before_action :set_ip_address, only: [:index, :show, :edit, :update, :destroy]

  # GET /ip_addresses
  # GET /ip_addresses.json
  def index

=begin
    group = {"$group" => {
           _id: nil,
           ip_src:  { '$addToSet' => "$ip_src" }
         }
      }

    project= {"$project" => {
            _id: 0,
            ip_src: 1
          }
        }
    IpAddress.collection.aggregate([group,project])[0]["ip_src"]
=end

    # db.collection.distinct(field, query)
    # @ip_addresses = IpAddress.any_in(ip_src: uniq_sorted_ip).page(params[:page])
    # @ip_addresses = IpAddress.order_by([[:ip_src, :asc], [:http_host, :asc]]).page(params[:page])
    # @ip_addresses = IpAddress.where(:AUTHCODE => { '$exists' => true, '$ne' => "" }).order_by([[:ip_src, :asc], [:http_host, :asc]]).page(params[:page])
    # @ip_addresses = IpAddress.where(:remixsid => { '$exists' => true, '$ne' => "" }).order_by([[:ip_src, :asc], [:http_host, :asc]]).page(params[:page])
    # @ip_addresses = IpAddress.where(:Mpop => { '$exists' => true, '$ne' => "" }).order_by([[:ip_src, :asc], [:http_host, :asc]]).page(params[:page])
    # @ip_addresses = IpAddress.all.page(params[:page])
    # debugger
    # @ip_addresses = IpAddress.where(ip_src: '10.1.11.178').page(params[:page])
    # @all_ips = IpAddress.where(:remixsid => { '$exists' => true, '$ne' => "" }).distinct(:ip_src).sort_by { |ip| ip.split(".").map(&:to_i) }
    @all_ips = IpAddress.distinct(:ip_src).sort_by { |ip| ip.split(".").map(&:to_i) }
    @selected_ips = params[:ips] || session[:ips] || {}
    @selected_hosts = params[:hosts] || session[:hosts] || ''
    @selected_hosts = ''
    # @selected_ips = params[:ips] || {}

    if @selected_ips == {}
      @selected_ips = Hash[@all_ips.map {|ip| [ip, 1]}]
    end
    # if params[:ips] != session[:ips] and @selected_ips != {}
    #   session[:ips] = @selected_ips
    #   flash.keep
    #   redirect_to :ips => @selected_ips and return
    # end
    # debugger
    # if params[:hosts] != session[:hosts] and @selected_hosts != ''
    #   session[:hosts] = @selected_hosts
    #   flash.keep
    #   redirect_to :hosts => @selected_hosts and return
    # end

    if @selected_hosts.empty?
      @ip_addresses = IpAddress.where(ip_src: {"$in" => @selected_ips.keys}).page(params[:page])
    else
      @ip_addresses = IpAddress.where(ip_src: {"$in" => @selected_ips.keys}).
      and(http_host: {"$in" => @selected_hosts.gsub(' ', '').split(',')}).page(params[:page])
    end
    # @ip_addresses = IpAddress.in(ip_src: @selected_ips.keys).page(params[:page])
=begin
    @ip_addresses = IpAddress.where(:remixsid => { '$exists' => true, '$ne' => "" }).order_by([[:ip_src, :asc], [:http_host, :asc]]).page(params[:page])

=end

  end

=begin
  def index
    sort = params[:sort] || session[:sort]
    case sort
    when 'title'
      ordering,@title_header = {:order => :title}, 'hilite'
    when 'release_date'
      ordering,@date_header = {:order => :release_date}, 'hilite'
    end
    @all_ratings = Movie.all_ratings
    @selected_ratings = params[:ratings] || session[:ratings] || {}

    if @selected_ratings == {}
      @selected_ratings = Hash[@all_ratings.map {|rating| [rating, rating]}]
    end

    if params[:sort] != session[:sort]
      session[:sort] = sort
      flash.keep
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end

    if params[:ratings] != session[:ratings] and @selected_ratings != {}
      session[:sort] = sort
      session[:ratings] = @selected_ratings
      flash.keep
      redirect_to :sort => sort, :ratings => @selected_ratings and return
    end
    @movies = Movie.find_all_by_rating(@selected_ratings.keys, ordering)
  end
=end

  # GET /ip_addresses/1
  # GET /ip_addresses/1.json
  def show
    @ip_address = IpAddress.find(params[:id])
  end

  def import_h
    if request.post? && params[:ip_address].present?
      IpAddress.import_h(params[:ip_address][:file])
      redirect_to ip_addresses_path, notice: "Products imported."
    else
      redirect_to ip_addresses_path, alert: "Please select CSV file."
    end
  end

  def import_s
    if request.post? && params[:file].present?
      IpAddress.import_s(params[:file])
      redirect_to ip_addresses_path, notice: "Products imported."
    else
      redirect_to ip_addresses_path, alert: "Please select CSV file."
    end
  end

  # GET /ip_addresses/new
  def new
    @ip_address = IpAddress.new
  end

  # GET /ip_addresses/1/edit
  def edit
  end

  # POST /ip_addresses
  # POST /ip_addresses.json
  def create
    @ip_address = IpAddress.new(ip_address_params)

    respond_to do |format|
      if @ip_address.save
        format.html { redirect_to @ip_address, notice: 'Ip address was successfully created.' }
        format.json { render action: 'show', status: :created, location: @ip_address }
      else
        format.html { render action: 'new' }
        format.json { render json: @ip_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ip_addresses/1
  # PATCH/PUT /ip_addresses/1.json
  def update
    respond_to do |format|
      if @ip_address.update(ip_address_params)
        format.html { redirect_to @ip_address, notice: 'Ip address was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @ip_address.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ip_addresses/1
  # DELETE /ip_addresses/1.json
  def destroy
    @ip_address.destroy
    respond_to do |format|
      format.html { redirect_to ip_addresses_url }
      format.json { head :no_content }
    end
  end

  def destroy_multiple
    # debugger
    params[:ip_del].map {|key,value| value.map{|val| IpAddress.where(id: key).pull(val.split(' ')[0].to_sym => val.split(' ')[1])}}

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { head :no_content }
   end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ip_address
=begin
      Mongoid::Errors::InvalidFind (
Problem:
  Calling Document.find with nil is invalid.
Summary:
  Document.find expects the parameters to be 1 or more ids, and will return
  a single document if 1 id is provided, otherwise an array of documents if
  multiple ids are provided.
Resolution:
  Most likely this is caused by passing parameters directly through to the find,
  and the parameter either is not present or the key from which it is accessed
  is incorrect.):
  app/controllers/ip_addresses_controller.rb:159:in `set_ip_address'
=end
      # @ip_address = IpAddress.find(params[:id])

      @ip_address = IpAddress.where(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ip_address_params
      params[:ip_address]
    end
end

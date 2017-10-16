class Devise::RegistrationsController < DeviseController
  prepend_before_filter :require_no_authentication, only: [:new, :create, :cancel]
  prepend_before_filter :authenticate_scope!, only: [:edit, :update, :destroy]

  # GET /resource/sign_up
  def new
    build_resource({})
    set_minimum_password_length
    yield resource if block_given?
    respond_with self.resource
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    #### add check valid HCODE5 from admins table
    #### drtoon @20170313 10:20

    @username = resource.email.split('@').first
    @hcode5 = resource.email.split('@').last

    if (@username.length == 13)
      if !check_valid_pid13?
        redirect_to '/users/sign_up', :alert => "ขออภัย หมายเลขบัตรประชาชน 13 หลักไม่ถูกต้อง"
        return
      end
    end

    if !check_valid_username?
      redirect_to '/users/sign_up', :alert => "ขออภัย กรุณาใช้หมายเลขบัตรประชาชน 13 หลัก"
      return
    end

    if !check_valid_hcode5?
      redirect_to '/users/sign_up', :alert => "ขออภัย ไม่พบรหัสหน่วยงาน 5 หลัก โปรดติดต่อ<br/>สนย. โทรฯ 0-2590-1492 ถึง 3".html_safe
      return
    end

    resource.save
    yield resource if block_given?

    redirect_to after_sign_up_path_for(resource), :alert => "ลงทะเบียนสำเร็จ โปรด Sign in เพื่อทำแบบทดสอบ" and return

    if resource.persisted?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flash                                          ing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def check_valid_pid13?
    i = @username.split('')
    m = 13
    sum = 0
    (0..11).each do |n|
      sum += i[n].to_i * m
      m -= 1
    end
    mod11 = sum % 11
    chkdigit = 11 - mod11
    chkdigit = chkdigit - 10 if chkdigit > 9
    if (i[12].to_i == chkdigit)
      return true
    else
      return false
    end
  end

  def check_valid_hcode5?
    flag = Admin.find_by_hcode5(@hcode5)
    if flag.nil?
      return false
    else
      return true
    end
  end

  def check_valid_username?
    if (@username =~ /\d{13}/ and @username.length == 13)
      return true
    elsif (@username.downcase == 'admin')
      return true
    else
      return false
    end
  end

  # GET /resource/edit
  def edit
    render :edit
  end

  # PUT /resource
  # We need to use a copy of the resource because we don't want to change
  # the current user in place.
  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      sign_in resource_name, resource, bypass: true
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  # DELETE /resource
  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message :notice, :destroyed if is_flashing_format?
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    expire_data_after_sign_in!
    redirect_to new_registration_path(resource_name)
  end

  protected

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end

  # By default we want to require a password checks on update.
  # You can overwrite this method in your own RegistrationsController.
  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  # Build a devise resource passing in the session. Useful to move
  # temporary session data to the newly created user.
  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  # Signs in a user on sign up. You can overwrite this method in your own
  # RegistrationsController.
  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    #after_sign_in_path_for(resource)
    '/users/login'
  end

  # The path used after sign up for inactive accounts. You need to overwrite
  # this method in your own RegistrationsController.
  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : "/"
  end

  # The default url to be used after updating a resource. You need to overwrite
  # this method in your own RegistrationsController.
  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  # Authenticates the current scope and gets the current resource from the session.
  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end

  def translation_scope
    'devise.registrations'
  end
end

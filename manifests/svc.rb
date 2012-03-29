define "easysvc::svc",
  :service_name,
  :config_files,
  :config_tpls,
  :config_owners,
  :config_groups,
  :config_modes,
  :pkg_name,
  :autoupdate,
  :service_ensure,
  :service_enable,
  :service_hasstatus,
  :service_hasrestart do

  svc_ensure = case @service_ensure
    when 'running' then :running
    when 'stopped' then :stopped
    else fail("service_ensure parameter must be running or stopped")
  end

  if @autoupdate == true
    package @pkg_name, :ensure => :latest
  elsif @autoupdate == false
    package @pkg_name, :ensure => :present
  else
    fail("autoupdate parameter must be true or false")
  end

  subscribe_list = [ "Package[#{@pkg_name}]" ]

  @config_files.each_with_index do |config_file, i|
    file config_file,
      :ensure => :file,
      :owner  => @config_owners[i],
      :group  => @config_groups[i],
      :mode   => @config_modes[i],
      :content => template(@config_tpls[i]),
      :require => "Package[#{@pkg_name}]"

    subscribe_list << "File[#{config_file}]"
  end

  service @service_name,
    :enable     => @service_enable,
    :ensure     => svc_ensure,
    :name       => @service_name,
    :hasstatus  => @service_hasstatus,
    :hasrestart => @service_hasrestart,
    :subscribe  => subscribe_list
end


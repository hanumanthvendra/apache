Ohai.plugin(:Apache) do
  provides "apache/modules"

  collect_data(:default) do
    apache Mash.new
    apache[:modules] = shell_out("apache2ctl -M").stdout
  end

end

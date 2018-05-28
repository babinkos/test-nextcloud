apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end

log 'message1' do
  message 'apt cache updated'
  level :info
end

package %w(python3-software-properties xdg-utils) do

  action :upgrade
end

log 'message1' do
  message '2 packages updated'
  level :warn
end


package 'nginx' do
#
  action :install
end

log 'message3' do
  message 'nginx installed'
  level :debug
end

service 'nginx' do
  action [:enable, :start]
end

log 'message4' do
  message 'nginx started'
  level :debug
end

service 'nginx' do
  supports status: true
  action :stop
end

log 'message5' do
  message 'nginx stopped'
  level :debug
end

package %w(nginx nginx-core nginx-common) do
  action :remove
end

log 'message6' do
  message 'nginx removed'
  level :debug
end

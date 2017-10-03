apt_update 'Update the apt cache daily' do
   frequency 86_400
   action :periodic
end


package 'xorg'
package 'wmaker'
package 'firefox'
package 'libreoffice'
package 'xrdp'

service 'xrdp' do
   action [:enable, :start]
end

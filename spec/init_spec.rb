# # for serverspec documentation: http://serverspec.org/
# require_relative 'spec_helper'
#
# pkgs = ['docker-engine']
# pips = ['docker-py', 'docker-compose']
#
# pkgs.each do |pkg|
#   describe package("#{pkg}") do
#     it { should be_installed }
#   end
# end
#
# pips.each do |pip|
#   describe package("#{pip}") do
#     it { should be_installed.by('pip') }
#   end
# end
#
# describe service('docker') do
#   it { should be_running.under('upstart') }
# end
#
# describe user('ubuntu') do
#   it { should exist }
#   it { should belong_to_group 'docker' }
# end
#
# describe group('docker') do
#   it { should exist }
#   it { should have_gid 5002 }
# end
#
# describe user('docker') do
#   it { should exist }
#   it { should belong_to_group 'docker' }
#   it { should have_uid 5002 }
# end
#
# describe file('/root/.dockercfg') do
#   it { should be_file }
#   it { should be_mode 644 }
#   it { should be_owned_by 'root' }
#   it { should be_grouped_into 'root' }
#   it { should be_readable }
# end
#
# describe file('/etc/default/docker') do
#   it { should be_file }
#   it { should be_mode 644 }
#   it { should be_owned_by 'root' }
#   it { should be_grouped_into 'root' }
#   it { should be_readable }
# end
#
# describe file('/etc/logrotate.d/docker') do
#   it { should be_file }
#   it { should be_mode 644 }
#   it { should be_owned_by 'root' }
#   it { should be_grouped_into 'root' }
#   it { should be_readable }
# end

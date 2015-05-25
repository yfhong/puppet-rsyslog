require 'spec_helper'

describe 'rsyslog' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "rsyslog class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('rsyslog::params') }
          it { is_expected.to contain_class('rsyslog::install').that_comes_before('rsyslog::config') }
          it { is_expected.to contain_class('rsyslog::config') }
          it { is_expected.to contain_class('rsyslog::service').that_subscribes_to('rsyslog::config') }

          it { is_expected.to contain_service('rsyslog') }
          it { is_expected.to contain_package('rsyslog').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'rsyslog class without any parameters on Solaris/Nexenta' do
      let(:facts) {{
        :osfamily        => 'Solaris',
        :operatingsystem => 'Nexenta',
      }}

      it { expect { is_expected.to contain_package('rsyslog') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end

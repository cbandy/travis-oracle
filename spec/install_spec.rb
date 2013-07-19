
describe 'install.sh' do
  it 'mounts two gigabytes of shared memory at /dev/shm' do
    directory = '/dev/shm'

    File.exist?(directory).should be_true
    File.lstat(directory).should be_directory
    `df -B1 #{directory}`.split("\n")[1].split(/\b/)[2].to_i.should >= 2147483648
  end

  it 'creates an executable that does nothing at /sbin/chkconfig' do
    executable = '/sbin/chkconfig'

    File.exist?(executable).should be_true
    File.lstat(executable).mode.should == '100744'.to_i(8)
    IO.read(executable).should == "#!/bin/sh\n"
  end

  it 'creates a directory at /var/lock/subsys' do
    directory = '/var/lock/subsys'

    File.exist?(directory).should be_true
    File.lstat(directory).should be_directory
  end

  context 'when ORACLE_FILE is defined', :if => ENV.has_key?('ORACLE_FILE') do
    it 'extracts an RPM' do
      Dir.glob('*.rpm').should_not be_empty
    end

    it 'generates a DEB' do
      Dir.glob('*.deb').should_not be_empty
    end

    it 'installs Oracle Express Edition' do
      File.exists?('/etc/init.d/oracle-xe').should be_true

      File.exists?(ENV['ORACLE_HOME']).should be_true
      File.executable?(ENV['ORACLE_HOME'] + '/bin/sqlplus').should be_true
    end
  end

  context 'when ORACLE_HOME is defined', :if => ENV.has_key?('ORACLE_HOME') do
    describe 'shell access' do
      let(:sqlplus) { ENV['ORACLE_HOME'] + '/bin/sqlplus' }

      it 'grants normal access without password to the current user' do
        IO.popen([sqlplus, %w(-L -S /)].flatten, 'w') { |io| io.puts 'exit' }
        $?.should be_success
      end

      it 'grants DBA access without password to the current user' do
        IO.popen([sqlplus, %w(-L -S / AS SYSDBA)].flatten, 'w') { |io| io.puts 'exit' }
        $?.should be_success
      end
    end
  end
end

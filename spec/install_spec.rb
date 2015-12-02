
describe 'install.sh' do
  it 'mounts two gigabytes of shared memory at /dev/shm' do
    directory = '/dev/shm'

    expect(File).to exist(directory)
    expect(File.lstat(directory)).to be_directory
    expect(`df -B1 #{directory}`.split("\n")[1].split(/\b/)[2].to_i).to be >= 2147483648
  end

  it 'creates an executable that does nothing at /sbin/chkconfig' do
    executable = '/sbin/chkconfig'

    expect(File).to exist(executable)
    expect(File.lstat(executable).mode).to eq('100744'.to_i(8))
    expect(IO.read(executable)).to eq("#!/bin/sh\n")
  end

  it 'creates a directory at /var/lock/subsys' do
    directory = '/var/lock/subsys'

    expect(File).to exist(directory)
    expect(File.lstat(directory)).to be_directory
  end

  context 'when ORACLE_FILE is defined', :if => ENV.has_key?('ORACLE_FILE') do
    it 'extracts an RPM' do
      expect(Dir.glob('*.rpm')).to_not be_empty
    end

    it 'installs Oracle Express Edition' do
      expect(File).to exist('/etc/init.d/oracle-xe')

      expect(File).to exist(ENV['ORACLE_HOME'])
      expect(File).to be_executable(ENV['ORACLE_HOME'] + '/bin/sqlplus')
    end
  end

  context 'when ORACLE_HOME is defined', :if => ENV.has_key?('ORACLE_HOME') do
    describe 'shell access' do
      let(:sqlplus) { ENV['ORACLE_HOME'] + '/bin/sqlplus' }

      it 'grants normal access without password to the current user' do
        IO.popen([sqlplus, %w(-L -S /)].flatten, 'w') { |io| io.puts 'exit' }
        expect($?).to be_success
      end

      it 'grants DBA access without password to the current user' do
        IO.popen([sqlplus, %w(-L -S / AS SYSDBA)].flatten, 'w') { |io| io.puts 'exit' }
        expect($?).to be_success
      end
    end

    describe 'library access' do
      before(:context) { require 'oci8' }

      it 'grants normal access without password to the current user' do
        OCI8.new('/').exec('SELECT 1 FROM DUAL') { |row| expect(row).to eq([1]) }
      end
    end
  end
end

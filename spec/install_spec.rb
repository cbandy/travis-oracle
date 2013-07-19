
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
  end
end

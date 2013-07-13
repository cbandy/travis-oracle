
describe 'download.sh' do
  context 'when ORACLE_FILE is defined', :if => ENV.has_key?('ORACLE_FILE') do
    it 'downloads from Oracle' do
      File.exists?(ENV['ORACLE_FILE']).should be_true
    end
  end
end

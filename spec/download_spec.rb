
describe 'download.sh' do
  context 'when ORACLE_FILE is defined', :if => ENV.has_key?('ORACLE_FILE') do
    it 'downloads from Oracle' do
      expect(File).to exist(ENV['ORACLE_FILE'])
    end
  end
end

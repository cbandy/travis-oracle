require 'oci8'

RSpec.describe 'library access' do
  it 'can access without password as the current user' do
    rows_returned = false

    OCI8.new('/').exec('SELECT 1 FROM DUAL') do |row|
      rows_returned = true
      expect(row).to eq([1])
    end

    expect(rows_returned).to be true
  end
end

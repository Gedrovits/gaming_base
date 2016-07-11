class DxdiagParser
  def self.parse(dxdiag = 'vendor/assets/dxdiag1.txt')
    normalized_hash = {}
    
    next_line_is_header = false
    next_line_is_footer = false
    
    cursor = nil
    condition = nil
    # TODO: Replace with normal loading of file
    IO.readlines(dxdiag).map do |line|
      # puts line
      
      # Group up the headers to cursor
      if next_line_is_header
        cursor = convert_to_key(line)
        normalized_hash[cursor] = {}
        next_line_is_header = false
        next_line_is_footer = true
        next
      elsif next_line_is_footer
        next_line_is_footer = false
        next
      elsif line.include?('-------')
        next_line_is_header = true
        next
      end
      
      # Simple data collection
      if line.include?(': ')
        kv = line.split(/: /, 2)
        normalized_hash[cursor][convert_to_key(kv.first)] = convert_to_value(kv.second)
      end
    end
    
    normalized_hash
  end
  
  def self.simple_value(line)
    line.split(':').second.strip
  end
  
  def self.convert_to_key(string)
    string.strip.underscore.gsub(' ', '_').gsub('/', '_').gsub('&', 'and').to_sym
  end
  
  def self.convert_to_value(string)
    string.strip.gsub(/\s+/, ' ')
  end
  
  # List of allowed headers
  def self.allowed_headers
    [:system_information, :dx_diag_notes, :direct_x_debug_levels, :display_devices, :sound_devices,
     :sound_capture_devices, :direct_input_devices, :usb_devices, :gameport_devices, :ps_2_devices,
     :disk_and_dvd_cd_rom_drives, :system_devices, :direct_show_filters, :evr_power_information]
  end
end

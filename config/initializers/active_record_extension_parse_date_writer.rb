# initializers/active_record_extension_parse_date_writer.rb
# https://stackoverflow.com/questions/24499466/how-to-change-the-way-ruby-on-rails-parses-two-digit-year-input
module ActiveRecordExtensionParseDateWriter

	private

	def write_attribute(attr_name, value)
    if self.class.column_types.fetch(attr_name.to_s).type == :date
      d = (pdate(value)) rescue nil
      super(attr_name, d)
    else
      super
    end
  end

  def pdate(val)
    ret = nil
    case val.to_s
      # when /\d{4}-\d{1,2}-\d{1,2}/
      # mdy, forward-slashes w/2 digit year
      when /\d{1,2}\/\d{1,2}\/\d{2}/
        strfmt = "%m/%d/%y"
      # mdy, forward-slashes w/4 digit year
      when /\d{1,2}\/\d{1,2}\/\d{4}/
        strfmt = "%m/%d/%Y"
      else
        ret = val
    end
    return ret || Date.strptime(val.to_s, stfmt)
  end
end

# include the extension
ActiveRecord::Base.send(:include, ActiveRecordExtensionParseDateWriter)
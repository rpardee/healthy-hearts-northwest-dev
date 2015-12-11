# initializers/active_record_extension_parse_date_writer.rb
module ActiveRecordExtensionParseDateWriter

	private

	def write_attribute(attr_name, value)
		if self.class.column_types.fetch(attr_name.to_s).type == :date
			d = (Date.strptime(value.to_s, "%m/%d/%y")) rescue nil
			super(attr_name, d)
		else
			super
		end
	end

end

# include the extension
ActiveRecord::Base.send(:include, ActiveRecordExtensionParseDateWriter)
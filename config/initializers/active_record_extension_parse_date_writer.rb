# initializers/active_record_extension_parse_date_writer.rb
# https://stackoverflow.com/questions/24499466/how-to-change-the-way-ruby-on-rails-parses-two-digit-year-input
module ActiveRecordExtensionParseDateWriter

	private

	def write_attribute(attr_name, value)
		if self.class.column_types.fetch(attr_name.to_s).type == :date
			d = (Date.parse(value.to_s)) rescue nil
			super(attr_name, d)
		else
			super
		end
	end
end

# include the extension
ActiveRecord::Base.send(:include, ActiveRecordExtensionParseDateWriter)
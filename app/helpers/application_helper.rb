module ApplicationHelper
	def set_subheader(arg_header)		
		output = content_tag(:h3,arg_header ,class:"subheader") if arg_header.present?		
	end
end

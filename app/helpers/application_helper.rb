module ApplicationHelper
def sort(column, title = nil)
  title ||= column.titleize
  direction = column == params[:sort] && params[:direction] == "asc" ? "desc" : "asc"
  link_to title, :sort => column, :direction => direction
end

def flash_class(level)
    case level
    when 'success' then "alert alert-success" 
    when 'error' then "alert alert-error"
  end
  end

end

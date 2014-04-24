module WidgetsHelper
  def any_widgets?(position)
    WidgetPlacement.for(params[:controller], params[:action], position).exists?
  end

  def render_widgets(position)
    placements = WidgetPlacement.for(params[:controller], params[:action], position)
    Widget.joins(:placements).merge(placements).inject(''.html_safe) do |output, widget|
      output << render_widget(widget)
    end
  end

  def render_widget(widget)
    render partial: widget.partial_name, locals: { widget: widget }
  end

  def get_recent_comments
    if @comments.nil?
      Comment.recent
    else
      @comments
    end
  end
end
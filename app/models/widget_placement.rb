class WidgetPlacement < ActiveRecord::Base
  attr_accessible :controller, :action, :position, :widget_id, :weight

  belongs_to :widget

  scope :for, ->(controller, action, position) do
    where('controller = ? OR controller IS NULL', controller).
    where('action = ? OR action IS NULL', action).
    where(position: position).
    order(:weight)
  end
end

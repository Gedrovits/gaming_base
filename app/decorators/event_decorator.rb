class EventDecorator < ApplicationDecorator
  delegate_all

  def type_label
    opts = case type.to_sym
           when :gaming_session then ['gamepad', 'Gaming Session', 'success']
           when :meeting then ['users', 'Meeting', 'success']
           when :mixed then ['question-circle-o', 'Mixed', 'success']
           else
             []
           end
    span_icon_with_text(opts)
  end

  def status_label
    opts = case status.to_sym
           when :draft then ['calendar-o', 'Draft', 'muted']
           when :pending then ['warning', 'Pending', 'warning']
           when :cancelled then ['calendar-times-o', 'Cancelled', 'danger']
           when :in_progress then ['progress', 'In Progress', 'warning']
           when :finished then ['calendar-check-o', 'Finished', 'success']
           when :archived then ['archive', 'Archived', 'muted']
           else
             []
           end
    span_icon_with_text(opts)
  end

  def duration_label
    h.distance_of_time_in_words(starts_at, ends_at)
  end
end

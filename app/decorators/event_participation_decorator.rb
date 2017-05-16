class EventParticipationDecorator < ApplicationDecorator
  delegate_all

  def status_label
    opts = case status.to_sym
           when :pending then ['circle-o', 'Pending', 'muted']
           when :accepted then ['check-circle-o', 'Accepted', 'success']
           when :tentative then ['question-circle-o', 'Tentative', 'warning']
           when :declined then ['times-circle-o', 'Declined', 'danger']
           else
             []
           end
    span_icon_with_text(opts)
  end
end

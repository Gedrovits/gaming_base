class MembershipDecorator < ApplicationDecorator
  delegate_all

  def status_label
    style = case status.to_sym
            when :pending then 'warning'
            when :left, :banned then 'danger'
            when :approved then 'success'
            end

    h.content_tag(:span, class: "label label-#{style}") do
      status
    end
  end
end

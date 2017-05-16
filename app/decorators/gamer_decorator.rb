class GamerDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def dedication_label
    opts = case dedication.to_sym
           when :casual then ['gamepad', 'Casual', 'muted']
           when :core then ['gamepad', 'Core', 'success']
           when :hardcore then ['gamepad', 'Hardcore', 'warning']
           when :pro then ['gamepad', 'Professional', 'danger']
           else
             []
           end
    span_icon_with_text(opts)
  end

  def sex_label
    opts = case sex.to_sym
           when :female then %w(venus Female danger)
           when :male   then %w(mars Male info)
           else
             []
           end
    span_icon_with_text(opts)
  end

  def swearing_label
    swearing_and_tolerance_label(swearing)
  end

  def swearing_tolerance_label
    swearing_and_tolerance_label(swearing_tolerance)
  end

  def weekday_availability_label
    availability_label(weekday_availability)
  end

  def weekend_availability_label
    availability_label(weekend_availability)
  end

  private

  def availability_label(field)
    opts = case field.to_sym
           when :none then ['clock-o', 'None', 'danger']
           when :morning then ['clock-o', 'Morning (06:00 to 12:00)', 'warning']
           when :noon then ['clock-o', 'Noon (12:00 to 18:00)', 'warning']
           when :evening then ['clock-o', 'Evening (18:00 to 00:00)', 'warning']
           when :night then ['clock-o', 'Night (00:00 to O6:00)', 'warning']
           when :always then ['clock-o', 'Always', 'success']
           else
             []
           end
    span_icon_with_text(opts)
  end

  def swearing_and_tolerance_label(field)
    opts = case field.to_sym
           when :none then ['check', 'None', 'success']
           when :spoken then ['warning', 'Spoken', 'warning']
           when :written then ['warning', 'Written', 'warning']
           when :spoken_and_written then ['warning', 'Spoken and Written', 'danger']
           else
             []
           end
    span_icon_with_text(opts)
  end
end

module ApplicationHelper
  def membership_status_label(m, css = '')
    case m.status.to_sym
    when :pending  then content_tag(:span, m.status, class: ['label label-warning', css].join(' '))
    when :left, :banned then content_tag(:span, m.status, class: ['label label-danger', css].join(' '))
    when :approved then content_tag(:span, m.status, class: ['label label-success', css].join(' '))
    end
  end
  
  def safe_external_link(url)
    link_to(fa_icon('external-link', text: url), url,
            data: { confirm: 'This leads to external website...' },
            rel: 'nofollow')
  end
  
  def verified_badge(verified, big = true)
    style = verified ? %w(check success) : %w(times warning)
    fa_icon("#{style[0]}-circle-o #{big ? '2x' : ''}", class: "text-#{style[1]}")
  end
  
  def yes_or_no(boolean)
    boolean ? t('Yes') : t('No')
  end
  
  def sex_label(sex)
    opts = case sex.to_sym
           when :female then %w(venus Female danger)
           when :male   then %w(mars Male info)
           else
             []
           end
    
    content_tag(:span, fa_icon(opts[0], text: opts[1]), class: "text-#{opts[2]}")
  end
  
  def dedication_label(value)
    opts = case value.to_sym
           when :casual then ['gamepad', 'Casual', 'muted']
           when :core then ['gamepad', 'Core', 'success']
           when :hardcore then ['gamepad', 'Hardcore', 'warning']
           when :pro then ['gamepad', 'Professional', 'danger']
           else
             []
           end
    content_tag(:span, fa_icon(opts[0], text: opts[1]), class: "text-#{opts[2]}")
  end
  
  def weekday_weekend_availability_label(availability)
    opts = case availability.to_sym
           when :none then ['clock-o', 'None', 'danger']
           when :morning then ['clock-o', 'Morning (06:00 to 12:00)', 'warning']
           when :noon then ['clock-o', 'Noon (12:00 to 18:00)', 'warning']
           when :evening then ['clock-o', 'Evening (18:00 to 00:00)', 'warning']
           when :night then ['clock-o', 'Night (00:00 to O6:00)', 'warning']
           when :always then ['clock-o', 'Always', 'success']
           else
             []
           end
    content_tag(:span, fa_icon(opts[0], text: opts[1]), class: "text-#{opts[2]}")
  end
  
  def swearing_and_tolerance_label(value)
    opts = case value.to_sym
           when :none then ['check', 'None', 'success']
           when :spoken then ['warning', 'Spoken', 'warning']
           when :written then ['warning', 'Written', 'warning']
           when :spoken_and_written then ['warning', 'Spoken and Written', 'danger']
           else
             []
           end
    content_tag(:span, fa_icon(opts[0], text: opts[1]), class: "text-#{opts[2]}")
  end
  
  def privacy_label(privacy)
    opts = case privacy.to_sym
           when :me_only then ['eye-slash', 'Only Myself', 'muted']
           when :team_only then ['eye', 'Only Team', 'warning']
           when :community_only then ['eye', 'Only Community', 'warning']
           when :team_or_community_only then ['eye', 'Only Team / Community', 'warning']
           when :everyone then ['eye', 'Everyone', 'success']
           else
             []
           end
    content_tag(:span, fa_icon(opts[0], text: opts[1]), class: "text-#{opts[2]}")
  end
  
  # 
  
  def team_or_community_label(model)
    if !model.abbreviation.blank?
      content_tag(:abbr, model.abbreviation, title: model.name)
    else
      model.name
    end
  end
end

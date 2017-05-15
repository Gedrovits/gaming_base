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
  
  def team_or_community_label(model)
    if !model.abbreviation.blank?
      content_tag(:abbr, model.abbreviation, title: model.name)
    else
      model.name
    end
  end
end

class ApplicationDecorator < Draper::Decorator
  # Define methods for all decorated objects.
  # Helpers are accessed through `helpers` (aka `h`). For example:
  #
  #   def percent_amount
  #     h.number_to_percentage object.amount, precision: 2
  #   end

  def privacy_label
    return unless respond_to?(:privacy)
    opts = case privacy.to_sym
           when :me_only then ['eye-slash', 'Only Myself', 'muted']
           when :team_only then ['eye', 'Only Team', 'warning']
           when :community_only then ['eye', 'Only Community', 'warning']
           when :team_or_community_only then ['eye', 'Only Team / Community', 'warning']
           when :anyone then ['eye', 'Everyone', 'success']
           else
             []
           end
    span_icon_with_text(opts)
  end

  protected

  def span_icon_with_text(opts = [])
    icon, text, style = *opts
    h.content_tag :span, class: "text-#{style}" do
      h.fa_icon(icon, text: text)
    end
  end
end

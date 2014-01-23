class TransactionTerm < ActiveRecord::Base
  belongs_to :promo_message

  validates_presence_of :terms, :effective_start_date, :effective_end_date

  def effective_start_date
    read_attribute(:effective_start_date).blank? ? Time.now : read_attribute(:effective_start_date)
  end

  def effective_start_date=(value)
    if !value.blank?
      value = value.to_time.in_time_zone(Lists::Application.config.time_zone).beginning_of_day
    end
    write_attribute(:effective_start_date, value)
  end

  def effective_end_date
    read_attribute(:effective_end_date).blank? ? Time.now : read_attribute(:effective_end_date)
  end

  def effective_end_date=(value)
    if !value.blank?
      value = value.to_time.in_time_zone(Lists::Application.config.time_zone).end_of_day
    end
    write_attribute(:effective_end_date, value)
  end
end

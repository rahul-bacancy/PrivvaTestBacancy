class Project < ApplicationRecord
  has_many :issues
  belongs_to :user

  def status
    return 'not-started' if issues.none?

    if issues.all? { |issue| issue.complete? }
      'complete'
    elsif issues.any? { |issue| issue.in_progress? || issue.complete? }
      'in-progress'
    else
      'not-started'
    end
  end

  def percent_complete
    return 0 if issues.none?
    ((total_complete.to_f / total_issues) * 100).round
  end

  def total_complete
    issues.select { |issue| issue.complete? }.count
  end

  def total_issues
    issues.count
  end
end

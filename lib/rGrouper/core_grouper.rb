module CoreGrouper
  UNDEFINED_GROUP_NAME = 'undefined'.freeze

  # @param source [Array<Hash>]
  def group(source, groupings)
    groups = source.group_by { |el| group_proc(groupings.first).call(el) || UNDEFINED_GROUP_NAME }

    groups[:totals] = summarizer.call(groups.values.flatten) if summarizer

    if groupings.count == 1
      # groups
      groups.merge(groups.reject { |k, _v| k == :totals }) do |_group, elements|
        { values: elements }.tap do |hsh|
          # totals only if more than 1 element
          hsh.merge!(totals: summarizer.call(elements)) if elements.count > 1 && summarizer
        end
      end
    else
      groups.merge(groups.reject { |k, _v| k == :totals }) do |_group, elements|
        group(elements, groupings.drop(1))
      end
    end
  end

  private
  
  # @param grouping_by [Proc,String,Symbol]
  # @return [Proc]
  def group_proc(grouping_by)
    case grouping_by
    when Symbol, String
      # Otherwise grouping_by name will be out of lambda scope
      instance_exec { ->(el) { el[grouping_by] } }
    when Proc
      grouping_by
    else
      raise 'InvalidGrouping'
    end
  end
end

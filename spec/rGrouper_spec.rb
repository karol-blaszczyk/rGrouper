require 'spec_helper'

require 'test.rb'

RSpec.describe RGrouper do
  subject { RGrouper.new }

  describe '#group' do
    let(:source) do
      [
        { cost: 10, views: 1, objective: 'itaque',  creative: 'aperiam', name: 'T006049A ' },
        { cost: 10, views: 1, objective: 'itaque',  creative: 'aperiam', name: 'F123456A ' },
        { cost: 10, views: 1, objective: 'itaque',  creative: 'aperiam', name: 'D123456A ' },
        { cost: 10, views: 1, objective: 'itaque',  creative: 'aperiam', name: 'BR123456A ' },
        { cost: 10, views: 1, objective: 'itaque',  creative: 'occaecati', name: 'F123456A ' },
        { cost: 10, views: 1, objective: 'itaque',  creative: 'occaecati', name: 'F123456A ' },
        { cost: 10, views: 1, objective: 'itaque',  creative: 'occaecati', name: 'I123456A ' },
        { cost: 10, views: 1, objective: 'itaque',  creative: 'occaecati', name: 'F123456A ' },
        { cost: 10, views: 1, objective: 'itaque',  creative: 'occaecati', name: 'F123456A ' },
        { cost: 10, views: 1, objective: 'excepturi', creative: 'occaecati', name: 'F123456A ' },
        { cost: 10, views: 1, objective: 'excepturi', creative: 'occaecati', name: 'F123456A ' },
        { cost: 10, views: 1, objective: 'excepturi', creative: 'aperiam', name: 'F123456A ' },
        { cost: 10, views: 1, objective: 'excepturi', creative: 'aperiam', name: 'F123456A ' }
      ]
    end

    let(:summarizer) do
      lambda do |metrics|
        {
          cost: metrics.map { |m| m[:cost].to_f }.reduce(&:+).round(2),
          views: metrics.map { |m| m[:views].to_f }.reduce(&:+)
        }
      end
    end

    let(:groupers) do
      [
        :objective, # objectives as Symbol
        :creative, # creatives as Symbol
        ->(el) { el[:name][/(?:T|A|F|I|BR)\d{6}[A-Z]?(?=\ )/] }
      ] # name Proc wth Regexp
    end

    it 'works' do
      result = RGrouper.new.rgroup_by(DATA,
                                      groupings: %i[age_range age_range_state ad_group_state is_negative])

      RGrouper.pritify result

      result = RGrouper.new.rgroup_by(DATA,
                                      groupings: %i[age_range age_range_state ad_group_state is_negative])
      puts "****************************************"
      result = RGrouper.new.rgroup_by(source,
                                      groupings: groupers,
                                      summarizer: summarizer
                                    )
      RGrouper.pritify result

      # subject.pritify subject.group(DATA, :age_range, :age_range_state, :ad_group_state, :is_negative)

      # subject.pritify subject.group(source, *groupers, summarizer: summarizer)
      # expect(subject.group(source, *groupers))
      #   .to eq([])
    end
  end
end

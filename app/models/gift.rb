class Gift < ActiveRecord::Base

  def from
    Family.find(self.family_id).guests.sort_by { |guest| guest.id}.map { |guest| guest.full_name}.to_sentence
  end

end

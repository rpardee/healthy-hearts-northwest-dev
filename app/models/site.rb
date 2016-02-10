class Site < ActiveRecord::Base
	has_many :partners, dependent: :destroy
	has_many :manager_notes
	has_paper_trail

	accepts_nested_attributes_for :manager_notes,
		reject_if: :topic_or_comment_missing, allow_destroy: true

	SITE_VALS = {
		"GHRI" => 0,
		"ORPRN" => 1,
		"Qualis" => 2
	}

	private

	def topic_or_comment_missing(attribute)
		attribute['manager_note_topic'].blank? ||
			attribute['manager_note_comment'].blank?
	end
end

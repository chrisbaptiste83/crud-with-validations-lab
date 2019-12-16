
    class Song < ActiveRecord::Base
        validates :name, presence: true
        validates :artist_name, presence: true
        validate :no_repeated_name
        validates :release_year, presence: true, 
            if: :released?
        validate :date_not_possible
    
        def no_repeated_name
            if Song.any? {|s| s.name == name && s.artist_name == artist_name && s.release_year == release_year}
                errors.add(:name, "can't add the same song twice")
            end
        end
    
        def date_not_possible
            if release_year.present? && release_year > Date.today.year
                errors.add(:release_year, "release year can't be in the future")
            end
        end
    
    end

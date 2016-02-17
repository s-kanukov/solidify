seed_countries = ['RU']
countries = []
Carmen::Country.all.each do |country|
  countries << {
    name: country.name,
    iso3: country.alpha_3_code,
    iso: country.alpha_2_code,
    iso_name: country.name.upcase,
    numcode: country.numeric_code,
    states_required: country.subregions?
  } if seed_countries.include?(country.alpha_2_code)
end

ActiveRecord::Base.transaction do
  Spree::Country.create!(countries)
end

Spree::Config[:default_country_id] ||= Spree::Country.find_by(iso: 'RU').id

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#

["Hull", "Bridge", "Shuttle Bay", "Engineering"].each do |location_name|
  Location.find_or_create_by_name location_name
end

main_screen = Widget.find_or_create_by_name "Main Screen", :location => Location.find_by_name("Bridge")
main_screen.features.find_or_create_by_name "Visuals"
main_screen.features.find_or_create_by_name "Audio Only"

captains_chair = Widget.find_or_create_by_name "Captain's Chair", :location => Location.find_by_name("Bridge")
captains_chair.features.find_or_create_by_name "Arm Controls"
captains_chair.features.find_or_create_by_name "Arm Controls"

turbolift = Widget.find_or_create_by_name "Turbolift", :location => Location.find_by_name("Bridge")
turbolift.features.find_or_create_by_name "Voice Activated"

phasers = Widget.find_or_create_by_name "Phasers", :location => Location.find_by_name("Hull")
phasers.features.find_or_create_by_name "Rarely effective"

photon_torpedoes = Widget.find_or_create_by_name "Photon Torpedoes", :location => Location.find_by_name("Hull")
photon_torpedoes.features.find_or_create_by_name "Antimatter" # What does antimatter have to do with photons anyway?
photon_torpedoes.features.find_or_create_by_name "Rarely have enough"

warp_core = Widget.find_or_create_by_name "Warp Core", :location => Location.find_by_name("Engineering")
warp_core.features.find_or_create_by_name "Closes subspace rifts"
warp_core.features.find_or_create_by_name "Gives you all she's got"
warp_core.features.find_or_create_by_name "Glows"

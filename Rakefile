require_relative 'lib/pubnames'

PBF_FILES=%w(
  vendor/osm/england-latest.osm.pbf
  vendor/osm/scotland-latest.osm.pbf
  vendor/osm/wales-latest.osm.pbf
)

task :default do
  Pubnames.extract_osm_files('pubnames.tsv', *PBF_FILES)
end

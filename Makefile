all: pubnames.tsv

raw.tsv: bin/extract
	ruby bin/extract \
		vendor/osm/england-latest.osm.pbf \
		vendor/osm/scotland-latest.osm.pbf \
		vendor/osm/wales-latest.osm.pbf	| sort > $@

pubnames.tsv: bin/normalize raw.tsv lib/suffixes.txt lib/prefixes.txt
	ruby bin/normalize raw.tsv | sort > $@
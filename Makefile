all: pubnames.tsv

raw.tsv: bin/extract
	ruby bin/extract \
		vendor/osm/england-latest.osm.pbf \
		vendor/osm/scotland-latest.osm.pbf \
		vendor/osm/wales-latest.osm.pbf	| sort > $@

pubnames.tsv: bin/normalize raw.tsv
	ruby bin/normalize raw.tsv | sort > $@

match.bin: match.script
	foma -f match.script

match: match.bin pubnames.tsv
	cut -f2 pubnames.tsv | flookup match.bin

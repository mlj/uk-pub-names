#!/usr/bin/env ruby
require 'pbf_parser'

module Pubnames
  def self.output_objects(lines, objs)
    objs.each do |obj|
      if obj[:tags]['amenity'] == 'pub'
        lines.push [obj[:tags]['name'], obj[:id], obj[:lat], obj[:lon]].join("\t")
      end
    end
  end

  def self.extract_osm_files(out_filename, *in_filenames)
    @lines = []

    in_filenames.each do |filename|
      puts "Reading #{filename}..."
      PbfParser.new(filename).each do |nodes, ways, relations|
        output_objects @lines, nodes
        output_objects @lines, ways
        output_objects @lines, relations
      end
    end

    File.open(out_filename, 'w') do |f|
      @lines.sort.each do |line|
        f.puts line
      end
    end
  end
end

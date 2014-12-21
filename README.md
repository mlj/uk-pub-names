# Names of pubs in the United Kingdom

This dataset lists all pubs in the United Kingdom that occur in the Open Street
Map data set.

It includes the name, the ID and the position of all nodes with [the amenity
tag pub](http://wiki.openstreetmap.org/wiki/Tag:amenity%3Dpub) in the Open
Street Map data set.

The upstream data files were downloaded from
http://download.geofabrik.de/europe/ but are not included due to their size.

`pubnames.tsv` contains the following:

Column | Contents
:----: | :-------
1      | Name from the Open Street Map data set
2      | Normalized name
3      | ID from the Open Street Map data set
4      | Latitude
5      | Longitude

The normalized name uses more consistent spelling and does not include
superfluous annotations like "closed down" or the name of the brewery that the
pub belongs to. The normalized name is on the form

    prefix|base_name|suffix

where `prefix` is one of _The_ or _Ye_, and `suffix` is one of a number of
commonly occuring words like _Inn_, _Tavern_ etc. (see `lib/suffixes.txt` for a
full list).

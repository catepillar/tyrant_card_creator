tyrant_card_creator
===================

#Requirements

Ruby (Tested with 2.0)
* Nokogiri
* open-uri

SWFTools (http://swftools.org)
* SWFdump
* SWFextract

===================

The tools are used to update to keep the HTML stuff up to date.

There are 2 provided tools.
* card_grabber.rb
    * This will download any card images that are not currently stored in the ````cards```` directory
    * It is configured to pull from the dev server.
* image_extractor.rb
    * This downloads and extracts the various images needed to make a card.
    * This uses SWFTools.
    * You have to know what ````Assets```` version you want to download.  It usually increments by one.

==================

Todo List

These are the things I inteded to do, but never got around to.

1. Use image sprites instead of individual images to reduce server load.
2. Allow users to give a URL instead of having to upload an image.
    * Requires a server sided mirror to download the image and serve it to the user.
    * Logic is simple.  Implementations already exist. I just got lazy.
3. Do more with the HTML canvas to include things like adding filters to color the background of cards.
    * Would allow fun things like creating new races.

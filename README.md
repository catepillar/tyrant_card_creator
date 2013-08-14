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
#The tools

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

#Todo List

These are the things I inteded to do, but never got around to.

1. Use image sprites instead of individual images to reduce server load.
2. Allow users to give a URL instead of having to upload an image.
    * Requires a server sided mirror to download the image and serve it to the user.
    * Logic is simple.  Implementations already exist. I just got lazy.
3. Do more with the HTML canvas to include things like adding filters to color the background of cards.
    * Would allow fun things like creating new races.

==================

I used several javascript and css sources developed by others.

The most important is JQuery.  It is developed under a MIT liscence, like my code, and should create no issues. Its code is located at https://github.com/jquery/jquery.

The second is Facebox, which is used when a user uploads a card to imgur.  It is also released under the MIT liscence and can be found at http://github.com/defunkt/facebox.  I made some minor changes to the css to better fit my page.

The third is the textchange JQuery plugin.  It is also released under a MIT liscence (I SENSE A THEME!), and its code can be found at https://gist.github.com/mkelly12/424774.

The fourth and final source is a JSON to XML converter because I was too tired to learn how JQuery's XML parsig worked.  It can be found at http://www.fyneworks.com/jquery/xml-to-json/ and is also released under a MIT Liscence.

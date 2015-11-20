#Sporting Innovations Development Homework#

##Requirements##
Display a list of basic event details from a list of events hosted on a server.

* Display all events that are featured.
* Each list item should include these event details:
  * Primary Name
  * Start date & time
  * Seconday Name
* Sort the events chronologically.
  
  
##Stretch Goal##
These optional features can be implemented if you have extra time available.

* When each event row is tapped, open a full screen view that displays:
  * Event image
  * Primary Name
  * Start date & time
  * Seconday Name
  * Description
* The view should be able to navigate back to the list view.

##Technical Design##

The event list is available by consuming this service resource:

`GET` `https://raw.githubusercontent.com/sporting-innovations/fan360-sandbox/master/service/events.json`

A token must be supplied as a query parameter:

`token` `ABmsLgpyv3oHoovLMFnqkt-HUbSkmV0hks5WWMktwA%3D%3D`

The field names should be clearly marked.
The proper event image to use is the first object in the `asset` list. Use `asset.externalId` and the `contentType` to retrieve the actual image from the following URL format:

`https://raw.githubusercontent.com/sporting-innovations/fan360-sandbox/master/service/images/[asset.externalId].[png or jpeg]`

Be sure to supply the token on the image API.

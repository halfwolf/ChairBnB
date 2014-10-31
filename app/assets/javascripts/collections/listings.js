ChairBnB.Collections.Listings = Backbone.Collection.extend({
  model: ChairBnB.Models.Listing,
  url: '/api/listings'
  
})
ChairBnB.Collections.myListings = Backbone.Collection.extend({
  model: ChairBnB.Models.Listing,
  url: '/api/myListings'
  
})
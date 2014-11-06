ChairBnB.Collections.Listings = Backbone.Collection.extend({
  model: ChairBnB.Models.Listing,
  
  url: '/api/listings',
  
  getOrFetch: function(id) {
    var listingMaybe = this.get(id);
      if (!listingMaybe) {
        listingMaybe = new ChairBnB.Models.Listing({
          id: id
        });
        
        var that = this;
        
        listingMaybe.fetch({
          success: function() {
            that.add(listingMaybe);
          }
        });
      }
      
    return listingMaybe;
  }
  
})
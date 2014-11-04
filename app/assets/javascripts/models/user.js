ChairBnB.Models.User = Backbone.Model.extend({
  urlRoot: 'api/users',
  
  
  listings: function() {
    this._listings = this._listings ||
      new ChairBnB.Collections.Listings([], { user: this });
      return this._listings
  },

  parse: function(payload) {
    if (payload.listings) {
      this.listings().set(payload.listings, {parse: true});
      delete payload.listings
    }
    
    return payload;
  }
  
  
  
  
})
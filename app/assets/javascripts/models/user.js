ChairBnB.Models.User = Backbone.Model.extend({
  url: 'api/dashboard',
  
  reservations: function() {
    this._reservations = this._reservations ||
      new ChairBnB.Collections.Reservations([], { user: this });
      return this._reservations
  },
  
  listings: function() {
    this._listings = this._listings ||
      new ChairBnB.Collections.myListings([], { user: this });
      return this._listings
  },

  reviews: function() {
    this._reviews = this._reviews ||
      new ChairBnB.Collections.Reviews([], { user: this });
      return this._reviews
  },
 //
  messages: function() {
    this._messages = this._messages ||
      new ChairBnB.Collections.Messages([], { user: this });
      return this._messages
  },
  
  parse: function(payload) {
    if (payload.reservations) {
      this.reservations().set(payload.reservations, {parse: true});
      delete payload.reservations
    }
    if (payload.listings) {
      this.listings().set(payload.listings, {parse: true});
      delete payload.listings
    }
    if (payload.reviews) {
      this.reviews().set(payload.reviews, {parse: true});
      delete payload.reviews
    }
    if (payload.messages) {
      this.messages().set(payload.messages, {parse: true});
      delete payload.messages
    }
    
    return payload;
  }
  
  
})

ChairBnB.Models.user = new ChairBnB.Models.User
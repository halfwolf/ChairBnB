ChairBnB.Routers.Router = Backbone.Router.extend({
  initialize: function() {
    this.$rootEl = $('.content');
    this.listings = new ChairBnB.Collections.Listings();
  },
  
  
  routes: {
    'listings': 'listingsIndex',
    'listings/new': 'listingNew',
    'listings/:id': 'listingShow',
    'users/:id': 'userShow',
    'dashboard': 'dashboardShow',
    'mylistings': 'myListings',
    'mymessages': 'myMessages',
    'myreservations': 'myReservations',
    'myreviews': 'myReviews'
  },
  
  listingsIndex: function() {
    this.listings.fetch();
    var view = new ChairBnB.Views.ListingsIndex({
      collection: this.listings
    })
    this._swapView(view)
  },
  
  listingShow: function(id) {
    var chair = this.listings.getOrFetch(id);
    
    var view = new ChairBnB.Views.ListingShow({
      model: chair
    })
    
    this._swapView(view)
  },
  
  listingNew: function() {
    var chair = new ChairBnB.Models.Listing()
    var view = new ChairBnB.Views.ListingForm({
      model: chair,
      collection: ChairBnB.Models.me.listings()
    });
    this._swapView(view);
  },
  
  userShow: function(id) {
    
    var user = new ChairBnB.Collections.Users().getOrFetch(id)
    
    var view = new ChairBnB.Views.UserShow({
      model: user
    })
    
    this._swapView(view)
  },
  
  dashboardShow: function() {
    ChairBnB.Models.me.fetch();
    var view = new ChairBnB.Views.DashboardShow({
      model: ChairBnB.Models.me
    });
    
    this._swapView(view);    
  },
  
  myListings: function() {
    ChairBnB.Models.me.listings().fetch();
    var view = new ChairBnB.Views.MyListings({
      collection: ChairBnB.Models.me.listings() 
    })
    
    this._swapView(view);
  },
  
  myMessages: function() {
    ChairBnB.Models.me.messages().fetch();

    var view = new ChairBnB.Views.MyMessages({
      collection: ChairBnB.Models.me.messages() 
    })
    
    this._swapView(view);
  },
  
  myReservations: function() {
    ChairBnB.Models.me.reservations().fetch();
    
    var view = new ChairBnB.Views.MyReservations({
      collection: ChairBnB.Models.me.reservations()
    })
    
    this._swapView(view);
    
  },
  
  myReviews: function() {
    ChairBnB.Models.me.reviews().fetch();
    
    var view = new ChairBnB.Views.MyReviews({
      collection: ChairBnB.Models.me.reviews()
    })
    
    this._swapView(view);
  },
  
  
  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this.currentView = view;
    this.$rootEl.html(view.render().$el);
  }
  
})
ChairBnB.Routers.Router = Backbone.Router.extend({
  initialize: function() {
    this.$rootEl = $('.content');
    this.listings = new ChairBnB.Collections.Listings();
  },
  
  
  routes: {
    'listings': 'listingsIndex',
    'listings/:id': 'listingShow',
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
  
  dashboardShow: function() {
    ChairBnB.Models.user.fetch();
    var view = new ChairBnB.Views.DashboardShow({
      model: ChairBnB.Models.user
    });
    
    this._swapView(view);    
  },
  
  myListings: function() {
    ChairBnB.Models.user.listings().fetch();
    var view = new ChairBnB.Views.MyListings({
      collection: ChairBnB.Models.user.listings() 
    })
    
    this._swapView(view);
  },
  
  myMessages: function() {
    ChairBnB.Models.user.messages().fetch();

    var view = new ChairBnB.Views.MyMessages({
      collection: ChairBnB.Models.user.messages() 
    })
    
    this._swapView(view);
  },
  
  myReservations: function() {
    ChairBnB.Models.user.reservations().fetch();
    
    var view = new ChairBnB.Views.MyReservations({
      collection: ChairBnB.Models.user.reservations()
    })
    
    this._swapView(view);
    
  },
  
  myReviews: function() {
    ChairBnB.Models.user.reviews().fetch();
    
    var view = new ChairBnB.Views.MyReviews({
      collection: ChairBnB.Models.user.reviews()
    })
    
    this._swapView(view);
  },
  
  
  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this.currentView = view;
    this.$rootEl.html(view.render().$el);
  }
  
})
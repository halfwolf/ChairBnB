ChairBnB.Routers.Router = Backbone.Router.extend({
  initialize: function() {
    this.$rootEl = $('.content');
    this.listings = new ChairBnB.Collections.Listings();
    this.listings.fetch(),
    this.bindSearchEvents()
  },
  
  events: {
    
  },
  
  
  routes: {
    'listings': 'listingsIndex',
    'search/:query': 'mapView', 
    'listings/new': 'listingNew',
    'listings/:id': 'listingShow',
    'users/:id': 'userShow',
    'dashboard': 'dashboardShow',
    'conversations': 'conversationsIndex',
    'conversations/:id': 'conversationShow',
    'mylistings': 'myListings',
    'myreservations': 'myReservations',
    'myreviews': 'myReviews'
  },
  
  bindSearchEvents: function(){
    var searchBox = $('input.search-form')
    var that = this
    searchBox.on('click', function(){      
      if (searchBox.val() === "Search...") {
        searchBox.val("");
      }
    }) 
    searchBox.keydown(function(event) {
      if (event.keyCode === 13) {
        var query = encodeURIComponent(event.currentTarget.value)
        window.location = "#/search/" + query
      }
    })

  },
  
  search: function() {
    alert("we made it")
  },
  
  mapView: function(query) {
    var location = decodeURIComponent(query)
    var listings = new ChairBnB.Collections.Listings()
    
    listings.fetch({ data:{min: "0,0", max: "0,0" }})
    var view = new ChairBnB.Views.Map({
      query: location,
      collection: listings
      })
    this._swapView(view)
    
    //{ data:{min: "-74.21539306640625,42.72280375732727", max: "-73.8720703125,42.87495770751784" }}
  },
  
  listingsIndex: function() {
    this.listings.fetch()
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
  
  conversationsIndex: function() {
    ChairBnB.Models.me.conversations().fetch();
    
    var view = new ChairBnB.Views.ConversationsIndex({
      collection: ChairBnB.Models.me.conversations()
    })
    
    this._swapView(view)
  },
  
  conversationShow: function(id) {
    var conversation = ChairBnB.Models.me.conversations().getOrFetch(id);
    
    var view = new ChairBnB.Views.ConversationShow({
      model: conversation
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
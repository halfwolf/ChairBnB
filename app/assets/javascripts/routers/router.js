ChairBnB.Routers.Router = Backbone.Router.extend({
  initialize: function() {
    this.$rootEl = $('.content')
  },
  
  
  routes: {
    '': 'dashboardShow',
    'listings': 'listingsIndex',
    'messages': 'messagesIndex',
    'reservations': 'reservationsIndex',
    'reviews': 'reviewsIndex'
  },
  
  dashboardShow: function() {
    ChairBnB.Models.user.fetch();
    
    var view = new ChairBnB.Views.DashboardShow({
      model: ChairBnB.Models.user
    });
    
    this._swapView(view);    
  },
  
  listingsIndex: function() {
    ChairBnB.Models.user.listings().fetch();
    
    var view = new ChairBnB.Views.ListingsIndex({
      collection: ChairBnB.Models.user.listings() 
    })
    
    this._swapView(view);
  },
  
  messagesIndex: function() {
    ChairBnB.Models.user.messages().fetch();

    var view = new ChairBnB.Views.MessagesIndex({
      collection: ChairBnB.Models.user.messages() 
    })
    
    this._swapView(view);
  },
  
  
  _swapView: function(view) {
    this._currentView && this._currentView.remove();
    this.currentView = view;
    this.$rootEl.html(view.render().$el);
  }
  
})
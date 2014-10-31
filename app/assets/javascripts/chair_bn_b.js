window.ChairBnB = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {
    new ChairBnB.Routers.Router
    Backbone.history.start();
  }
};



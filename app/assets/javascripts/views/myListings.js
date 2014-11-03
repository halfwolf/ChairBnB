ChairBnB.Views.MyListings = Backbone.View.extend({

  template: JST['listings/mylistings'],
  
  initialize: function() {
    this.listenTo(this.collection, "sync", this.render)
  },
  
  render: function() {
    var content = this.template({
      listings: this.collection
    });
    this.$el.html(content);
    return this
  }
  
  
})
ChairBnB.Views.MyReservations = Backbone.View.extend({
  
  template: JST['reservations/myreservations'],
  
  initialize: function() {
    this.listenTo(this.collection, "sync", this.render)
  },
  
  render: function() {
    var renderedContent = this.template({
      reservations: this.collection
    })
    
    this.$el.html(renderedContent);
    
    return this;
  }
  
})
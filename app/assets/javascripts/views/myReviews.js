ChairBnB.Views.MyReviews = Backbone.View.extend({
  template: JST['reviews/myreviews'],
  
  initialize: function() {
    this.listenTo(this.collection, "sync", this.render)
  },
  
  render: function() {
    var renderedView = this.template({
      reviews: this.collection
    });
    
    this.$el.html(renderedView);
    
    return this;
  }
  
  
})
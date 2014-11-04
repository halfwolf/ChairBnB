ChairBnB.Views.ListingsIndex = Backbone.View.extend({
 
  template: JST['listings/index'],
  
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
ChairBnB.Views.MyMessages = Backbone.View.extend({

  template: JST['messages/mymessages'],
  
  initialize: function() {
    this.listenTo(this.collection, "sync", this.render)
  },
  
  render: function() {
    var content = this.template({
      messages: this.collection
    });
    this.$el.html(content);
    return this
  }
  
  
})

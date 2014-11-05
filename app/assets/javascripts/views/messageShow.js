ChairBnB.Views.MessageShow = Backbone.View.extend({
  template: JST['messages/show'],
  
  render: function() {
    var content = this.template({
      conversation: this.model
    })
    this.$el.html(content);
    
    return this
  }
  
  
})
ChairBnB.Views.ConversationsIndex = Backbone.View.extend({

  template: JST['conversations/index'],

  initialize: function() {
    this.listenTo(this.collection, "sync", this.render)
  },

  render: function() {
    var content = this.template({
      conversations: this.collection
    });
    this.$el.html(content);
    return this
  }


})

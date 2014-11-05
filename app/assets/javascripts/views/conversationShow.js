ChairBnB.Views.ConversationShow = Backbone.View.extend({
  template: JST['conversations/show'],
  
  initialize: function() {
    this.listenTo(this.model, "sync", this.render),
    this.listenTo(this.model.messages(), "add", this.render)
  },
  
  events: {
    'submit': 'create'
  },
  
  create: function(event) {
    event.preventDefault();
    var newMessage = new ChairBnB.Models.Message({
      subject: this.$('#subject').val(),
      body: this.$('#body').val(),
      receiver_id: this.model.id
    })
    
    var that = this;
    this.model.messages().create(newMessage)
  },
  
  render: function() {
    var content = this.template({
      conversation: this.model
    })
    this.$el.html(content);
    return this
  }
  
  
})


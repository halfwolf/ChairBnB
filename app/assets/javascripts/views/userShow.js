ChairBnB.Views.UserShow = Backbone.View.extend({
  template: JST['users/show'],

  initialize: function() {
    this.listenTo(this.model, "sync", this.render)
  },
  
  events: {
    'click button.user-show-new-message': 'renderForm',
    'click span.modal-close': 'closeForm',
    'click button.send-message': 'sendMessage'
    
  },
  
  render: function() {
    
    var content = this.template({
      user: this.model
    })
    this.$el.html(content)
    
    return this
  },
  
  renderForm: function(event) {
    event.preventDefault();
    var form = JST['users/message']
    this.$('div.message-form').html(form);
  },
  
  closeForm: function() {
    this.$('div.message-form').html("")
  },
  
  sendMessage: function(event) {
    event.preventDefault();
    
    var newMessage = new ChairBnB.Models.Message({
      subject: this.$('#subject').val(),
      body: this.$('#body').val(),
      receiver_id: this.model.id
    })
    var that = this;
    ChairBnB.Models.me.messages().create(newMessage)
    
    this.closeForm()
  }
  
})
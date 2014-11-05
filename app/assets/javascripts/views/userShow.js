ChairBnB.Views.UserShow = Backbone.View.extend({
  template: JST['users/show'],

  initialize: function() {
    this.listenTo(this.model, "sync", this.render)
  },
  
  events: {
    'click button.user-show-new-message': 'renderForm'
  },
  
  render: function() {
    
    var content = this.template({
      user: this.model
    })
    this.$el.html(content)
    
    return this
  },
  
  renderForm: function(event) {
    var form = JST['users/message']
    this.$('div.message-form').html(form);
  }
  
})
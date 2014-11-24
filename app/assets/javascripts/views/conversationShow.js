ChairBnB.Views.ConversationShow = Backbone.View.extend({
  template: JST['conversations/show'],

  initialize: function() {
    this.listenTo(this.model, "sync", this.render),
    this.listenTo(this.model.messages(), "add", this.render)
  },

  tagName: "section",

  className: "conversation-show",

  events: {
    'submit': 'create'
  },

  create: function(event) {
    event.preventDefault();
    var newMessage = new ChairBnB.Models.Message({
      subject: this.$('#subject').val(),
      body: this.$('#body').val(),
      receiver_id: this.model.id,
      author_pic: this.model.attributes.self_pic,
      author_id: this.model.attributes.self_id

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

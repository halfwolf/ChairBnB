ChairBnB.Models.Conversation = Backbone.Model.extend({
  urlRoot: 'api/conversations',

  messages: function() {
    this._messages = this._messages ||
      new ChairBnB.Collections.Messages([], {conversation: this});
      return this._messages
  },

  parse: function(payload) {
    if (payload.messages) {
      this.messages().set(payload.messages, {parse: true});
      delete payload.messages
    }
    
    return payload;
  }
  
})
ChairBnB.Collections.Conversations = Backbone.Collection.extend({
  model: ChairBnB.Models.Conversation,

  url: 'api/conversations',
  
  getOrFetch: function(id) {
    var conversationMaybe = this.get(id);
    
    if (!conversationMaybe) {
      conversationMaybe = new ChairBnB.Models.Conversation({
        id: id
      });
      
      var that = this;
      
      conversationMaybe.fetch({
        success: function() {
          that.add(conversationMaybe);
        }
      });
    } else {
      conversationMaybe.fetch();
    }
      
    return conversationMaybe;
  }
  
})
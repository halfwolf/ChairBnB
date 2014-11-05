ChairBnB.Collections.Messages = Backbone.Collection.extend({
  model: ChairBnB.Models.Message,
  
  url: '/api/messages',
  
  getOrFetch: function(id) {
    var messageMaybe = this.get(id);
      if (!messageMaybe) {
        messageMaybe = new ChairBnB.Models.Message({
          id: id
        });
        
        var that = this;
        
        messageMaybe.fetch({
          success: function() {
            that.add(messageMaybe);
          }
        });
      }
      
    return messageMaybe;
  }
  
})
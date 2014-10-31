ChairBnB.Collections.Messages = Backbone.Collection.extend({
  model: ChairBnB.Models.Message,
  
  url: '/api/messages'
})
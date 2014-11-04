ChairBnB.Collections.Users = Backbone.Collection.extend({
  url: 'api/users',
  
  getOrFetch: function(id) {
    var userMaybe = this.get(id);
      if (!userMaybe) {
        userMaybe = new ChairBnB.Models.User({
          id: id
        });
        
        var that = this;
        
        userMaybe.fetch({
          success: function() {
            that.add(userMaybe);
          }
        });
      }
      
    return userMaybe;
  }
  
  
  
})
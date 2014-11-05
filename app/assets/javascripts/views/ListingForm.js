ChairBnB.Views.ListingForm = Backbone.View.extend({
  template: JST['listings/form'],
  
  events: {
    'submit': 'create'
  },
  
  create: function(event) {
    event.preventDefault();
    var newListing = new ChairBnB.Models.Listing({ 
      room_type: this.$('#room_type').val(),
      chair_type: this.$('#chair_type').val(),
      seats: this.$('#seats').val(),
      street: this.$('#street').val(),
      city: this.$('#city').val(),
      zip_code: this.$('#zip_code').val(),
      name: this.$('#name').val(),
      description: this.$('textarea').val(),
      price: this.$('#price').val(),
      picture: this.$('#photo_image').val()
    });
    var that = this
    this.collection.create(newListing, { success: function() {
        Backbone.history.navigate("#/listings/"+ that.collection.last().id, true)
      }
    });
    
  },
  
  render: function() {
    var content = this.template({
      listing: this.model
    })
    this.$el.html(content)
    
    return this
  }
  
  
  
})
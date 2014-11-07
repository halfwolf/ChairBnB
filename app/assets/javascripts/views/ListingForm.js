ChairBnB.Views.ListingForm = Backbone.View.extend({
  template: JST['listings/form'],
  
  events: {
    'submit': 'create',
    'change #photo_image': 'bindPicture'
    
  },
  
  initialize: function() {
    this.picture = null
  },
  
  bindPicture: function(event) {
    var reader = new FileReader()
    var redFile = {}
    var that = this
    reader.onloadend = function() {
      that.picture = reader.result
      debugger
      $('div.image-preview').html("<img src="+that.picture + ">")
    }
    reader.readAsDataURL(event.currentTarget.files[0])
    
  },
  
  create: function(event) {    
    event.preventDefault();
    var params = { 
        listing: {
          room_type: this.$('#room_type').val(),
          chair_type: this.$('#chair_type').val(),
          seats: this.$('#seats').val(),
          street: this.$('#street').val(),
          city: this.$('#city').val(),
          zip_code: this.$('#zip_code').val(),
          name: this.$('#name').val(),
          description: this.$('textarea').val(),
          price: this.$('#price').val(),
          pic: this.picture
        }
      }

    var newListing = new ChairBnB.Models.Listing(params);
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
    // this.$('#photo_image').change(this.bindPicture)
    
    return this
  }
  
  
  
})
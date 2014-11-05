ChairBnB.Views.MyReservations = Backbone.View.extend({
  
  template: JST['reservations/myreservations'],
  
  events: {
    'click button.review': 'reviewForm',
    'click button.submit-review': 'submitReview',
        'click span.modal-close': 'closeForm',
  },
  
  initialize: function() {
    this.listenTo(this.collection, "sync", this.render)
  },
  
  render: function() {
    var renderedContent = this.template({
      reservations: this.collection
    })
    
    this.$el.html(renderedContent);
    
    return this;
  },
  
  reviewForm: function(event) {
    event.preventDefault();
    this.resId = event.currentTarget.id
    var form = JST['reservations/review']
    this.$('div.review-form').html(form);
  },
  
  submitReview: function(event) {
    event.preventDefault();
    debugger  
    var newReview = new ChairBnB.Models.Review({
      title: this.$('#title').val(),
      body: this.$('#body').val(),
      rating: this.$('#rating').val(),
      reservation_id: this.resId
    })
    var that = this;
    ChairBnB.Models.me.reviews().create(newReview)
    this.resId = null
    this.render()
  },
  
  closeForm: function() {
    this.$('div.review-form').html("")
    this.resId = null
  }
  
  
})
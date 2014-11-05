ChairBnB.Views.ListingShow = Backbone.View.extend({
  template: JST['listings/show'],
  
  initialize: function() {
    this.listenTo(this.model, "sync change request", this.render)
  },
  
  events: {
    'click button.place-res': 'submitReservation'
  },
  
  render: function() {
    var content = this.template({
      listing: this.model
    });
    this.$el.html(content);
    return this
  },
  
  submitReservation: function(event) {
    event.preventDefault();
     var newReservation = new ChairBnB.Models.Reservation({
      start_date: this.$('#start_date').val(),
      end_date: this.$('#end_date').val(),
      chair_id: this.model.id
    })
    var that = this;
    ChairBnB.Models.me.reservations().create(newReservation)
    
  }

})
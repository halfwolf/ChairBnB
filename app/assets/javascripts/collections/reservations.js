ChairBnB.Collections.Reservations = Backbone.Collection.extend({
  model: ChairBnB.Models.Reservation,
  
  url: '/api/reservations'
})
ChairBnB.Collections.Reviews = Backbone.Collection.extend({
  model: ChairBnB.Models.Review,
  
  url: '/api/reviews'
  
})
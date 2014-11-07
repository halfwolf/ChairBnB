ChairBnB.Views.ListingsIndex = Backbone.View.extend({
 
  template: JST['listings/index'],
  
  initialize: function() {
    this.listenTo(this.collection, "sync", this.render)
  },
  
  render: function() {
    var content = this.template({
      listings: this.collection
    });
    this.$el.html(content);
    
    if (this.collection.length < 5 && this.page) {
      this.$('div.page-navigation').html('<a class="prev" href="#">PREV</a>')
    } else if (this.page) {
      this.$('div.page-navigation').html('<a class="prev" href="#">PREV</a>')
      this.$('div.page-navigation').append('<a class="next" href="#">NEXT</a>')
    } else if (this.collection.length === 5) {
      this.$('div.page-navigation').html('<a class="next" href="#">NEXT</a>')
    }
    
    
    
    return this
  },
  
  events: {
    "click a.next": "nextPage",
    "click a.prev": "prevPage"
  },
  
  prevPage: function() {
    this.page --;
    this.collection.fetch({
          data: {
            min: this.min,
            max: this.max,
            page: this.page
          }
        })
  },
  
  nextPage: function() {
    if (!this.page) {
      this.page = 1;
    }
    this.page ++;
    this.collection.fetch({
          data: {
            min: this.min,
            max: this.max,
            page: this.page
          }
        })
    
  }
  
  
  
})
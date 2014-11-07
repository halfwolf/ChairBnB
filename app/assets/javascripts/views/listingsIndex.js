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
    
    if (this.collection.length < 5 && this.queryParams.page !== 1) {
      this.$('div.page-navigation').html('<a class="prev" href="#">PREV</a>')
    } else if (this.queryParams.page !== 1) {
      this.$('div.page-navigation').html('<a class="prev" href="#">PREV</a>')
      this.$('div.page-navigation').append('<a class="next" href="#">NEXT</a>')
    } else if (this.collection.length === 5) {
      this.$('div.page-navigation').html('<a class="next" href="#">NEXT</a>')
    }
    

    this.$('input[type=radio]').removeAttr("checked")
    
    for (var key in this.searchFunctions) {
      if( this.searchFunctions[key] === this.queryParams.sort) {
        this.$('input[type=radio][value='+ key +']').attr('checked', 'checked')
      }
      
    }
    
    
    return this
  },
  
  // is this insecure?
  searchFunctions: {
    "0": "review_score DESC",
    "1": "price DESC",
    "2": "price ASC"
  },
  

  events: {
    "click a.next": "nextPage",
    "click a.prev": "prevPage",
    "change input[name=search-by]": 'changeSort'
  },
  
  queryParams: {
    page: 1,
    sort: "review_score DESC" 
    
  },
  
  changeSort: function() {
  this.queryParams.sort =  this.searchFunctions[$('input[type=radio]:checked').val()]
  this.collection.fetch({
        data: this.queryParams
      })
  },
  // can we take out these queries into a default?
  prevPage: function() {
    this.queryParams.page --;
    this.collection.fetch({
          data: this.queryParams
        })
  },
  
  nextPage: function() {
    this.queryParams.page ++;
    this.collection.fetch({
          data: this.queryParams
        })
  }
  
  
  
})
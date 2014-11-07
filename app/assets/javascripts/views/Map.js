ChairBnB.Views.Map = Backbone.View.extend({
  template: JST['listings/map'],
  
  initialize: function(options) {
    this.query_loc = options.query,
    this.collection = options.collection,
    this.listenToOnce(this.collection, "sync", this.renderMap)
  },
  
  tagName: "section",
  
  className: "map-listings", 
  
  events: {
    "click a.next": "nextPage",
    "click a.prev": "prevPage",
    "change input[name=search-by]": 'changeSort'
  },
  
  prevPage: function() {
    this.queryParams.page --;
    this.collection.fetch({
          data: {
            min: this.min,
            max: this.max,
            page: this.queryParams.page,
            sort: this.queryParams.sort
          }
        })
  },
  
  nextPage: function() {
    this.queryParams.page ++;
    this.collection.fetch({
          data: {
            min: this.min,
            max: this.max,
            page: this.queryParams.page,
            sort: this.queryParams.sort
          }
        })
    
  },
  
  render: function() {
    var content = this.template();
    this.$el.html(content);
    return this
  },
  
  getNearbyListings: function(bounds) {
    this.min = bounds._southWest.lng + "," + bounds._southWest.lat
    this.max = bounds._northEast.lng + "," + bounds._northEast.lat
    this.listenTo(this.collection, "sync", this.renderListings)
    this.collection.fetch({ data: {min: this.min, max: this.max} });

  },
  
  renderMap: function(){
    L.mapbox.accessToken = 'pk.eyJ1IjoiaGFsZndvbGYiLCJhIjoiUVpWaXlDWSJ9.kvcLkkaZr_MlAvbLD_FDOQ';

    var geocoder = L.mapbox.geocoder('mapbox.places-v1'),
        map = L.mapbox.map('map', 'examples.map-h67hf2ic');
    
    this.newmap = map;
    var that = this
    geocoder.query(this.query_loc.toString(), showMap);
    
    function showMap(err, data) {
        if (data.lbounds) {
            map.fitBounds(data.lbounds);
            that.getNearbyListings(map.getBounds());
        } else if (data.latlng) {
            map.setView([data.latlng[0], data.latlng[1]], 13);
            that.getNearbyListings(map.getBounds());
        }
    }
  },
  
  renderListings: function(collection) {
    // add a different render to show "No listings :("
    var listingTemplate = JST['listings/bounded'];
    var listings = listingTemplate({listings: collection})
    this.$('div.bounded-listings').html(listings)
    if (collection.length < 5 && this.page) {
      this.$('div.page-navigation').html('<a class="prev" href="#">PREV</a>')
    } else if (this.page) {
      this.$('div.page-navigation').html('<a class="prev" href="#">PREV</a>')
      this.$('div.page-navigation').append('<a class="next" href="#">NEXT</a>')
    } else if (collection.length === 5) {
      this.$('div.page-navigation').html('<a class="next" href="#">NEXT</a>')
    }
    
    this.$('input[type=radio]').removeAttr("checked")
    
    for (var key in this.searchFunctions) {
      if( this.searchFunctions[key] === this.queryParams.sort) {
        this.$('input[type=radio][value='+ key +']').attr('checked', 'checked')
      }
      
    }
      
    var map = this.newmap;
    var objects = [];
    collection.each(function(chair){
      objects.push(chair.attributes.geoJSON)
    })
    map.featureLayer.setGeoJSON(objects)
    
  },
  searchFunctions: {
    "0": "review_score DESC",
    "1": "price DESC",
    "2": "price ASC"
  },
  
  queryParams: {
    page: 1,
    sort: "review_score DESC" 
    
  },
  
  changeSort: function() {
  this.queryParams.sort =  this.searchFunctions[$('input[type=radio]:checked').val()]
  this.collection.fetch({
        data: { 
          page: this.queryParams.page,
          sort: this.queryParams.sort,
          min: this.min,
          max: this.max
        }
      })
  },
  
  
  
  
    
})
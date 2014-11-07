ChairBnB.Views.Map = Backbone.View.extend({
  template: JST['listings/map'],
  
  initialize: function(options) {
    this.query_loc = options.query,
    this.collection = options.collection,
    this.listenToOnce(this.collection, "sync", this.renderMap)
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
    
    var map = this.newmap;
    var objects = [];
    collection.each(function(chair){
      objects.push(chair.attributes.geoJSON)
    })
    map.featureLayer.setGeoJSON(objects)
    
  }
    
})
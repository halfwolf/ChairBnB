ChairBnB.Models.Reservation = Backbone.Model.extend({
  
  price: function() {
    var startDate = new Date(this.attributes.start_date)
    var endDate = new Date(this.attributes.end_date)
    return ((endDate - startDate) / 3600000) * this.attributes.price
  },
  
  formattedDate: function(dateUnformatted) {
    var date = new Date(dateUnformatted);
    var dateString = date.toDateString();
    var hour = date.getHours();
    hour = (hour > 11 ? hour - 12 : hour)
    var min = date.getMinutes();
    min = (min < 10 ? "0" + min : min)
    var period = (date.getHours > 12 ? "AM" : "PM")
    return hour + ":" + min + " " + period + " on " + dateString
  },
  
  endDate: function() {
    
  }
})
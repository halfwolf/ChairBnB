ChairBnB.Views.DashboardShow = Backbone.View.extend({

  template: JST['dashboard/show'],
  
  render: function() {
    var content = this.template({
      current_user: this.model
    });
    this.$el.html(content);
    return this
  }
  
  
})
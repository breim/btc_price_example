App.room = App.cable.subscriptions.create({
  channel: "WebNotificationsChannel"
}, {
  connected: function() {
    console.log('connected');
  },
  received: function(data) {
    document.getElementById("price").innerHTML = data['data'].price;
  }
});
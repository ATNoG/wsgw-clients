class WSGW {
  constructor(url) {
    this.ws = new WebSocket(url);
    this.ws.open = function() {
      console.
    }
  }

  subscribe(topic) {
    ws.send();
  }

  onMessage(handler) {
    this.handler = handler;
  }
}

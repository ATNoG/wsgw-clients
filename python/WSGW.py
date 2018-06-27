import socket
import json

class WSGW:
    def __init__(self, ip, port):
        self.socket = socket.socket(socket.AF_INET,socket.SOCK_DGRAM)
        self.socket.bind(('', 0))
        self.gw = (ip, port)

    def subscribe(self, topic):
        msg = {'type':'sub', 'topic':topic}
        self.socket.sendto(json.dumps(msg).encode(), self.gw)

    def publish(self, topic, ts, data):
        msg = {'type':'pub', 'topic':topic, 'ts':ts, 'data':data}
        self.socket.sendto(json.dumps(msg).encode(), self.gw)

    def recv(self):
        data = self.socket.recv(128)
        return json.loads(data.decode())

    def __str__(self):
        return 'WSGW client '+str(self.gw)+' '+str(self.socket)

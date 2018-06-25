classdef WSGW
  properties
    u;
    a = 'localhost';
    p = 0;
  endproperties
  
  methods
    function obj = WSGW(address, port)
      obj.u = udp(address, port);
      obj.a = address;
      obj.p = port;
      fopen(obj.u);
    endfunction
    
    function subscribe(obj, topic)
      data = struct('type', 'sub', 'topic', topic);
      numbytes = fprintf(obj.u, savejson('', data));
    endfunction
    
    function publish(obj, topic, ts, data)
      data = struct('type', 'sub', 'topic', topic, 'ts', ts, 'data', data);
      numbytes = fprintf(obj.u, savejson('', data));
    endfunction
    
    function close(obj)
      fclose(obj.u);
    endfunction
    
    function disp (obj)
      printf('WSGW (%s, %d)\n', obj.a, obj.p);
    endfunction
  endmethods
endclassdef

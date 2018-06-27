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
      fwrite(obj.u, savejson('', data));
    endfunction
    
    function publish(obj, topic, ts, data)
      data = struct('type', 'pub', 'topic', topic, 'ts', ts, 'data', data);
      fwrite(obj.u, savejson('', data));
    endfunction

    function msg = recv(obj)
      done = false;
      count = 0;
      msg = "";
      while(!done)
        [data, count] = fread(obj.u, 1);
        data
        count
        msg = strcat(msg, char(data));
        msg
        if(msg(length(msg)) == '{')
          count = count + 1;
        endif
        if(msg(length(msg)) == '}')
          count = count - 1;
        endif
        if(count == 0)
          done = true;
        endif
      endwhile
    endfunction
    
    function close(obj)
      fclose(obj.u);
    endfunction
    
    function disp (obj)
      printf('WSGW (%s, %d)\n', obj.a, obj.p);
    endfunction
  endmethods
endclassdef

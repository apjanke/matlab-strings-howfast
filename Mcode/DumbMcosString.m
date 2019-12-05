classdef DumbMcosString
  % A naive implementation of string arrays using user-level MCOS stuff
  %
  % This is just an MCOS wrapper on top of a cellstr. It does not support
  % the special "missing" indicator (yet).
  %
  % You should never use a class like this in your own code! Just use
  % Matlab's own string array instead. This class exists just to provide
  % a way to test the native string array's performance against the MCOS
  % mechanism.
  %
  % NOTE: This implementation is very incomplete! It is a planar-organized
  % object, but it omits implementations for most of the 
  % structural-manipulation methods that make that work, so if you try to
  % do stuff like catting arrays or whatever, it will corrupt your data.
  % Only the methods needed for our particular benchmarks are implemented!
  % Do not write a class like this for your own production code!
  
  %#ok<*STOUT>
  %#ok<*INUSD>

  properties
    % The underlying cellstrs this object is wrapping
    strs = {''};
  end
  
  methods
    function this = DumbMcosString(in)
      if ischar(in)
        strs = cellstr(in);
      elseif iscellstr(in) %#ok<ISCLSTR>
        strs = in;
      elseif isa(in, 'string')
        strs = cellstr(in);
      else
        error('Invalid input: in must be char or cellstr; got %s', ...
          class(in));
      end
      this.strs = strs;
    end
    
    % Semantic string operations
    
    function [tf, loc] = ismember(a, b)
      [a, b] = promote(a, b);
      [tf, loc] = ismember(a.strs, b.strs);
    end
    
    function out = eq(a, b)
      [a, b] = promote(a, b);
      out = strcmp(a.strs, b.strs);
    end
    
    function out = ne(a, b)
      out = ~eq(a, b);
    end
    
    function out = lt(a, b)
      error('Not implemented. Sorry!')
    end
    
    function out = le(a, b)
      error('Not implemented. Sorry!')
    end
    
    function out = gt(a, b)
      error('Not implemented. Sorry!')
    end
    
    function out = ge(a, b)
      error('Not implemented. Sorry!')
    end
    
    function out = strcmp(a, b)
      [a, b] = promote(a, b);
      out = strcmp(a.strs, b.strs);
    end
    
    function [out, ix] = sort(this)
      [sorted_strs, ix] = sort(this.strs);
      out = DumbMcosString(sorted_strs);
    end
    
    function [out, ix] = unique(this)
      [uq_strs, ix] = unique(this.strs);
      out = DumbMcosString(uq_strs);
    end
        
    % Structural planar-organized object boilerplate stuff
    
    function out = size(this)
      out = size(this.strs);
    end
    
    function out = numel(this)
      out = numel(this.strs);
    end
    
    function out = ndims(this)
      out = ndims(this.strs);
    end
    
    function out = length(this)
      out = length(this.strs);
    end
    
  end
  
  
end

function [a, b] = promote(a, b)
if ~isa(a, 'DumbMcosString')
  a = DumbMcosString(a);
end
if nargin > 1
  if ~isa(a, 'DumbMcosString')
    b = DumbMcosString(b);
  end  
end
end


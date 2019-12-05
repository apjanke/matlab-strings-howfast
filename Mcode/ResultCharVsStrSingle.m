classdef ResultCharVsStrSingle
  % The results of a single test run for char vs string vs dumb MCOS class

  properties
    % Name of the benchmark being performed
    name char = '<UNDEFINED>'
    % Time per call for chars
    te_char double
    % Time per call for strings
    te_str double
    % Time per call for dumb MCOS string class
    te_mcos double
  end
  
  methods
    function this = ResultCharVsStrSingle(name, te_char, te_str, te_mcos)
      if nargin == 0
        return
      end
      this.name = name;
      this.te_char = te_char;
      this.te_str = te_str;
      this.te_mcos = te_mcos;
    end
    
    function out = condense_one_d(this, ns)
      % Condense multiple runs across one fixture variable
      %
      % ns is an array of the single fixture parameter N, with elements
      % corresponding to this(i).
      %
      % No input validation is done. You take responsibility.
      
      u_names = unique({this.name});
      if numel(u_names) > 1
        error('Cannot mix results from tests with different names');
      end
      
      out = ResultsCharVsStrOneD;
      out.name = this(1).name;
      out.n = ns;
      out.te_char = [this.te_char];
      out.te_str = [this.te_str];
      out.te_mcos = [this.te_mcos];
    end
  end
end
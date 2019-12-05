classdef ResultsCharVsStrOneD
  % Results of multiple test runs that varied over a single parameter
  %
  % The parameter is called n; this can be any number that governs an
  % aspect of the input/fixture data sets.
  %
  % This object records the values for n, and the corresponding test times.
  %
  % The property n is the different values for n. te_char, te_str, and
  % te_mcos are all vectors of the same size as n. te_char(i), te_str(i),
  % and te_mcos(i) hold the elapsed time for input with parameter n = n(i).
  %
  % All the property values in this object should be row vectors.

  %#ok<*NASGU>

  properties
    % Name of the test
    name char = '<UNDEFINED>'
    % The values for the parameter n
    n double
    % Time per call for chars
    te_char double
    % Time per call for strings
    te_str double
    % Time per call for dumb MCOS string class
    te_mcos double
  end
  
  properties (Dependent = true)
    str_win_ratio
  end
  
  methods
    function plot(this)
      fig = figure;
      hax = gca;
      y_vals = [this.te_char; this.te_str; this.te_mcos]';
      plot(hax, this.n, y_vals);
      title(this.name, 'Interpreter','none');
      legend({'char', 'string', 'MCOS'});
      xlabel('N');
      ylabel('time per call');
    end
    
    function out = get.str_win_ratio(this)
      out = (this.te_char - this.te_str) ./ this.te_char;
    end
    
    function out = table(this)
      out = table(this.n(:), this.te_char(:), this.te_str(:), this.te_mcos(:), ...
        this.str_win_ratio(:), ...
        'VariableNames', {'n','char','str','mcos', 'str_win_ratio'});
    end
    
    function disp(this)
      disp(table(this));
    end
  end
end
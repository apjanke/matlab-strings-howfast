classdef BenchStringsIdentity
  % Benchmarks for identity-comparison tests for strings/cellstr/MCOS
  %
  % This class is for identity-comparison tests. "Identity comparison"
  % means tests for whether two things (array elements) have the exact
  % same value. (Maybe we'll throw case-insensitive comparisons in here
  % too, eventually.) That means stuff like ==, strcmp, ismember, setdiff,
  % sort, unique, etc.
  %
  % Tests in this class vary in their fixtures by at most one numeric
  % (integer) dimension, which we call n_haystack.
  %
  % Examples:
  %
  % b = BenchStringsIdentity;
  %
  % rslt1 = b.bench_ismember_one_last
  %
  % rslt2 = b.sweep_haystack_for_test('ismember_one_last')
  % plot(rslt2)
  %
  % rslt3 = b.sweep_haystack_for_test('eq_one_vs_many')
  % plot(rslt3)
  
  %#ok<*PROP>
  %#ok<*NASGU>
  %#ok<*ASGLU>

  % User-definable parameters for the test
  properties
    % Number of times to run the individual tested function
    n_iters = 1000;
    % Length of all strings in the test fixture
    string_length = 42;
    % Number of strings in the "haystack" (array to search through)
    n_haystack = 1000;
    % Different values to use for n_haystack during fixture "sweeps"
    haystack_sizes = [1 2 3 5 10 50 100 200 500 1000 2000 5000 10000 ...
      15000 20000];
  end
  
  % Internal state of the benchmark object; don't modify these
  properties
    alphabet = [('a':'z') ('A':'Z')];
    haystack
  end
  
  methods
    function this = prep_inputs(this)
      n_alpha = numel(this.alphabet);
      hay = cell(1, this.n_haystack);
      for i = 1:this.n_haystack
        ix_letters = randi(n_alpha, 1, this.string_length);
        hay{i} = this.alphabet(ix_letters);
      end
      this.haystack = hay;
    end
    
    function out = sweep_haystack_for_test(this, test_name)
      fcn_name = ['bench_' test_name];
      n = numel(this.haystack_sizes);
      rslts = repmat(ResultCharVsStrSingle, [1 n]);
      for i = 1:n
        obj = this;
        obj.n_haystack = this.haystack_sizes(i);
        rslts(i) = feval(fcn_name, obj);
      end
      out = rslts.condense_one_d(this.haystack_sizes);
    end
    
    function out = bench_ismember_one_last(this)
      % Test ismember(a, b) for scalar a against n-long b
      %
      % where the needle is at the end of the haystack
      
      % Generate inputs
      this = prep_inputs(this);
      base_needle = this.haystack(end);
      base_haystack = this.haystack;
      n_iters = this.n_iters;
      
      % Run tests
      needle = base_needle;
      haystack = base_haystack;
      t0 = tic;
      for i_iter = 1:n_iters
        trash = ismember(needle, haystack);
      end
      te_char = toc(t0);
      
      needle = string(base_needle);
      haystack = string(base_haystack);
      t0 = tic;
      for i_iter = 1:n_iters
        trash = ismember(needle, haystack);
      end
      te_string = toc(t0);
      
      needle = DumbMcosString(base_needle);
      haystack = DumbMcosString(base_haystack);
      t0 = tic;
      for i_iter = 1:n_iters
        trash = ismember(needle, haystack);
      end
      te_mcos = toc(t0);
      
      % Package output
      stk = dbstack;
      fcn_name = regexprep(stk(1).name, '.*\.', '');
      test_name = regexprep(fcn_name, '^bench_', '');
      out = ResultCharVsStrSingle(test_name, ...
        te_char/n_iters, te_string/n_iters, te_mcos/n_iters);
    end
    
    function out = bench_ismember_one_first(this)
      % Test ismember(a, b) for scalar a against n-long b
      %
      % where the needle is at the beginningof the haystack
      
      % Generate inputs
      this = prep_inputs(this);
      base_needle = this.haystack(1);
      base_haystack = this.haystack;
      n_iters = this.n_iters;
      
      % Run tests
      needle = base_needle;
      haystack = base_haystack;
      t0 = tic;
      for i_iter = 1:n_iters
        trash = ismember(needle, haystack);
      end
      te_char = toc(t0);
      
      needle = string(base_needle);
      haystack = string(base_haystack);
      t0 = tic;
      for i_iter = 1:n_iters
        trash = ismember(needle, haystack);
      end
      te_string = toc(t0);
      
      needle = DumbMcosString(base_needle);
      haystack = DumbMcosString(base_haystack);
      t0 = tic;
      for i_iter = 1:n_iters
        trash = ismember(needle, haystack);
      end
      te_mcos = toc(t0);
      
      % Package output
      stk = dbstack;
      fcn_name = regexprep(stk(1).name, '.*\.', '');
      test_name = regexprep(fcn_name, '^bench_', '');
      out = ResultCharVsStrSingle(test_name, ...
        te_char/n_iters, te_string/n_iters, te_mcos/n_iters);
    end
    
    function out = bench_eq_one_vs_many(this)
      % Test a == b for scalar a vs large b
      %
      % where the needle is at the beginning of the haystack
      
      % Generate inputs
      this = prep_inputs(this);
      base_needle = this.haystack(1);
      base_haystack = this.haystack;
      n_iters = this.n_iters;
      
      % Run tests
      needle = base_needle;
      haystack = base_haystack;
      t0 = tic;
      for i_iter = 1:n_iters
        trash = strcmp(needle, haystack);
      end
      te_char = toc(t0);
      
      needle = string(base_needle);
      haystack = string(base_haystack);
      t0 = tic;
      for i_iter = 1:n_iters
        trash = needle == haystack;
      end
      te_string = toc(t0);
      
      needle = DumbMcosString(base_needle);
      haystack = DumbMcosString(base_haystack);
      t0 = tic;
      for i_iter = 1:n_iters
        trash = needle == haystack;
      end
      te_mcos = toc(t0);
      
      % Package output
      stk = dbstack;
      fcn_name = regexprep(stk(1).name, '.*\.', '');
      test_name = regexprep(fcn_name, '^bench_', '');
      out = ResultCharVsStrSingle(test_name, ...
        te_char/n_iters, te_string/n_iters, te_mcos/n_iters);
    end
    
    function out = bench_unique(this)
      % Test unique(b)
      
      % Generate inputs
      this = prep_inputs(this);
      base_needle = this.haystack(1);
      base_haystack = this.haystack;
      n_iters = this.n_iters;
      
      % Run tests
      needle = base_needle;
      haystack = base_haystack;
      t0 = tic;
      for i_iter = 1:n_iters
        [trash1, trash2] = unique(haystack);
      end
      te_char = toc(t0);
      
      needle = string(base_needle);
      haystack = string(base_haystack);
      t0 = tic;
      for i_iter = 1:n_iters
        [trash1, trash2] = unique(haystack);
      end
      te_string = toc(t0);
      
      needle = DumbMcosString(base_needle);
      haystack = DumbMcosString(base_haystack);
      t0 = tic;
      for i_iter = 1:n_iters
        [trash1, trash2] = unique(haystack);
      end
      te_mcos = toc(t0);
      
      % Package output
      stk = dbstack;
      fcn_name = regexprep(stk(1).name, '.*\.', '');
      test_name = regexprep(fcn_name, '^bench_', '');
      out = ResultCharVsStrSingle(test_name, ...
        te_char/n_iters, te_string/n_iters, te_mcos/n_iters);
    end
    
  end
  
end
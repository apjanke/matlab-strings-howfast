function compare_char_and_string_simple_performance

%#ok<*NASGU>

n_chars = 30;
n_els = 10000;
n_strs = 100000;
n_arb_strs = 1000;
n_iters = 1000;

needle = 'foo';
alphabet = 'a':'z';

%arb_strs generataion
arb_strs = cell([1 n_arb_strs]);
arb_strs{1} = '';
n_made = 1;
while n_made < n_arb_strs
    n_new = n_made * numel(alphabet);
    new_strs = cell([1 n_new]);
    i_new = 1;
    for i_made = 1:n_made
        for i_alpha = 1:numel(alphabet)
            new_strs{i_new} = [arb_strs{i_made} alphabet(i_alpha)];
            i_new = i_new + 1;
        end
    end
    arb_strs((n_made+1):(n_made+n_new)) = new_strs;
    n_made = n_made + n_new;
end
arb_strs = arb_strs(1:n_arb_strs);

% strcmp - scalar

a = 'foo';
b = 'foobar';

t0 = tic;
for i = 1:n_iters
    trash = strcmp(a, b);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = strcmp(a_str, b_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('strcmp(a,b) - scalar:\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);

% strcmp - array

a = repmat({'foo'}, [1 n_els]);
b = repmat({'foobar'}, [1 n_els]);

t0 = tic;
for i = 1:n_iters
    trash = strcmp(a, b);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = strcmp(a_str, b_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('strcmp(a,b) - array:\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);


% strcmp - array vs scalar

a = {'foo'};
b = repmat({'foobar'}, [1 n_els]);

t0 = tic;
for i = 1:n_iters
    trash = strcmp(a, b);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = strcmp(a_str, b_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('strcmp(a,b) - array vs. scalar:\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);

% isequal

a = 'foo';
b = 'foobar';

t0 = tic;
for i = 1:n_iters
    trash = isequal(a, b);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = isequal(a_str, b_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('isequal(a,b):\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);


% ismember - bad scenario

a = 'foo';
b = repmat({'foobar'}, [1 n_els]);
b{end} = a;

t0 = tic;
for i = 1:n_iters
    trash = ismember(a, b);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = ismember(a_str, b_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('ismember(a,b) - bad scenario:\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);


% ismember - good scenario

a = 'foo';
b = repmat({'foobar'}, [1 n_els]);
b{1} = a;

t0 = tic;
for i = 1:n_iters
    trash = ismember(a, b);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = ismember(a_str, b_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('ismember(a,b) - good scenario:\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);


% ismember - backwards

a = 'foo';
b = arb_strs;

t0 = tic;
for i = 1:n_iters
    trash = ismember(a, b);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = ismember(a_str, b_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('ismember(a,b) - backwards:\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);


% sort - backwards

a = arb_strs(end:-1:1);

t0 = tic;
for i = 1:n_iters
    trash = sort(a);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = sort(a_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('sort(a) - backwards :\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);



% unique - backwards

a = arb_strs(end:-1:1);

t0 = tic;
for i = 1:n_iters
    trash = unique(a);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = unique(a_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('unique(a) - backwards :\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);


% setdiff - in order

a = arb_strs;
b = arb_strs;

t0 = tic;
for i = 1:n_iters
    trash = setdiff(a,b);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = setdiff(a_str,b_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('setdiff - in order :\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);

% setdiff - reversed order

a = arb_strs;
b = arb_strs(end:-1:1);

t0 = tic;
for i = 1:n_iters
    trash = setdiff(a,b);
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = setdiff(a_str,b_str);
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('setdiff - reversed order :\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);


% strrep - 'b' for 'a' 

a = arb_strs;

t0 = tic;
for i = 1:n_iters
    trash = strrep(a,'a','b');
end
te = toc(t0);
te_char = te;
te_per_str = te_char / n_iters;
a_str = string(a);
b_str = string(b);
t0 = tic;
for i = 1:n_iters
    trash = strrep(a_str,'a','b');
end
te = toc(t0);
te_str = te;
te_per_str = te_str / n_iters;

str_win_ratio = (te_char - te_str) / te_char;
fprintf('strrep(strs,''a'',''b''):\n%0.4f char vs %0.4f str (%0.2f str win)\n', ...
    te_char, te_str, str_win_ratio);


function [f, gradf]=fun(x) 
f=1;
if nargout  > 1
    gradf = zeros(size(x));
end
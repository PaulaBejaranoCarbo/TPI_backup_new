function [y, T] = static_6(y, x, params, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(20)=params(13)*log(y(1))+(1-params(13))*log(y(9))-params(5)*y(5)^(1+params(4))/(1+params(4));
  y(18)=y(2)-y(6)*y(5)-y(4)*y(14)*y(7);
end

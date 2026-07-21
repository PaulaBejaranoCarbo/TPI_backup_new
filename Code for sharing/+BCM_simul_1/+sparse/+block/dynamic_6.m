function [y, T] = dynamic_6(y, x, params, steady_state, sparse_rowval, sparse_colval, sparse_colptr, T)
  y(49)=params(13)*log(y(30))+(1-params(13))*log(y(38))-params(5)*y(34)^(1+params(4))/(1+params(4));
  y(47)=y(31)-y(35)*y(34)-y(33)*y(43)*y(36);
end

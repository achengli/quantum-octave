function out=qc_split(qbin)
    qbin = qc_ket(qbin);
    N = ceil(log2(size(qbin,1)));
    out = zeros(N,2);
    qbin_str = dec2bin([1:size(qbin,1)]');
    for iter = 1:N,
        out(iter,:) = qc_ket([sum(qbin(find(str2num(qbin_str(:,iter)) == 0))), ...
        sum(qbin(find(str2num(qbin_str(:,iter)) == 1)))])';
    end
end;



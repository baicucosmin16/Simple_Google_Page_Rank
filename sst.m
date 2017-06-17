function [ x ] = sst(A,b)
% Functie pentru calcularea unui sistem superior triunghiular
% Se incepe cu ultima linie si se calculeaza x(n)
% Se calculeaza celelalte necunoscute care depind de cele aflate inainte
	[n n]=size(A);
	x=zeros(1,n);
	x(n)=b(n)/A(n,n);
	for i=n-1:-1:1
		s=0;
		for j=i+1:n
			s=s+A(i,j)*x(j);
		end
		x(i)=(b(i)-s)/A(i,i);
	end
	
endfunction

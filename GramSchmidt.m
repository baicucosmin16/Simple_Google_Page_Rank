function [B] = GramSchmidt(A)
% Algoritmul Gram Schmidt pentru descompunerea QR a unei matrice
% Q este o matrice ortogonala si inversa ei este Q', iar R este o matrice superior triunghiulara
% Pentru aflarea inversei matricei A se calculeaza n ecuatii pentru fiecare coloana din matricea inversa
% Ecuatiile se egaleaza cu coloana corespunzatoare din matricea unitate
% Inversa matricei este formata din solutiile celor n ecuatii
% Functia returneaza inversa matricei A
	[n n] = size(A);
	Q = zeros(n);
	R = zeros(n);
	B=ones(n);
	I=eye(n);
	for j = 1 : n
		for i = 1 : j-1
			R(i,j) = Q(:,i)' * A(:,j);
		end
		s = zeros(n,1);
		  s = Q(:, 1:j-1) * R(1:j-1, j);
		aux = A(:,j) - s;		
		R(j,j) = norm(aux,2);
		Q(:,j) = aux/R(j,j);
	end
	for i=1:n
		b=sst(R,Q'*I(:,i));
		B(:,i)=b;
	end
	
end

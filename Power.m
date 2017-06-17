function [ R ] = Power(nume,d,eps)

	f=fopen(nume, "r");      % Deschiderea fisierului din care se citesc informatiile
	aux=fgets(f);            % Cu fgets se citeste cate un rand din fisier
	N=strread(aux,'%d');
	A=zeros(N);
	L=zeros(1,N);
	R=zeros(1,N);
	I1=ones(N,1);
	E=I1*I1'; 
	for i=1:N                % Crearea matricei de adiacenta
		aux=fgets(f);
		s=strread(aux,'%d');
		L(i)=s(2);       % In L se retine numarul de link-uri continut de fiecare pagina 
		for j=1:s(2)
			if (s(j+2)==s(1))
				L(i)--;
			end
			A(i,s(j+2))=1;
		end
	end
	for i=1:N
		A(i,i)=0;
	end
	M=zeros(N,N);
	for i=1:N               % Crearea matricei M
		for j=1:N
			if (A(j,i)==1)
				M(i,j)=double(1)/double(L(j));
			end
		end
	end
	a=length(M);
	P=double(d)*double(M)+((1-d)/(a))*E; 
	y=eye(N,1);
	while 1         %Folosind metoda puterii directe se afla vectorul propriu al matrice P
		w=y;
		z = P*y;
		y = z/norm(z,1);
		lambda = y'*P*y;
		if (abs(y-w)<eps)   % Algoritmul se opreste cand diferenta dintre iteratii este mai bina decat eps
			break;
		end
	end
	R=y;    % Se returneaza vectorul propriu al matricei P

end

function [ R ] = Algebraic(nume,d)

	f=fopen(nume, "r");    % Deschiderea fisierului din care se citesc informatiile
	aux=fgets(f);          % fgets pentru a citi cate un rand din fisier
	N=strread(aux,'%d');   % numarul de pagini
	A=zeros(N);
	L=zeros(1,N);
	R=zeros(1,N);
	C=zeros(N);
	I=eye(N);
	I1=ones(N,1);
	for i=1:N              % Crearea matricei de adiacenta si a vectorului cu numarul de link-uri
		aux=fgets(f);
		s=strread(aux,'%d');
		L(i)=s(2);
		for j=1:s(2)
			if (s(j+2)==s(1))
				L(i)--;
			end
			A(i,s(j+2))=1;
		end
	end
	for i=1:N           % Daca o pagina are link spre ea, nu se ia in considerare (diagonala principala e 0) 
		A(i,i)=0;
	end
	M=zeros(N,N);
	for i=1:N           % Crearea matricei M
		for j=1:N
			if (A(j,i)==1)
				M(i,j)=double(1)/double(L(j));
			end
		end
	end
	C=I-d*M;         
	D=GramSchmidt(C);   % Se calculeaza inversa matricei cu algoritmul Gram-Schmidt
	R=D*((double(1)-double(d))/double(N))*I1;  
	

end

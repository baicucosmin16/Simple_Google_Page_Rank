function [ R ] = Iterative(nume, d, eps)
	
	f=fopen(nume, "r");      % Deschiderea fisierului din care se citesc informatiile
	aux=fgets(f);		 % Cu fgets se citeste cate un rand din fisier
	N=strread(aux,'%d');     % Am transformat sirul de caractere in sir de numere intregi (un element in acest caz)
	A=zeros(N);             
	L=zeros(1,N);
	R=zeros(1,N);
	for i=1:N                % Crearea matricei de adiacenta
		aux=fgets(f);
		s=strread(aux,'%d');
		L(i)=s(2);       % In L se retine numarul de link-uri continut de fiecare pagina 
		for j=1:s(2)
			if (s(j+2)==s(1))
				L(i)--;   % Daca o pagina contine un link spre ea insasi, se scade numarul de link-uri
			end
			A(i,s(j+2))=1;    
		end
	end
	for i=1:N         % Daca o pagina are link spre ea, nu se ia in considerare (diagonala principala e 0) 
		A(i,i)=0;
	end
	PR=zeros(3,N);   % Pentru iteratii am creat o matrice cu 3 linii (prima linie ia valoarea 0 sau 1 iar pe liniile 2 si 3 se retin ultima iteratie si ce a curenta)
	PR(2,:)=double(1)/double(N);
	while 1
		nr=0;
		for i=1:N
			if (PR(1,i)==0)  % Se calculeaza o noua iteratie pentru fiecare pagina
				s=0;
				for j=1:N   % Suma ultimelor iteratii ale paginilor care contin link spre pagina curenta
					if (A(j,i)==1)
						s=s+PR(3,j)/L(j);
					end
				end
				PR(3,i)=double(1-d)/double(N)+double(d)*double(s);
				if (norm(PR(3,i)-PR(2,i))<eps)
					PR(1,i)=1;
				end
			end
			PR(2,:)=PR(3,:);  % Ultima iteratie ia valoarea iteratiei calculate pentru a fi folosita la urmatorul pas
		end
		for k=1:N    % Se contorizeaza numarul paginilor care au ajuns la o iteratie finala
			if (PR(1,k)==1)
				nr++;
			end
		end
		if (nr==N)   % Daca toate paginile au diferenta dintre iteratii mai mica decat eps se iese din structura while
			break;
		end

	end
	R=PR(3,:);  % Sirul returnat ia valoare ultimei linii din matrice care contine ultimele iteratii calculate
end

	

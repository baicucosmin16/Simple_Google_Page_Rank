function [R1 R2 R3] = PageRank(nume,d,eps)
 
	out=strcat(nume,'.out');    
	f=fopen(nume, "r");          % Deschiderea fisierului din care se citesc informatiile
	g=fopen(out,"w");            % Deschiderea fisierului in care se vor scrie rezultatele
	aux=fgets(f);
	N=strread(aux,'%d');
	fprintf(g,"%d\n\n",N);
	R1=Iterative(nume,d,eps);    % R1 ia valoare sirului returnat de functia Iterative
	for i=1:N                    % Se sirul R1 in fisierul de output
		fprintf(g,"%.6f\n",R1(i));
	end
	R2=Algebraic(nume,d);        % R2 ia valoare sirului returnat de functia Algebraic
	fprintf(g,"\n");	     % Se sirul R2 in fisierul de output	 	
	for i=1:N
		fprintf(g,"%.6f\n",R2(i));
	end
	R3=Power(nume,d,eps);        % R3 ia valoare sirului returnat de functia Power
	fprintf(g,"\n");             % Se sirul R3 in fisierul de output
	for i=1:N
		fprintf(g,"%.6f\n",R3(i));
	end
	for i=1:N
		aux=fgets(f);
	end
	aux=fgets(f);               % Se citesc val1 si val2 din fisier
	val1=strread(aux,'%f');
	aux=fgets(f);
	val2=strread(aux,'%f');
	X=zeros(2,N);               % Am creat o matrice cu 2 linii (pe prima linie se retine index-ul si pe a doua, valoarea din sirul returnat de functie)
	for i=1:N
		X(1,i)=i; 
		X(2,i)=Apartenenta(R2(i),val1,val2);  % Se calculeaza gradul de apartenenta pentru fiecare valoare din R2
	end
	
	gata=0;             
	while (gata==0)            % Am folosit algoritmul Bubble Sort pentru aranjarea descrescatoare a gradelor de apartenenta
		gata=1;
		for i=1:N-1
			if (X(2,i)<X(2,i+1))    % Daca valorile nu respectau ordinea, se inversau valorile pentru grad, dar si pentru index
				gata=0;
				aux=X(2,i);
				X(2,i)=X(2,i+1);
				X(2,i+1)=aux;
				aux=X(1,i);
				X(1,i)=X(1,i+1);
				X(1,i+1)=aux;
			end
			if (X(2,i)==X(2,i+1))   % Daca valorile sunt egale, se compara valorile specife din vectorul R2 si se aranjeaza in functie de acestea
				if (R2(X(1,i))<R2(X(1,i+1)))
					gata=0;
					aux=X(2,i);
					X(2,i)=X(2,i+1);
					X(2,i+1)=aux;
					aux=X(1,i);
					X(1,i)=X(1,i+1);
					X(1,i+1)=aux;
				end
			end
		end
	end
	fprintf(g,"\n");       
	for i=1:N              %Se afiseaza ordonate crescator, valorile gradelor de apartenenta        
		fprintf(g,"%d %d %.6f\n",i,X(1,i),X(2,i))
	end	

	fclose(f);
	fclose(g);
end

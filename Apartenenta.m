function [ y ] = Apartenenta(x,val1,val2)
% Pentru aflarea coeficientilor a si b am rezolva sistemul de ecuatii pentru continuitate
% In functie de ramura in care se incadreaza x, se returneaza o anumita valoare
	a=1/(val2-val1);
	b=-a*val1;
	
	if ((x>=0) && (x<val1))
		y=0;
	elseif ((x>=val1) && (x<=val2))
		y=a*x+b;
	elseif ((x>val2) && (x<=1))
		y=1;
	end
end

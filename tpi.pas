//holaaaaaaa

program tpi;
uses SysUtils,crt;
Const
	L = 12; //medida de la caja con los numeros de entrada y salida
	C = 5;
type
	caja = record
			x,y:string;
	end;
	pantalla = record
			num,posx,posy:integer;
			dir:char;
			encontrado:boolean;
	end;

	pantallas = array [1..C] of pantalla;
	cajaNegra = array [1..L,1..L] of shortstring;

procedure llenarCaja(var caja: cajaNegra);
var i,k,j:integer; //agragar la j
begin
	k := 11; //es la medida de la caja negra
	//CAJA
	for i:= 2 to k do
	begin
		for j:= 2 to k do //el 2 y el 11 son las posiciones dentre de la caja
			caja[i,j]:= '/';
	end;
	//SALIDA
		//LATERALES
	for i:= 2 to k do	//lateral izquierdo
		caja[i,1]:= IntToStr(k - i);
	for i:= 2 to k do	//lateral izquierdo
		caja[i,k+1]:= IntToStr(18 + i);
		//SUP Y INF
	for i:= 2 to k do	//parte superior
		caja[1,i]:= IntToStr(8 + i);
	for i:= 2 to k do	//parte inferior
		caja[k + 1,i]:= IntToStr(41 - i);
end;
procedure dibujarCaja(caja: cajaNegra; const L:integer);
var i,j: integer;
begin
	for i:= 1 to L do
	begin
		for j:= 1 to L do
		begin
			write('|');
			Write(caja[i,j]:2);
		end;
		Write('|');
		WriteLn;
	end;
end;
procedure ubicarPantallas(var p:pantallas; const C:integer);
var i,n:integer;
begin
	for i:= 1 to C do
	begin
		p[i].num :=	i;
		p[i].encontrado :=	false;
		n := random(12) + 1;
		if (n = 1) then p[i].posx := n + 1
		else if (n = 12) then p[i].posx := n - 1
		else p[i].posx := n;
		n:= random(11) + 1;
		if (n = 1) then p[i].posy := n + 1
		else if (n = 12) then p[i].posy := n - 1
		else p[i].posy := n;
		n:= 0; //se le reasigna el cero, ya que en muchas pruebas el numero no cambiaba en los for
		n:= random(2);
		if (n = 0) then p[i].dir := '/'
		else if (n = 1) then p[i].dir := '\';
	end;
end;
procedure tabla(p:pantallas; const C:Integer);
var i:integer;
begin
	for i:= 1 to C do
		WriteLn(p[i].num:2,'|',p[i].encontrado:2,'|',p[i].posx:2,'|',p[i].posy:2,'|',p[i].dir:2);
end;
var cn:		cajaNegra;
	pant:	pantallas;

BEGIN
	llenarCaja(cn);
	dibujarCaja(cn,L);
	WriteLn;
	ubicarPantallas(pant,C);
	tabla(pant,C);
END.
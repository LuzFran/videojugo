program tpi;

uses SysUtils,crt;
//	------DECLARACION DE VARIABLES, CONSTANTES Y MATRICES------
Const
	T = 10; //medida de la caja con los numeros de entrada y salida
	P = 5; //pantallas
type
	pantalla = record
			num,posx,posy:integer;
			dir:string;
			encontrado:boolean;
	end;
	JugadorData = record
			NroDisparos, puntaje, EspejosHayados:integer;
			Nombre: string;
	end;
	pantallas = array [1..P] of pantalla;
	cajaNegra = array [1..T,1..T] of shortstring;

//	------PROCEDIMIENTOS DEL PROGRAMA PRINCIPAL------
//	------	pantalla principal del juego	------
procedure PantallaInicio();
	//	----procedimiento para centrar los texto----
	function CentrarTexto(texto:string):string;
	var  ancho, i: Integer;
	begin
		ancho := (80 - Length(texto)) div 2; // 80 es el ancho de la pantalla
		CentrarTexto := '';
		for i := 1 to ancho do
			CentrarTexto := CentrarTexto + ' ';
		CentrarTexto := CentrarTexto + texto;
	end;
var	i:integer;
Begin
	writeln;writeln;
	writeln(CentrarTexto('LASER TAG'));
	writeln(CentrarTexto(''));
	writeln(CentrarTexto('Trabajo practico integrador'));
	writeln(CentrarTexto('by: Abril y Luz'));
	writeln(CentrarTexto(''));
	write('cargando juego: ');
	for i:= 1 to 20 do
	begin
		write('❚');
		delay(200);
	end;
	writeln;writeln;
	writeln('press "S" for star');
	readkey;
End;

//	------	inicializa los datos necesarios para el juego
procedure inicializarJuego(var pant:pantallas; jugador:JugadorData; const P:integer);
	//	----procedimiento para posicion de pantallas random----
	procedure ubicacion(opcion:integer; var pant:pantallas; const P:integer);
		function conversor(n:integer):integer;
		var x,y:integer;
		begin
			x:= 10;
			y:= 9;
			if (n >= 0) or (n <= 9) then 
				conversor:= x - n
			else if (n >= 10) or (n <= 19) then
				conversor:= n - y;
			end;
	var i,n,x,y,dire:integer;
	Begin
		n:=0;
		if opcion = 2 then
		Begin
			writeln;
			writeln('Jugador 1, cargue la pposicion de las pantallas');
			writeln;
			for i:= 1 to P do
			begin
				pant[i].num:= i;
				pant[i].encontrado:= false;
				writeln('ingrese la coordena de 0 a 9:');
				readln(x);
				pant[i].posX:= conversor(x);
				writeln('ingrese la coordena de 10 a 19:');
				readln(y);
				pant[i].posY:= conversor(y);
				writeln('ingrese la direccion: ');
				writeln('1. derecha');
				writeln('2.izquierda');
				readln(dire);
				if (dire = 1) then pant[i].dir:= '/'
				else if (n = 2) then pant[i].dir:= '\';
			end;
		end
		else if opcion = 2 then
		Begin
			for i:= 2 to P do
			begin
				pant[i].num:= i;
				pant[i].encontrado:= false;
				n:= random(11) + 1;
				if (n = 0) then pant[i].posX:= (n + 1)
				else pant[i].posX:= n;
				n:= random(11) + 1;
				if (n = 0) then pant[i].posY:= (n + 1)
				else pant[i].posY:= n;
				n:=0;
				n:= random(2);
				if (n = 0) then pant[i].dir:= '/'
				else if (n = 1) then pant[i].dir:= '\';
			end;
		End;
	end;	
var respuesta: byte;
Begin
	writeln;
	writeln('¿cuantos jugadores?');
	writeln('1 o 2');
	writeln;
	readln(respuesta);
	ubicacion(respuesta,pant,P);
	clrscr;
	writeln;
	writeln('Nivel');
	writeln('1. 20 disparos');
	writeln('2. 10 disparos');
	writeln;
	readln(respuesta);
	case respuesta of
			1 : jugador.NroDisparos:= 20;
			2 : jugador.NroDisparos:= 10;
	end;
	writeln;
	write('ingrese el nombre del jugador ');
	read(jugador.Nombre);
	writeln;
end;

//	------juego------
procedure juego(var cn:cajaNegra ;var pant:pantallas; var jugador:JugadorData; const P,T:integer);
	Procedure MostrarMatriz (Var cn:cajaNegra; const T:integer);
	Var i,j:Integer;
	Begin
		WriteLn;
		WriteLn('   10 11 12 13 14 15 16 17 18 19  ');
		WriteLn('    __ __ __ __ __ __ __ __ __ __  ');
		For i:= 1 to T do
		Begin
			Write(10 - i,' ');
			Write('|');
			For j:=1 to T do
			Begin
				Write(cn[i,j]:2);
				Write(' ');
			End;
			Write('|');
			Write(' ', 19 + i);
			WriteLn;
		End;
		WriteLn('   __ __ __ __ __ __ __ __ __ __  ');
		WriteLn('   39 38 37 36 35 34 33 32 31 30  ');
	End;
	function MenuOpciones():byte;
	begin
		writeln('(1).disparar  (2).adivinar  (3).salir');
		ReadLn(MenuOpciones);
	end;
	procedure adivinar(var pant:pantallas; var cn:cajaNegra; var jugador:JugadorData; const T,P:integer);
		procedure comprobador(var x,y: integer;dire:String; var pant:pantallas; const P:integer);
		var i,auxX,auxY:integer;
			direaux:String;
		Begin
			x:= 10 - x;
			y:= y - 9;
			if dire = '1' then dire := '/'
			else if dire = '2' then dire := '\';

			for i:= 1 to 5 do
			begin
				auxX:= pant[i].posX;
				auxY:= pant[i].posY;
				direaux := pant[i].dir;
				
				if (x = auxX) and (y = auxY) and (direaux = dire) then
				Begin
					pant[i].encontrado:= True; 
					WriteLn('¡FELICIDADES! La Opcion ingresada es Correcta ');
					Jugador.Puntaje := Jugador.Puntaje + 2;
					CN[pant[i].posX,pant[i].posY] := pant[i].dir;
				end
				else writeln('¡PERDISTE! La opcion ingresada no es la Correcta');
			end;
		end;
	
	
	var x,y:integer;
		dire:String;
	begin
		WriteLn('¡ADVERTENCIA!');
		WriteLn('Solo posee un intento...');
		WriteLn;
		WriteLn('ingrese la coordenada donde cree que esta la pantalla');
		WriteLn('entre 0 y 9');
		readln(x);
		WriteLn('ingrese la coordenada donde cree que esta la pantalla');
		WriteLn('entre 10 y 19');
		readln(y);
		WriteLn('ingrese la direccion que tiene la pantalla');
		WriteLn('1.derecha(/)  2.izquierda(\)');
		readln(dire);
		comprobador(x,y,dire,pant,P);
	end;
	
	
var //entrada, respuesta:integer;
	opcion:byte;
Begin
	opcion:= 0;
	MostrarMatriz(cn,T);
	opcion:= MenuOpciones;
	if opcion = 1 then
		disparar(pant,cn,jugador,T,P)
	else if opcion = 2 then
		adivinar (pant,cn,jugador,T,P);
end;
//	------PROGRAMA PRINCIPAL------
var cn:		cajaNegra;
	pant:	pantallas;
	jugador:JugadorData;
BEGIN
	Randomize();
	Jugador.NroDisparos:= 0;
	Jugador.puntaje:= 0;
	Jugador.EspejosHayados:= 0;
	Jugador.NroDisparos:= 0;
	Jugador.Nombre:= ' ';
	PantallaInicio();
	clrscr;
    inicializarJuego(pant,jugador,P);
	clrscr;
	juego(cn,pant,jugador,P,T);
END.

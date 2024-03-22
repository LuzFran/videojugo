program Integrador;
uses Crt;

const
	Filas	= 10;
	Columnas= 10;
	Espejos	= 5;
Type
	TTEspejos = Record
					num,x,y,dir	:integer;
	end;
	TTJugador	= Record
					NroDisparos,Puntuacion:	integer;
					EspejosEncontrados:		byte;
					Nombre:					String;
	end;
	TTPantallas = array [1..Espejos] of TTEspejos;
	TTMatriz = array [1..Filas,1..Columnas] of shortstring;

//	------ INICIO PROCEDIMIENTO INICIALIZAR------
procedure Inicializar (var M:TTMatriz; var Jugador:TTJugador);
var i,j:integer;
Begin
	for i:= 1 to Filas do
		for j:= 1 to Columnas do
			M[i,j]:= ' ';
	Jugador.NroDisparos:= 0;
	Jugador.EspejosEncontrados:= 0;
	Jugador.Puntuacion:= 0;
	Jugador.Nombre:= ' ';
End;
//	------  FIN PROCEDIMIENTO INICIALIZAR  ------
//	------ INICIO FUNCION PARA CENTRAR EL TEXTO ------
function CentrarTexto(texto:string):String;
var i,Ancho: integer;
begin
	Ancho:= (80 - Length(texto)) div 2;
	CentrarTexto:= '';
	for i:= 1 to Ancho do
		CentrarTexto:= CentrarTexto + ' ';
	CentrarTexto:= CentrarTexto + texto;
end;
//	------   FIN FUNCION PARA CENTRAR EL TEXTO  ------
//	------ INICIO PROCEDIMIENTO PANTALLA DE INICIO ------
procedure PantallaInicio(var Jugador:TTJugador);
var i:integer;
Begin
	writeln;
	writeln(CentrarTexto('LASER TAG'));
	writeln('');
	writeln(CentrarTexto('Trabajo practico integrador'));
	writeln(CentrarTexto('by: Abril y Luz'));
	writeln('');
	writeln(CentrarTexto('Cargando Juego... '));
	writeln;
	for i:= 1 to 40 do
	begin
		write('//');
		delay(200);
	end;
	writeln;
	writeln(CentrarTexto('Ingrese su nombre'));
	read(Jugador.Nombre);
	writeln;writeln;
	writeln('Press "S" for strarting');
	readkey;
end;
//	------   FIN PROCEDIMIENTO PANTALLA DE INICIO  ------
//	------ INICIO PROCEDIMIENTO MENU DE OPCIONES ------
procedure MenuOpciones(var pantalla:TTPantallas; var Jugador:TTJugador;const Espejos:integer);

var opciones:byte;
	i,x,y:integer;
Begin
	writeln;
	writeln(CentrarTexto('Ingrese el Nivel'));
	writeln(CentrarTexto('1. Nivel 1   2. Nivel 2'));
	ReadLn(opciones);

	case opciones of
				1: begin
					writeln;
					writeln(CentrarTexto('el nivel 1 contiene 20 disparos'));
					Jugador.NroDisparos:= 20;
					delay(3000);
					end;
				2: begin
					writeln;
					writeln(CentrarTexto('el nivel 2 contiene 10 disparos'));
					Jugador.NroDisparos:= 10;
					delay(3000);
					end;
	end;

	writeln;
	writeln(CentrarTexto('Ingrese cuantos jugadores'));
	writeln(CentrarTexto('1. 1 jugador (la posicion de los espejos son aleatorios)'));
	writeln(CentrarTexto('2. 2 jugadores (la posicion de los espejos son puestas)'));
	writeln(CentrarTexto('por el segundo jugador'));
	ReadLn(opciones);

	case opciones of
				1: begin
					for i:= 1 to Espejos do
					begin
						x:= random(11) + 1;
						if (x = 0) then pantalla[i].x:= (x + 1)
						else pantalla[i].x:= x;
						y:= random(11) + 1;
						if (y = 0) then pantalla[i].y:= (y + 1)
						else pantalla[i].y:= y;
						x:=0;
						x:= random(3);
						if (x = 0) then pantalla[i].dir:= (x + 1) //'/'
						else pantalla[i].dir:= x; //'\';
					end;
					end;
				2: begin
					for i:= 1 to Espejos do
					begin
						pantalla[i].num:= i;
						writeln;
						writeln(CentrarTexto('ingrese la posicion entre 0 y 9'));
						ReadLn(y);
						pantalla[i].y:= 10 - y;
						writeln(CentrarTexto('ingrese la posicion entre 10 y 19'));
						ReadLn(x);
						pantalla[i].x:= x - 9;
						writeln(CentrarTexto('ingrese la direccion del espejo'));
						writeln(CentrarTexto('1. derecha  2. izquierda'));
						ReadLn(opciones);
						if opciones = 1 then pantalla[i].dir:= opciones //'/'
						else if opciones = 2 then pantalla[i].dir:= opciones;//'\'
					end;
					end;
	end;
end;
//	------   FIN PROCEDIMIENTO MENU DE OPCIONES  ------
//	------ INICIO PROCEDIMIENTO JUEGO ------
{procedure juego(Pantalla:TTPantallas; var Jugador:TTJugador; const Espejos:integer;var Matriz:TTMatriz);
	Procedure MostrarMatriz (Var M:TTMatriz;Var JJ:TTJugador);
	Var	i,j:Integer;
	Begin
		WriteLn;
		WriteLn('Bienvenido! ',JJ.Nombre);
		WriteLn;
		Write('   | Puntos:',JJ.Puntuacion,'| Nro de Disparos:',JJ.NroDisparos,'| Espejos Encontrados:',JJ.EspejosEncontrados,'|');
		WriteLn;
		WriteLn;
		WriteLn('   10 11 12 13 14 15 16 17 18 19  ');
		WriteLn('   __ __ __ __ __ __ __ __ __ __   ');
		For i:= 1 to Filas do
	    Begin
			Write(10 - i,' ');
			Write('|');
			For j:=1 to Columnas do
			Begin
				Write(M[i,j]:2);
				Write(' ');
			End;
			Write('|');
			Write(' ', 19 + i);
			WriteLn;
		End;
		WriteLn('   __ __ __ __ __ __ __ __ __ __   ');
		WriteLn('   39 38 37 36 35 34 33 32 31 30  ');
		WriteLn;
		writeln('(1).Disparar  (2).Estimar Espejos  (3).Salir');
	End;
var i,x,y,d,halladas:  integer;
Begin
	halladas:= 0;
	while (halladas <> 5) do
	begin
		mostrarMatriz(Matriz,Jugador);
		writeln('ingrese la posicion que cree que esta el espejo entre 0 y 9');
		ReadLn(y);
		y:= 10 - y;
		writeln('ingrese la posicion que cree que esta el espejo entre 10 y 19');
		ReadLn(x);
		x:= x - 9;
		writeln('ingrese la direccion que cree que esta el espejo');
		writeln('1. derecha  2. izquierda');
		ReadLn(d);
		for i:= 1 to Espejos do
		begin
			if (x = Pantalla[i].x) and (y = Pantalla[i].y) and (d = Pantalla[i].dir) then
			begin
				Jugador.EspejosEncontrados+= 1;
				writeln('¡FELICIDADES! Encontraste el espejo nro ', i);
				Jugador.Puntuacion += 2;
				if (d = 1) then Matriz[y,x]:= '/'
				else if (d = 2) then Matriz[y,x]:= '\';
				halladas+=1;
			end
			else writeln('¡FALLASTE! los datos ingresados son incorrectos');
		end;
	end;
end;}
//	------   FIN PROCEDIMIENTO JUEGO  ------
//	------ INICIO PROCEDIMIENTO JUEGO------
procedure juego(Pantalla:TTPantallas; var Jugador:TTJugador; const Espejos:integer;var Matriz:TTMatriz);
	Procedure MostrarMatriz (Var M:TTMatriz;Var JJ:TTJugador);
	Var	i,j:Integer;
	Begin
		WriteLn;
		WriteLn('Bienvenido! ',JJ.Nombre);
		WriteLn;
		Write('   | Puntos:',JJ.Puntuacion,'| Nro de Disparos:',JJ.NroDisparos,'| Espejos Encontrados:',JJ.EspejosEncontrados,'|');
		WriteLn;
		WriteLn;
		WriteLn('   10 11 12 13 14 15 16 17 18 19  ');
		WriteLn('   __ __ __ __ __ __ __ __ __ __   ');
		For i:= 1 to Filas do
	    Begin
			Write(10 - i,' ');
			Write('|');
			For j:=1 to Columnas do
			Begin
				Write(M[i,j]:2);
				Write(' ');
			End;
			Write('|');
			Write(' ', 19 + i);
			WriteLn;
		End;
		WriteLn('   __ __ __ __ __ __ __ __ __ __   ');
		WriteLn('   39 38 37 36 35 34 33 32 31 30  ');
		WriteLn;
	End;
	procedure Estimar(Pantalla:TTPantallas; var Jugador:TTJugador; const Espejos:integer);
	var i,x,y,d,halladas:integer;
		estado:boolean;
	Begin
		halladas:= 0;
		estado:= false;
		begin
			writeln('ingrese la posicion que cree que esta el espejo entre 0 y 9');
			ReadLn(y);
			y:= 10 - y;
			writeln('ingrese la posicion que cree que esta el espejo entre 10 y 19');
			ReadLn(x);
			x:= x - 9;
			writeln('ingrese la direccion que cree que esta el espejo');
			writeln('1. derecha  2. izquierda');
			ReadLn(d);
			for i:= 1 to Espejos do
			begin
				if (x = Pantalla[i].x) and (y = Pantalla[i].y) and (d = Pantalla[i].dir) then
				begin
					Jugador.EspejosEncontrados+= 1;
					writeln('¡FELICIDADES! Encontraste el espejo nro ', i);
					Jugador.Puntuacion += 2;
					if (d = 1) then Matriz[y,x]:= '/'
					else if (d = 2) then Matriz[y,x]:= '\';
					halladas+=1;
					estado:= true;
				end
				else estado:= false;
			end;
			if estado = false then writeln('¡FALLASTE! los datos ingresados son incorrectos');
		end;
		clrscr;
	end;
Procedure Disparar (Var Pantalla:TTPantallas;Var Jugador:TTJugador;Const:Espejos:Integer);
Var
Entrada:Integer;
AuxEntrada:Integer;
Salida:Integer;
i,j:Integer;
Begin;
WriteLn('Ingrese por donde desea disparar el lazer..(0..39)')
ReadLn(Entrada);
End; 	
	
	
var opciones:integer;
Begin
	opciones:= 0;
	while (opciones <> 3) do
	begin
		MostrarMatriz(Matriz,Jugador);
		writeln('(1).Disparar  (2).Estimar Espejos  (3).Salir');
		ReadLn(opciones);
		case opciones of
				1: Estimar(Pantalla,Jugador,Espejos);//Disparar(Pantalla,Espejos);
				2: Estimar(Pantalla,Jugador,Espejos);
		end;
	end;
End;
//	------ FIN PROCEDIMIENTO JUEGO ------
//	------ INICIO ------

//	------ FIN ------
//	------ INICIO ------

//	------ FIN ------
var 
	MMatriz:TTMatriz;
	JJugador:TTJugador;
	PPantallas:TTPantallas;
BEGIN
	Randomize();
	Inicializar(MMatriz,JJugador);
	PantallaInicio(JJugador);
	clrscr;
	MenuOpciones(PPantallas,JJugador,Espejos);
	juego(PPantallas,JJugador,Espejos,MMatriz);
END.

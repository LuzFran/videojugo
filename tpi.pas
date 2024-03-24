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
    textcolor(LightCyan);
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
	textcolor(White);
	readkey;
end;
//	------   FIN PROCEDIMIENTO PANTALLA DE INICIO  ------
//	------ INICIO PROCEDIMIENTO MENU DE OPCIONES ------
procedure MenuOpciones(var pantalla:TTPantallas; var Jugador:TTJugador;const Espejos:integer);
var opciones:byte;
	i,x,y:integer;
Begin
    textcolor(LightCyan);
	writeln;
	writeln(CentrarTexto('Ingrese el Nivel'));
	writeln(CentrarTexto('1. Nivel 1     2. Nivel 2'));
	ReadLn(opciones);
	case opciones of
				1: begin
					writeln;
					writeln(CentrarTexto('El nivel 1 Contiene 20 disparos'));
					Jugador.NroDisparos:= 20;
					delay(3000);
					end;
				2: begin
					writeln;
					writeln(CentrarTexto('El nivel 2 Contiene 10 disparos'));
					Jugador.NroDisparos:= 10;
					delay(3000);
					end;
	end;
	writeln;
	writeln(CentrarTexto('Ingrese cuantos jugadores'));
	writeln(CentrarTexto('1.   1 jugador (La posicion de los espejos son Aleatorios)'));
	writeln(CentrarTexto('2.   2 jugadores (La posicion de los espejos son Puestas)'));
	writeln(CentrarTexto('Por el segundo Jugador'));
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
						writeln(CentrarTexto('Ingrese la Posicion entre 0 y 9'));
						ReadLn(y);
						pantalla[i].y:= 10 - y;
						writeln(CentrarTexto('Ingrese la Posicion entre 10 y 19'));
						ReadLn(x);
						pantalla[i].x:= x - 9;
						writeln(CentrarTexto('Ingrese la Direccion del espejo'));
						writeln(CentrarTexto('1. Derecha  2. Izquierda'));
						ReadLn(opciones);
						if opciones = 1 then pantalla[i].dir:= opciones //'/'
						else if opciones = 2 then pantalla[i].dir:= opciones;//'\'
					end;
					end;
	end;
	textcolor(White);
end;
//	------   FIN PROCEDIMIENTO MENU DE OPCIONES  ------
//	------ INICIO PROCEDIMIENTO JUEGO------
procedure juego(Pantalla:TTPantallas; var Jugador:TTJugador; const Espejos:integer;var Matriz:TTMatriz);
	//	------ INICIO SUBPROCEDIMIENTO MOSTRAR LA MATRIZ ------
	Procedure MostrarMatriz (Var M:TTMatriz;Var JJ:TTJugador);
	Var	i,j:Integer;
	Begin
		WriteLn;
		TextColor(LightBlue);
		WriteLn('Bienvenido! ',JJ.Nombre);
		WriteLn;
		TextColor(Cyan);
		Write('   | Puntos:',JJ.Puntuacion,'| Nro de Disparos:',JJ.NroDisparos,'| Espejos Encontrados:',JJ.EspejosEncontrados,'|');
		WriteLn;
		WriteLn;
		TextColor(LightGreen);
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
		TextColor(White);
	End;
	
	Procedure NotificarSalida(Filas:Integer;Columnas:Integer;Entradas:Integer);
	Begin
	if Columnas = 11 then 
	writeln ('El Laser entro por :',Entradas,' y Salio por: ',Filas + 19)
	else if Filas = 11 then 
	writeln ('El Laser entro por :',Entradas,' y Salio por: ',40 - Columnas)
	else if Columnas = 0 then 
	writeln ('El Laser entro por :',Entradas,' y Salio por: ', 10 - Filas)
	else if Filas = 0 then 
	writeln ('El Laser entro por :',Entradas,' y Salio por: ',Columnas + 9)
	End;
	
	
	//	------   FIN SUBPROCEDIMIENTO MOSTRAR LA MATRIZ  ------
	//	------ INICIO SUBPROCEDIMIENTO ESTIMAR ------
	procedure Estimar(Pantalla:TTPantallas; var Jugador:TTJugador; const Espejos:integer);
	var i,x,y,d:integer;
		estado:boolean;
	Begin
		estado:= false;
		writeln('Ingrese la Posicion que cree que esta el Espejo entre 0 y 9');
		ReadLn(y);
		y:= 10 - y;
		writeln('Ingrese la Posicion que cree que esta el Espejo entre 10 y 19');
		ReadLn(x);
		x:= x - 9;
		writeln('Ingrese la direccion que cree que esta el espejo');
		writeln('1. derecha(/)  2. izquierda(\)');
		ReadLn(d);
		for i:= 1 to Espejos do
		begin
			if (x = Pantalla[i].x) and (y = Pantalla[i].y) and (d = Pantalla[i].dir) then
			begin
				Jugador.EspejosEncontrados+= 1;
				textcolor(Yellow);
				writeln('¡FELICIDADES! Encontraste el espejo nro ', i);
				textcolor(White);
				Jugador.Puntuacion += 2;
                inc(Jugador.EspejosEncontrados);
				if (d = 1) then Matriz[y,x]:= '/'
				else if (d = 2) then Matriz[y,x]:= '\';
				estado:= true;
			end
		end;
		textcolor(red);
		if estado = false then writeln('¡FALLASTE! los datos ingresados son incorrectos');
		textcolor(white);
		delay(2000);
		clrscr;
	end;
	//	------   FIN SUBPROCEDIMIENTO ESTIMAR  ------
	//	------ INICIO SUBPROCEDIMIENTO DISPARAR ------
	Procedure Disparar (Var Pantalla:TTPantallas;Var Jugador:TTJugador;Const Espejos:Integer);
	var Entrada,Fila,Columna,i:integer;
		dire:string;
		Salida:boolean;
	Begin
		Jugador.Puntuacion+=2;
		Dec(Jugador.NroDisparos);
		For i:=1 to Espejos do
		Writeln('Fila:', Pantalla[i].y, 'Columnas:', Pantalla[i].x, 'Direccion:', Pantalla[i].dir);
		Fila:= 0;
		Columna:= 0;
		writeln('Ingrese por donde desea disparar el lazer..(0..39)');
		ReadLn(Entrada);
			case Entrada of 
					0..9: begin
						dire := '>';
						Fila:= 10 - Entrada;
						Columna:= 1;
						delay(3000);
						WriteLn('Fila ',Fila,'Columna ',Columna );						
						end;
					10..19:begin
						dire := '⌄';
						Fila:= 1;
						Columna:= Entrada - 9;
						WriteLn('Fila ',Fila,'Columna ',Columna );
						delay(3000);
						end;
					20..29:begin
						dire := '<';
						Fila:= Entrada-19 ;
						Columna:= 10;
						WriteLn('Fila ',Fila,'Columna ',Columna );
						delay(3000);
						end;
					30..39:begin
						dire := '⌃';
						Fila:= 10;
						Columna:= 40 - Entrada;
						WriteLn('Fila ',Fila,'Columna ',Columna );
						delay(3000);
						end;
			end;
		Salida:= false;
		While Salida = False do
		begin
			for i:= 1 to Espejos do
			begin
				if (Pantalla[i].x = Columna) and (Pantalla[i].y = Fila) then
				begin
					Case Pantalla[i].dir of
						1:	Begin //DERECHA
						    WriteLn('Reboto');
						    delay(3000);
							if dire = '>' then 
							begin
								dire:= '⌃';
								WriteLn('Fila ',Fila,'Columna ',Columna );
								delay(3000);
								Dec(Fila);									
							end
							else if dire = '⌄' then 
							begin
							WriteLn('Reboto');
							delay(3000);
								dire:= '<';
								WriteLn('Fila ',Fila,'Columna ',Columna );
								delay(3000);
								Dec(Columna);
							end
							else if dire = '<' then 
							begin
							WriteLn('Reboto');
							delay(3000);
								dire:= '⌄';
								WriteLn('Fila ',Fila,'Columna ',Columna );
								delay(3000);
								Inc(Fila);
							end
							else if dire = '⌃' then 
							begin
							WriteLn('Reboto');
							delay(3000);
								dire:= '>';
								WriteLn('Fila ',Fila,'Columna ',Columna );
								delay(3000);
								Inc(Columna);
							End;
								End;
						2: 	Begin  //IZQUIERDA
							if dire = '>' then 
							begin
							WriteLn('Reboto');
							delay(3000);
								dire:= '⌄';
								WriteLn('Fila ',Fila,'Columna ',Columna );
								delay(3000);
								Inc(Fila);
							end
							else if dire = '⌄' then 
							begin
							WriteLn('Reboto');
							delay(3000);
								dire:= '>';
								WriteLn('Fila ',Fila,'Columna ',Columna );
								delay(3000);
								Inc(Columna);
							end
							else if dire = '<' then 
							begin
							WriteLn('Reboto');
							delay(3000);
								dire:= '⌃';
								WriteLn('Fila ',Fila,'Columna ',Columna );
								delay(3000);
								Dec(Fila);
							end
							else if dire = '⌃' then 
							begin
							WriteLn('Reboto');
							delay(3000);
								dire:= '<';
								WriteLn('Fila ',Fila,'Columna ',Columna );
								delay(3000);
								Dec(Columna);
							end;
								End;
					end; //del case
				end//del begin if
				else begin
					if dire = '>' then 
					begin
					WriteLn('Fila ',Fila,'Columna ',Columna );
					delay(3000);
						Inc(Columna);
						if columna = 11 then salida := true;
					end
					else if dire = '⌄' then 
					begin
					WriteLn('Fila ',Fila,'Columna ',Columna );
					delay(3000);
						Inc(Fila);
						if Fila = 11 then salida := true;
					end
					else if dire = '<' then
					begin
					WriteLn('Fila ',Fila,'Columna ',Columna );
						Dec(Columna);
						delay(3000);
						if columna = 0 then salida := true;
					end
					else if dire = '⌃' then 
					begin
					WriteLn('Fila ',Fila,'Columna ',Columna );
						Dec(Fila);
						delay(3000);
						if Fila = 0 then salida := true;
					end;
				end;
			end;// del begin for
		end;// del begin while
		NotificarSalida(Fila,Columna,Entrada);
	end; //del begin del procedimiento
	//	------   FIN SUBPROCEDIMIENTO DISPARAR  ------
var opciones:string;
Begin
	opciones:= '0';
	repeat 
		MostrarMatriz(Matriz,Jugador);
		TextColor(LightGray);
		writeln('(1).Disparar  (2).Estimar Espejos  (3).Salir');
		ReadLn(opciones);
		case opciones of
				'1': Disparar(Pantalla,Jugador,Espejos);//Disparar(Pantalla,Espejos);
				'2': Estimar(Pantalla,Jugador,Espejos);
		end;
	until (Jugador.NroDisparos = 0) or (opciones = '3');
end;
//	------ FIN PROCEDIMIENTO JUEGO ------	
Procedure Perdiste(Jugador:TTJugador);
Begin
    TextColor(LightRed);
	writeln(CentrarTexto('PERDISTE EL JUEGO!!!'));
	writeln('');
	writeln('                           Nombre del Jugador: ',Jugador.Nombre);
	writeln('                           Numero de Disparos: ',Jugador.NroDisparos);
	writeln('                           Espejos Encontrados: ',Jugador.EspejosEncontrados);
	writeln('                           Puntuacion: ',Jugador.Puntuacion);
	writeln('');
	WriteLn;
    WriteLn;
    WriteLn;
    WriteLn;
    WriteLn(CentrarTexto('GRACIAS POR JUGAR...'));
End;

Procedure Ganaste(Jugador:TTJugador);
Begin
textcolor(Yellow);
	writeln(CentrarTexto('GANASTE EL JUEGO!!!'));
	writeln('');
    writeln('                           Nombre del Jugador: ',Jugador.Nombre);
	writeln('                           Numero de Disparos: ',Jugador.NroDisparos);
	writeln('                           Espejos Encontrados: ',Jugador.EspejosEncontrados);
	writeln('                           Puntuacion: ',Jugador.Puntuacion);
	writeln('');
	WriteLn;
    WriteLn;
    WriteLn;
    WriteLn;
    WriteLn(CentrarTexto('GRACIAS POR JUGAR...'));
End;

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
	clrscr;
	juego(PPantallas,JJugador,Espejos,MMatriz);
	Delay(2000);
	clrscr;
	If(JJugador.EspejosEncontrados = 5)Then
	Ganaste(JJugador)
	Else
	Perdiste(JJugador);
END.


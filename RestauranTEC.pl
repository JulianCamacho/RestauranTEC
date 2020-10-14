%=======================  Restaurantes  =========================%

restaurante("Bella Italia").
restaurante("Italianisimo").
restaurante("McBurguesa").

disposiciones( "Recuerde: Que por disposiciones de Danielito Salas solo se permiten burbujas y durante la espera se debe utilizar mascarilla").

%=======================  Men�s  =========================%

mennu("Bella Italia", "Italiano", ["Pizza", ["Jam�n y Queso", "Suprema", "Hawaiana"], "Calzone", "Espagueti"]).

mennu("Italianisimo","Italiano" ,["Pizza", ["Pepperoni"], "Calzone", "Espagueti"] ).

mennu("McBurguesa","Comida Rapida" ,["Hamburguesas", "Tacos ", "papas"] ).

%=======================  Pizzas =========================%

pizza("Bella Italia", ["Jam�n y Queso", "Suprema", "Hawaiana"]).

pizza("Italianisimo", ["Pepperoni"]).

pizza("Italianisimo","Bella Italia").

%=======================  Comida Rapida =========================%

comidarapida("McBurguesa",["Hamburguesas", "Tacos", "papas"]  ).
%=======================  Direcciones =========================%

direccion("Bella Italia","300m Sur de la entrada principal de la Universidad de Costa Rica" ).

direccion("Italianisimo", "50m Sur de la entrada Banco de Costa Rica" ).

direccion("Bella Italia","100m Norte de la entrada principal del TEC" ).


%=======================  Lugares  =========================%

lugar("Bella Italia", "San Pedro").

lugar("Italianisimo", "Alajuela").

lugar("McBurguesa", "Cartago").

%=======================  Capacidad  =========================%

capacidad("Bella Italia", 10).

capacidad("Italianisimo", 50).

capacidad("McBurguesa", 20).

%=======================  ALIMENTOS  =========================%

alimento(S0,S,Claves):-
    pronombre(Num,S0,S1),
    sintagma_verbal(Num,Estado,S1,S2),
    sintagma_nominal(_Gen2,Num,Estado,S2,S, Claves).
                  %G�nero, n�mero, estado del nombre

alimento(S0,S, Claves):-
    sintagma_verbal(Num,Estado,S0,S1),
    sintagma_nominal(_Gen2,Num,Estado,S1,S, Claves).

alimento(S0,S, Claves):-
    sintagma_nominal(_Gen2,Num,Estado,S0,S, Claves).

%======================  UBICACIONES  =======================%

ubicacion(S0,S,S1):-
    preposicion(S0,S1),
    lugar(S1,S).

%==================  CANTIDAD DE PERSONAS  ==================%

personas(S0,S,S1):-
    preposicion(S0,S1),
    cantidad(S1,S2),
    person(S2,S).

personas(S0,S,S1):-
    preposicion(S0,S1),
    cantidad(S1,S).

personas(S0,S,S0):-
    cantidad(S0,S1),
    person(S1,S).

personas(S0,S,S0):-
    cantidad(S0,S).


%=======================  SINTAGMAS =========================%

sintagma_nominal(Gen,Num,Estado,S0,S, S1):-
    determinante(Gen,Num,S0,S1),
    nombre(Gen,Num,Estado,S1,S2),
    adjetivo(Gen,Num,S2,S).

sintagma_nominal(Gen,Num,Estado,S0,S, S1):-
    nombre(Gen,Num,Estado,S0,S1),
    adjetivo(Gen,Num,S1,S).

sintagma_nominal(Gen,Num,Estado,S0,S, S1):-
    determinante(Gen,Num,S0,S1),
    nombre(Gen,Num,Estado,S1,S).

sintagma_nominal(Gen,Num,Estado,S0,S, S0):-
    nombre(Gen,Num,Estado,S0,S).

sintagma_verbal(Num,_Estado,S0,S):-verbo(Num,S0,S).

sintagma_verbal(Num,Estado,S0,S):-
    verbo(Num,S0,S1),
    infinitivo(Estado,S1,S).
%   sintagma_nominal(_Gen2,Num,S2,S).

%sintagma_verbal(Num,S0,S):-
%    verbo(Num,S0,S1),
%    sintagma_nominal(_Gen2,Num,S1,S).


%=======================  NOMINAL =========================%

%determinante(femenino, singular, [la|S],S).
determinante(femenino, singular, [una|S],S).
%determinante(femenino, plural, [las|S],S).
%determinante(femenino, plural, [unas|S],S).
%determinante(masculino, singular, [el|S],S).
determinante(masculino, singular, [un|S],S).
%determinante(masculino, plural, [los|S],S).
%determinante(masculino, plural, [unos|S],S).

pronombre(singular,[yo|S],S).

%pregunta(singular,[qu�|S],S).
%pregunta(singular,[d�nde|S],S).
%pregunta(singular,[cu�l|S],S).

adjetivo(femenino,singular,[r�pida|S],S).

nombre(masculino, singular, solido, [pollo|S],S).
nombre(femenino, singular, solido, [pizza|S],S).
nombre(femenino, singular, solido, [comida|S],S).
nombre(femenino, singular, liquido, [bebida|S],S).
%nombre(masculino, singular, [menu|S],S).

lugar([heredia|S],S).
lugar([cartago|S],S).
lugar([alajuela|S],S).
lugar([lim�n|S],S).

person([personas|S],S).

cantidad([cuatro|S],S).
cantidad([tres|S],S).

%=======================  VERBAL =========================%


verbo(singular,[quiero|S],S).
infinitivo(solido, [comer|S],S).
infinitivo(liquido, [tomar|S],S).

preposicion([en|S],S).
preposicion([para|S],S).



%=====================  PARSEAR INPUT =======================%


parseInput([],[]).
parseInput([C|InputList], [A|Result]):-
    atom_string(A,C),
    parseInput(InputList,Result).

getInput(Input,R):-
    split_string(Input," ",".",R1),
    %write(R),
    parseInput(R1,R).

updatePreferences(Pref,Insert,[Insert|Pref]).

%======================  DELIMITANTES ========================%

% Funci�n que revisa si un elemento pertenece a una lista
% Sintaxis: miembro(elemento, lista).
% Entradas: elemento, lista.
% Salidas: Booleano indicando si el elemento pertenece a la lista o no

miembro(X, [X|_]).
miembro(X, [_|R]):-miembro(X,R).

% Consideraci�n si el usuario quiere comer pizza, devuelve el
% restaurante a recomendar.
% Sintaxis:
% validaralimento(listaPalabrasClave, restaurante). Se utiliza:
% validaralimento(listaPalabrasClave, X) donde X es el restaurante
% candidato a recomendar al usuario
% Entradas: listaPalabrasClave, restaurante
% Salidas: restaurante a recomendar.

validaralimento(Y, X):-

    write(Y),
    Y == [pizza],
    write("Algun tipo de pizza especial?"),nl,
    read(L),

    %Ver si el tipo de comida que escribe coincide con la lista de pizzas de alg�n    %restaurante
    pizza(X,B), miembro(L, B),write(X), nl

    .

% En caso de que el compa quiera comer comida r�pida, recomienda el
% restaurante para ello y valida si el tipo de comida es v�lido para
% dicho restaurante.
% Sintaxis:
% validaralimento(listaPalabrasClave, restaurante). Se utiliza:
% validaralimento(listaPalabrasClave, X) donde X es el restaurante
% candidato a recomendar al usuario
% Entradas: listaPalabrasClave, restaurante
% Salidas: restaurante a recomendar.
% Restricciones: Se debe dar la Y y dejar al X como variable para que se
% retorne.

validaralimento(Y, X):-

    write(Y),
    miembro(r�pida, Y),
    write("Qu� tipo de comida r�pida?"),nl,
    read(L),

    %Ver si el tipo de comida que escribe coincide con la lista de comida r�pida
    comidarapida(X,B), miembro(L, B),write(X), nl
    .

% Valida si el lugar indicado por el usuario coincide con donde se
% encuentra el restaurante a recomendar. Retorna true si coinciden, sino
% false.
% Sintaxis: validarlugar(restaurante, lugar). Se utiliza como:
% validarlugar(rest, lugar), dando los dos argumentos para que retorne
% un booleano.
% Entrada: restaurante, lugar.
% Salida: Booleano indicando si el restaurante y lugar coinciden
% Restricciones: Se deben dar los dos argumentos para que funcione.

validarlugar(K, Y):-
    lugar(K, Y)
    .

% Valida si la capacidad solicitada por el usuario es menor o igual a la
% disponible en el restaurante.
% Sintaxis: validarcapacidad(rest, capacidad).
% Se utiliza como: validarcapacidad(rest, capacidad), dando los dos
% argumentos para que retorne un booleano.
% Entrada: restaurante, capacidad -> dada por el usuario
% Salida: Booleano indicando si la capacidad solicitada se satisface o
% no.
% Restricciones: Se deben dar los dos argumentos para que funcione

validarcapacidad(K, Y):-
    capacidad(K, T), T >= Y
    .



%======================  PRINCIPAL  ========================%
% Funci�n principal que hace las preguntas al usuario adem�s de ser
% utilizada como interfaz.
% Entradas: Ninguna.
% Salidas: Ninguna.
% Restricciones: Contempladas en las validaciones

restaurantec():-
    write("�Hola! �Qu� desea comer hoy? Escriba su preferencia entre comillas por favor."), nl,
    read(X),
    getInput(X,Y),
    write(Y),
    alimento(Y,[],AlimentoClave),
    updatePreferences([],AlimentoClave,Result0),
    validaralimento(AlimentoClave, K), % Aqu� s� cual restaurante es el candidato
    write(K), nl,
    write("d�nde?"), nl,
    read(W),
    getInput(W,Z),
    ubicacion(Z,[],LugarClave),
    updatePreferences(Result0,LugarClave,Result1),
    write(LugarClave), nl,
    validarlugar(K, LugarClave), % Aqu� deber�a saber donde dar la recomendacion, sabiendo el restaurante y validando que ese restaurante est� en el lugar donde el compa me dijo
    write("para cu�ntas personas?"), nl,
    read(A),
    getInput(A,B),
    personas(B,[],PersonasClave),
    updatePreferences(Result1,PersonasClave,Result2),
    write(PersonasClave), nl,
    validarcapacidad(K, PersonasClave),
    write(Result2),nl,
    direccion(K,S),
    atom_concat("Nuestra sugerencia es: Restaurante ", K, O1),
    atom_concat(O1, " que se ubica ", O2),
    atom_concat(O2, S, O3),
    write(O3), nl,
    write("Su reservaci�n ha sido tramitada"),
    disposiciones(D),
    write(D),nl,
    write("ok").

%==================  TUTORIAL  ====================%


%Todo lo que se escriba entre comillas y en min�scula todo.
%
%Para saber frases de alimentos v�lidas:
%alimento(S,[],R).
%
%Para saber frases de ubicaciones v�lidas:
%ubicacion(S,[],R).
%
%Para saber frases de cantidad de personas v�lidas:
%personas(S,[],R).


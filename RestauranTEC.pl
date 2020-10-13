%=======================  Restaurantes  =========================%

restaurante("Bella Italia").
restaurante("Italianisimo").
restaurante("McBurguesa").

disposiciones( "Solo se permiten burbujas y durante la espera se debe utilizar
mascarilla").

%=======================  Men�s  =========================%

mennu("Bella Italia", "Italiano", ["Pizza", ["Jam�n y Queso", "Suprema", "Hawaiana"], "Calzone", "Espagueti"]).

mennu("Italianisimo","Italiano" ,["Pizza", ["Pepperoni"], "Calzone", "Espagueti"] ).

mennu("McBurguesa","Comida Rapida" ,["Hamburguesas", "Tacos ", "papas"] ).

%=======================  Pizzas =========================%

pizza("Bella Italia", ["Jam�n y Queso", "Suprema", "Hawaiana"]).

pizza("Italianisimo", ["Pepperoni"]).

pizza("Italianisimo","Bella Italia").

%=======================  Comida Rapida =========================%

comidarapida("McBurguesa",["Hamburguesas", "Tacos ", "papas"]  ).
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

capacidad("talianisimo", 50).

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


%======================  PRINCIPAL  ========================%

miembro(X, [X|_]).
miembro(X, [_|R]):-miembro(X,R).

%Caso en que el compa quiera comer pizza
validaralimento(Y, X):-
    %Recibimos el alimento clave que quiere el compa
    %Buscar los restaurantes que tengan el alimento que el compa quiere
    %Retornar una lista con los posibles candidatos
    write(Y),
    Y == [pizza],
    write("Algun tipo de pizza especial?"),nl,
    read(L),
    %Buscar si el tipo est� en alg�n pizza

    pizza(X,B), miembro(L, B),write(X), nl

    %write(Z)
    .
    %buscaralimentorest(X)

%En caso de que el compa quiera comer comida r�pida
validaralimento(Y, X):-
    %Recibimos el alimento clave que quiere el compa
    %Buscar los restaurantes que tengan el alimento que el compa quiere
    %Retornar una lista con los posibles candidatos
    write(Y),
    miembro(r�pida, Y),
    write("Qu� tipo de comida r�pida?"),nl,
    read(L),
    %Buscar si el tipo est� en alg�n pizza

    comidarapida(X,B), miembro(L, B),write(X), nl
    .

validarlugar(Y, K):-
    lugar(K, Y)
    .

%obtenerMenu(X):-
    %restaurante([_|[X|_]]).


%revisarlugar(Y):-
    %Recibimos el alimento clave que quiere el compa
    %Buscar los restaurantes que tengan el lugar que el compa quiere
    %Retornar una lista con los posibles candidatos
    %write(Y)
    %.


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
    validarlugar(LugarClave, K), % Aqu� deber�a saber donde dar la recomendacion, sabiendo el restaurante y validando que ese restaurante est� en el lugar donde el compa me dijo
    write("para cu�ntas personas?"), nl,
    read(A),
    getInput(A,B),
    personas(B,[],PersonasClave),
    updatePreferences(Result1,PersonasClave,Result2),
    write(PersonasClave), nl,
    write(Result2),nl,
    write("ok"), nl.
["San Pedro"]

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


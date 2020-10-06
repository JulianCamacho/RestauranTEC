%=======================  ALIMENTOS  =========================%


alimento(S0,S,Claves):-
    pronombre(Num,S0,S1),
    sintagma_verbal(Num,Estado,S1,S2),
    sintagma_nominal(_Gen2,Num,Estado,S2,S, Claves).
                  %Género, número, estado del nombre

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

%pregunta(singular,[qué|S],S).
%pregunta(singular,[dónde|S],S).
%pregunta(singular,[cuál|S],S).

adjetivo(femenino,singular,[rápida|S],S).

nombre(masculino, singular, solido, [pollo|S],S).
nombre(femenino, singular, solido, [pizza|S],S).
nombre(femenino, singular, solido, [comida|S],S).
nombre(femenino, singular, liquido, [bebida|S],S).
%nombre(masculino, singular, [menu|S],S).

lugar([heredia|S],S).
lugar([cartago|S],S).
lugar([alajuela|S],S).
lugar([limón|S],S).

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



restaurantec():-
    write("¡Hola! ¿Qué desea comer hoy? Escriba su preferencia entre comillas por favor."), nl,
    read(X),
    getInput(X,Y),
    alimento(Y,[],AlimentoClave),
    updatePreferences([],AlimentoClave,Result0),
    write(AlimentoClave), nl,
    write("dónde?"), nl,
    read(W),
    getInput(W,Z),
    ubicacion(Z,[],LugarClave),
    updatePreferences(Result0,LugarClave,Result1),
    write(LugarClave), nl,
    write("para cuántas personas?"), nl,
    read(A),
    getInput(A,B),
    personas(B,[],PersonasClave),
    updatePreferences(Result1,PersonasClave,Result2),
    write(PersonasClave), nl,
    write(Result2),nl,
    write("ok"), nl.


%==================  TUTORIAL  ====================%


%Todo lo que se escriba entre comillas y en minúscula todo.
%
%Para saber frases de alimentos válidas:
%alimento(S,[],R).
%
%Para saber frases de ubicaciones válidas:
%ubicacion(S,[],R).
%
%Para saber frases de cantidad de personas válidas:
%personas(S,[],R).


/*
 * usuario(idUsuario,edad,estado,ciudad,[listaAmigos])
 * El primer punto pedia que ingresando un id de usuario
 * devolver una lista de todos aquellos usuarios que no son amigos del
 * ingresado, tienen mas de 42 años y viven en su misma ciudad.
 *
 * El punto 2 pedia ingresar una lista de usuarios y luego listar todas
 * las personas que tengan coontenida en su lista de amigos la lista
 * ingresada.
 *
 */

 :-dynamic(usuario/5).

 menu:-
    write("Ingrese una opcion: 1-Listar no amigos 2-Listar amigos contenidos."),
    read(Opcion),
    opcion(Opcion).

 opcion(3).
 opcion(1):-
    abrir_base,
    write("Ingrese un id de usuario: "),
    read(IdUsuario),
    retract(usuario(IdUsuario,_,_,Ciudad,_)),
    buscarNoAmigos(IdUsuario,Ciudad,ListaNoAmigos),
    write(ListaNoAmigos).
 opcion(2):-
    abrir_base,
    write("Ingrese una lista de usuarios: "),
    leer(Lista),
    listarUsuarios(Lista,ListaUsuarios),
    write(ListaUsuarios).

 buscarNoAmigos(IdUsuario,Ciudad,[Id|T]):-
    usuario(Id,Edad,_,Ciudad,ListaAmigos),
    Edad > 42,
    noPertenece(IdUsuario,ListaAmigos),
    retract(usuario(Id,_,_,_,_)),
    buscarNoAmigos(IdUsuario,Ciudad,T).

 buscarNoAmigos(_,_,[]).

 listarUsuarios(Lista,[Id,Edad,Ciudad|T]):-
    usuario(Id,Edad,_,Ciudad,ListaAmigos),
    esListaContenida(Lista,ListaAmigos),
    retract(usuario(Id,_,_,_,_)),
    listarUsuarios(Lista,T).

 listarUsuarios(_,[]).

 esListaContenida([H|T], Lista):-
    pertenece(H,Lista),
    esListaContenida(T,Lista).

 esListaContenida([],_).

 noPertenece(_,[]).
 noPertenece(X,[H|T]):- X\=H, noPertenece(X,T).

 pertenece(X,[X|_]).
 pertenece(X,[_|T]):-pertenece(X,T).

 leer([H|T]):-read(H),H\=[],leer(T).
 leer([]).

 abrir_base:-retractall(usuario/5),consult('C:/Users/andre/final_17-10.txt').

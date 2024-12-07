% Solución en Prolog

% 1.
vive(juan, casa(120)).
vive(nico, depto(3,2)).
vive(alf, depto(3,1)).
vive(julian, loft(2000)).
vive(vale, depto(4,1)).
vive(fer, casa(110)).

barrio(alf, almagro).
barrio(juan, almagro).
barrio(nico, almagro).
barrio(julian, almagro).
barrio(vale, flores).
barrio(fer, flores).

% 2. 
propiedadCopada(casa(Metros)) :- Metros > 100.
propiedadCopada(depto(Ambientes,_)) :- Ambientes > 3.
propiedadCopada(depto(_,Banos)) :- Banos > 1.
propiedadCopada(loft(Anio)) :- Anio > 2015.

barrioCopado(Barrio) :-
    barrio(_,Barrio),
    forall((barrio(Persona, Barrio), vive(Persona, Propiedad)), propiedadCopada(Propiedad)).

% 3. 
barata(loft(Anio)) :- Anio < 2005.
barata(casa(Metros)) :- Metros < 90.
barata(depto(Ambientes,_)) :- Ambientes =< 2.

barrioCaro(Barrio) :-
    barrio(_,Barrio),
    forall((barrio(Persona, Barrio), vive(Persona, Propiedad)), not(barata(Propiedad))).

% 4. 
valor(juan,150000).
valor(nico,80000).
valor(alf,75000).
valor(julian,140000).
valor(vale,95000).
valor(fer,60000).

comprar(Plata, Propiedades) :-
    findall(Persona, vive(Persona,_), PersonasConPropiedad),
    puedeComprar(Plata, PersonasConPropiedad, Propiedades).

puedeComprar(_,[],[]).
puedeComprar(PlataRestante, [Propiedad|Resto], Compradas) :-
    valor(Propiedad, Valor),
    PlataRestante < Valor,
    puedeComprar(PlataRestante, Resto, Compradas).
puedeComprar(PlataRestante, [Propiedad|Resto], [Propiedad|Compradas]) :-
    valor(Propiedad, Valor),
    PlataRestante >= Valor,
    puedeComprar(PlataRestante - Valor, Resto, Compradas).
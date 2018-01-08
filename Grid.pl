% Auteur:  Nathan Maraval
% Date: 03/01/2018

gridMaxX(1).
gridMaxY(1).

/*-------------------------------------*/
/*             Neighbours              */
/*-------------------------------------*/

/* Get all the neighbours coordinates of one point in a list
 * @param 1 : entrée : the coordinates of the point
 * @param 2 : sortie : a list with all the neighbours coordinates of the point
*/
getListNeighbour4([CoordX, CoordY], List):-
    findall(Voisin, neighbour4([CoordX, CoordY], Voisin), List).
    
/* Get all the neighbours coordinates
 * @param 1 : entrée : the coordinates of the point
 * @param 2 : sortie : the coordinates of a neighbour
*/
neighbour4([CoordX, CoordY], [NeighbourX, NeighbourY]) :-
    CoordX > 0,
    NeighbourX is CoordX - 1,
    NeighbourY is CoordY.
neighbour4([CoordX, CoordY], [NeighbourX, NeighbourY]) :-
    CoordY > 0,
    NeighbourX is CoordX,
    NeighbourY is CoordY - 1.
neighbour4([CoordX, CoordY], [NeighbourX, NeighbourY]) :-
    gridMaxX(SizeX),
    CoordX < SizeX,
    NeighbourX is CoordX + 1,
    NeighbourY is CoordY.
neighbour4([CoordX, CoordY], [NeighbourX, NeighbourY]) :-
    gridMaxY(SizeY),
    CoordY < SizeY,
    NeighbourX is CoordX,
    NeighbourY is CoordY + 1.
    
    
/* Pour les tests :

neighbour4([1, 0], Voisin).

[0, 0];
[2,0];
[1,1].

*/

/*-------------------------------------*/
/*         Access diagrammes           */
/*-------------------------------------*/

/* Accéde au diagramme d'une grille avec des coordonnées
 * @param 1 : entrée : une matrice contenant des diagrammes
 * @param 2 : entrée : la coordonnée en X du diagramme recherché
 * @param 3 : entrée : la coordonnée en Y du diagramme recherché
 * @param 3 : sortie : le diagramme contenue aux coordonnées données en entrée
*/

getDiagramme([[Diagramme | _] | _ ], 0, 0, Diagramme).

getDiagramme([[ _ | Line] | Grid ], CoordX, 0, Diagramme) :-
    CoordX > 0,
    NewCoordX is CoordX - 1,
    getDiagramme([Line | Grid], NewCoordX, 0, Diagramme).

getDiagramme([_ | Reste], CoordX, CoordY, Diagramme) :-
    CoordY > 0,
    NewCoordY is CoordY-1,
    getDiagramme(Reste, CoordX, NewCoordY, Diagramme).


/* test

getDiagramme([[diagA, diagB, diagC], [diagD, diagE, diagF], [diagG, diagH, diagI]], 1, 1, Diagramme).

Diagramme = diagE.

*/


/* Méthode permettant d'obtenir les coordonnées suivantes
 * @param 1 : entrée : la coordonnée en X actuelle
 * @param 2 : entrée : la coordonnée en Y actuelle
 * @param 3 : sortie : la coordonnée en X suivante
 * @param 4 : sortie : la coordonnée en Y suivante
*/

getNextCoordinates(CoordX, CoordY, NextCoordX, CoordY) :-
    gridMaxX(MaxX),
    CoordX < MaxX,
    NextCoordX is CoordX+1.
    
getNextCoordinates(CoordX, CoordY, 0, NextCoordY) :-
    gridMaxX(MaxX),
    CoordX = MaxX,
    NextCoordY is CoordY+1.


/*-------------------------------------*/
/*      Pemutations possibles          */
/*-------------------------------------*/

/* Méthode permettant d'obtenir toutes les permutations de diagrammes possibles sur une ligne
 * @param 1 : entrée : La liste des diagrammes à placer
 * @param 2 : entrée : le nombre de diagrammes à insérer dans la ligne
 * @param 3 : sortie : une liste des diagrammes et de la taille en entrée
 * @param 4 : sortie : le reste des diagrammes non placés
*/

fillLine(ListDiags, -1, [], ListDiags).
fillLine(ListDiags, SizeLine, [Diag | EndLine], ResteListeDiags):-
    choixDansListe(ListDiags, Diag, ResteListe),
    NewSize is SizeLine - 1,
    fillLine(ResteListe, NewSize, EndLine, ResteListeDiags).
    
/* Test

fillLine([diagA, diagB, diagC, diagD, diagE], 3, Line, ResteListe).

*/

/* Méthode permettant d'obtenir toutes les permutations diagrammes possibles sur une matrice
 * @param 1 : entrée : La liste des diagrammes à placer
 * @param 2 : sortie : une matrice contenant les diagrammes
*/

gridPermutations(ListDiags, Grid) :-
    gridPermutationsRec(ListDiags, 0, Grid).


gridPermutationsRec(_, EndLine, []) :-
    gridMaxY(MaxY),
    EndLine > MaxY.

gridPermutationsRec(ListDiags, ActualLine, [Line | ResteLines]) :-
    gridMaxY(MaxY),
    ActualLine =< MaxY,
    % Fill a line
    gridMaxX(MaxX),
    fillLine(ListDiags, MaxX, Line, ResteDiags),
    % Launch the recursion
    NewLine is ActualLine + 1,
    gridPermutationsRec(ResteDiags, NewLine, ResteLines).
    
    
/*

gridPermutations([diagA, diagB, diagC, diagD], Grid).

*/
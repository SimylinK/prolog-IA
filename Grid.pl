% Auteur:  Nathan Maraval
% Date: 03/01/2018

gridMaxX(1).
gridMaxY(1).

/*-------------------------------------*/
/*             Neighbours              */
/*-------------------------------------*/

/* Get all the neighbours coordinates of one point in a list
 * @param 1 : entr�e : the coordinates of the point
 * @param 2 : sortie : a list with all the neighbours coordinates of the point
*/
getListNeighbour4([CoordX, CoordY], List):-
    findall(Voisin, neighbour4([CoordX, CoordY], Voisin), List).
    
/* Get all the neighbours coordinates
 * @param 1 : entr�e : the coordinates of the point
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

/* Acc�de au diagramme d'une grille avec des coordonn�es
 * @param 1 : entr�e : une matrice contenant des diagrammes
 * @param 2 : entr�e : la coordonn�e en X du diagramme recherch�
 * @param 3 : entr�e : la coordonn�e en Y du diagramme recherch�
 * @param 3 : sortie : le diagramme contenue aux coordonn�es donn�es en entr�e
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


/* M�thode permettant d'obtenir les coordonn�es suivantes
 * @param 1 : entr�e : la coordonn�e en X actuelle
 * @param 2 : entr�e : la coordonn�e en Y actuelle
 * @param 3 : sortie : la coordonn�e en X suivante
 * @param 4 : sortie : la coordonn�e en Y suivante
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

/* M�thode permettant d'obtenir toutes les permutations de diagrammes possibles sur une ligne
 * @param 1 : entr�e : La liste des diagrammes � placer
 * @param 2 : entr�e : le nombre de diagrammes � ins�rer dans la ligne
 * @param 3 : sortie : une liste des diagrammes et de la taille en entr�e
 * @param 4 : sortie : le reste des diagrammes non plac�s
*/

fillLine(ListDiags, -1, [], ListDiags).
fillLine(ListDiags, SizeLine, [Diag | EndLine], ResteListeDiags):-
    choixDansListe(ListDiags, Diag, ResteListe),
    NewSize is SizeLine - 1,
    fillLine(ResteListe, NewSize, EndLine, ResteListeDiags).
    
/* Test

fillLine([diagA, diagB, diagC, diagD, diagE], 3, Line, ResteListe).

*/

/* M�thode permettant d'obtenir toutes les permutations diagrammes possibles sur une matrice
 * @param 1 : entr�e : La liste des diagrammes � placer
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
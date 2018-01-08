% Auteur: Maraval Nathan
% Date: 08/01/2018

/*-------------------------------------*/
/*             Neighbours              */
/*-------------------------------------*/

% neighbour4

:- begin_tests(neighbour4).

test(neighbour4_coin_haut_gauche) :-
        neighbour4([0, 0], [0, 1]).

:- end_tests(neighbour4).

% getListNeighbour4

:- begin_tests(getListNeighbour4).

test(getListNeighbour4_coin_haut_gauche) :-
        getListNeighbour4([0, 0], [[1, 0], [0,1]]).

:- end_tests(getListNeighbour4).

/*-------------------------------------*/
/*         Access diagrammes           */
/*-------------------------------------*/

% getDiagramme

:- begin_tests(getDiagramme).

test(getDiagramme_cas_darret) :-
        getDiagramme([[diagA, diagB], [diagC, diagD, diagE], [diagF, diagG, diagH] ], 0, 0, diagA).
        
test(getDiagramme_premiere_ligne) :-
        getDiagramme([[diagA, diagB, diagC], [diagD, diagE, diagF], [diagG, diagH, diagI] ], 1, 0, diagB).
        
test(getDiagramme_premiere_colonne) :-
        getDiagramme([[diagA, diagB, diagC], [diagD, diagE, diagF], [diagG, diagH, diagI] ], 0, 2, diagG).
        
test(getDiagramme_milieu) :-
        getDiagramme([[diagA, diagB, diagC], [diagD, diagE, diagF], [diagG, diagH, diagI] ], 1, 1, diagE).

:- end_tests(getDiagramme).


% getNextCoordinates

:- begin_tests(getNextCoordinates).

test(getNextCoordinates_0_0) :-
        getNextCoordinates(0, 0, 1, 0).

:- end_tests(getNextCoordinates).

/*-------------------------------------*/
/*      Pemutations possibles          */
/*-------------------------------------*/

% fillLine

:- begin_tests(fillLine).

test(fillLine_cas_darret) :-
        fillLine([diagA, diagB, diagC, diagD, diagE], -1, [], [diagA, diagB, diagC, diagD, diagE]).

test(fillLine_size4) :-
        fillLine([diagA, diagB, diagC, diagD, diagE], 3, [diagE, diagA, diagC, diagB], [diagD]).

:- end_tests(fillLine).

% gridPermutations

:- begin_tests(gridPermutations).

test(gridPermutationsRec_cas_darret) :-
        gridPermutationsRec([diagA, diagB, diagC, diagD, diagE], 100, []).


:- end_tests(gridPermutations).
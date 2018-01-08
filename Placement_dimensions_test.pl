% Auteur: Nathan Maraval
% Date: 08/01/2018

/*-------------------------------------*/
/*             Permutations            */
/*-------------------------------------*/

:- consult('Placement_dimensions').

% choixDansListe

:- begin_tests(choixDansListe).

test(choixDansListe_1_element) :-
        choixDansListe([a], a, []).
        
test(choixDansListe_3_elements) :-
        choixDansListe([a, b, c], b, [a, c]).

:- end_tests(choixDansListe).

% permutation

:- begin_tests(permutations).

test(permutation_1_element) :-
        permutation([a], [a]).

test(permutation_3_elements) :-
        permutation([a, b, c], [b, a, c]).

:- end_tests(permutations).

% permutationsDimensions

:- begin_tests(permutationsDimensions).

test(permutationsDimensions_1_element) :-
        permutation([a], [a]).

test(permutationsDimensions_3_elements) :-
        permutation([a, b, c], [a, c, b]).

:- end_tests(permutationsDimensions).


/*-------------------------------------*/
/*      Calcul de l'aire               */
/*-------------------------------------*/

% aireTriangle

:- begin_tests(aireTriangle).

test(aireTriangle) :-
        aireTriangle(diagA, dim1, dim2, 0.125).

:- end_tests(aireTriangle).

% aireDiagramme

:- begin_tests(aireDiagramme).

test(aireDiagramme_dernier_dim) :-
        aireDiagramme(diagA, [dim5], 0.25).

test(aireDiagramme_diagA) :-
        aireDiagramme(diagA, [dim1, dim2, dim3, dim4, dim5], 1.325).

:- end_tests(aireDiagramme).

% sommeAireDiagrammes

:- begin_tests(sommeAireDiagrammes).

test(sommeAireDiagrammes_dernier_diagA) :-
        sommeAireDiagrammes([diagA], [dim1, dim2, dim3, dim4, dim5], 1.325).

test(sommeAireDiagrammes_3_diags) :-
        sommeAireDiagrammes([diagA, diagB, diagC], [dim1, dim4, dim2, dim3, dim5], 3.1700000000000004).

:- end_tests(sommeAireDiagrammes).


/*-------------------------------------*/
/*    Meilleur placement dimensions    */
/*-------------------------------------*/

% placementDimensions

:- begin_tests(placementDimensions).

test(placementDimensions) :-
        placementDimensions([diagA, diagB, diagC], [dim1, dim2, dim3, dim4, dim5], [dim1, dim4, dim2, dim3, dim5], 3.1700000000000004).

:- end_tests(placementDimensions).

% meilleurPlacementDimensions

:- begin_tests(meilleurPlacementDimensions).

test(meilleurPlacementDimensions) :-
        meilleurPlacementDimensions([diagA, diagB, diagC, diagD], [dim1, dim2, dim3, dim4, dim5], [dim1, dim5, dim4, dim2, dim3], 4.811666666666667).

:- end_tests(meilleurPlacementDimensions).

% getMax

:- begin_tests(getMax).

test(getMax_1_couple) :-
        getMax([[[dim1, dim2, dim3], 10]] , [dim1, dim2, dim3], 10).

test(getMax_3_couple) :-
        getMax([[[dim1, dim2, dim3], 10], [[dim3, dim1, dim2], 10.5], [[dim2, dim3, dim1], 5]] , [dim3, dim1, dim2], 10.5).

:- end_tests(getMax).
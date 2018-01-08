% Auteur: Nathan Maraval
% Date: 03/01/2018

:- consult('jeu_de_test').
:- consult('Placement_dimensions').
:- consult('placement_diagrammes').


% Test placement des dimensions

testDims(Placement) :-
    listDiags(ListDiag),
    listDim(ListDim),
    meilleurPlacementDimensions(ListDiag, ListDim, Placement, _).


% Test placement diagrammes

testLine(Placement) :- meilleurPlacementDiagrammeLigne([diagA, diagB, diagC, diagD], [dim1, dim2, dim3, dim4, dim5], Placement).


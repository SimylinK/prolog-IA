% Auteur: Nathan Maraval
% Date: 03/01/2018

listDiags([diagA, diagB, diagC, diagD]).

listDim([dim1, dim2, dim3, dim4, dim5]).

/* Fonction qui définie la valeur max de toutes les dimensions */
maxDim(dim1, 10).
maxDim(dim2, 6).
maxDim(dim3, 5).
maxDim(dim4, 4).
maxDim(dim5, 5).

/* Fonction qui définis pour chaque dimension de chaque diagramme une valeur */
value(diagA, dim1, 5).
value(diagA, dim2, 3).
value(diagA, dim3, 3).
value(diagA, dim4, 4).
value(diagA, dim5, 5).

value(diagB, dim1, 4).
value(diagB, dim2, 2).
value(diagB, dim3, 5).
value(diagB, dim4, 0).
value(diagB, dim5, 1).

value(diagC, dim1, 9).
value(diagC, dim2, 5).
value(diagC, dim3, 4).
value(diagC, dim4, 3).
value(diagC, dim5, 4).

value(diagD, dim1, 8).
value(diagD, dim2, 5).
value(diagD, dim3, 5).
value(diagD, dim4, 3).
value(diagD, dim5, 2).

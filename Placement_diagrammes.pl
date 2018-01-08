% Auteur: Yao Shi et Nathan Maraval
% Date: 03/01/2018






/*-------------------------------------*/
/*      Calcul de la différence        */
/*-------------------------------------*/

/* Code initialement fais par Yao Shi et Nathan Maraval lors du tp du 13/12/2017 */


/* Fonction qui compare la différence de 2 diagrammes */

/*
 * @param 1 : entrée : le diagramme A
 * @param 2 : entrée : le diagramme B
 * @param 3 : entrée : la liste des dimensions dans l'ordre
 * @param 4 : différence : la différence de les 2 diagrammes
*/

/* Fonction qui compare la différence de 2 diagrammes sur une dimension*/
compareDeuxDiagUneDim(DiagA, DiagB, Dim, Diff):-
    maxDim(Dim, MaxDim),
    value(DiagA, Dim, ValueDiagDimA),
    value(DiagB, Dim, ValueDiagDimB),
    Diff is abs(ValueDiagDimA - ValueDiagDimB) / MaxDim.

/* Fonction qui compare la différence de 2 diagrammes*/
compareDeuxDiagrammes(DiagA, DiagB, [], 0).
compareDeuxDiagrammes(DiagA, DiagB, [Dim | ListeDim], SommeDiff):-
    compareDeuxDiagUneDim(DiagA, DiagB, Dim, Diff),
    compareDeuxDiagrammes(DiagA, DiagB, ListeDim, AutreDiff),
    SommeDiff is AutreDiff + Diff.

/* Fonction qui calcul la différence de tous les diagrammes dans une liste*/
compareToutDiagrammes([DernierDiag], ListeDim, 0).
compareToutDiagrammes([DiagA, DiagB | ListeDiag], ListeDim, ToutDiff):-
    compareDeuxDiagrammes(DiagA, DiagB, ListeDim, SommeDiff),
    compareToutDiagrammes([DiagB | ListeDiag], ListeDim, AutreSommeDiff),
    ToutDiff is AutreSommeDiff + SommeDiff.

/* Fonction qui calcul la différence de tout diagrammes de tout les listes*/
compareTouteLesListes(ListDiag, ListeDim, ListDiagPermutes, ToutDiffDeListe):-
    permutations(ListDiag, ListDiagPermutes),
    compareToutDiagrammes(ListDiagPermutes, ListeDim, ToutDiff),
    ToutDiffDeListe is ToutDiff.

meilleurPlacementDiagrammeLigne(ListDiag, ListeDim, Placement):-
    bagof([ListDiagPermutes, ToutDiffDeListe],compareTouteLesListes(ListDiag, ListeDim, ListDiagPermutes, ToutDiffDeListe),Bag),
    getMax(Bag, Placement, ToutDiffDeListe).
    
    
    
/*-------------------------------------*/
/*      Placement en grille            */
/*-------------------------------------*/


:- consult('Grid').

getScoreGrid(Grid, ScoreDiff) :-
    getScoreGridRec(Grid, 0, 0, ScoreDiff).


getScoreGridRec(Grid, CoordX, CoordY, 0) :-
    gridMaxX(MaxX),
    CoordX = MaxX,
    gridMaxX(MaxY),
    CoordY = MaxY.
    
getScoreGridRec(Grid, CoordX, CoordY, ScoreDiff) :-
    gridMaxX(MaxX),
    CoordX =< MaxX,
    gridMaxX(MaxY),
    CoordY =< MaxY,
    compareDiagrammeInGrid(Grid, CoordX, CoordY, Diff),
    getNextCoordinates(CoordX, CoordY, NextCoordX, NextCoordY),
    getScoreGridRec(Grid, NextCoordX, NextCoordY, ScoreOther),
    ScoreDiff is Diff + ScoreOther.


compareDiagrammeInGrid(Grid, CoordX, CoordY, Diff) :-
    getDiagramme(Grid, CoordX, CoordY, Diag),
    % Neighbour4
    getListNeighbour4([CoordX, CoordY], ListNeighbour4),
    compareDiagrammesGrid(Grid, Diag, ListNeighbour4, DiffNeighbour4),
    % TODO : Neighbour8
    Diff is DiffNeighbour4.
    

compareDiagrammesGrid(_, _, [], 0).
    
compareDiagrammesGrid(Grid, DiagA, [[CoordX, CoordY] | OtherDiags], Diff) :-
    getDiagramme(Grid, CoordX, CoordY, DiagB),
    compareDeuxDiagrammes(DiagA, DiagB, [dim1, dim2, dim3, dim4, dim5], Diff2Diags),
    compareDiagrammesGrid(Grid, DiagA, OtherDiags, DiffOther),
    Diff is Diff2Diags + DiffOther.

/* Test

compareDiagrammeInGrid([[diagA, diagB], [diagC, diagD]], 0, 1, Diff).

getScoreGrid([[diagA, diagB], [diagC, diagD]], Score).

*/


compareAllTheGrid(Grid, Score) :-
    listDiags(ListDiags),
    gridPermutations(ListDiags, Grid),
    getScoreGrid(Grid, Score).

meilleurPlacementGrid(BestGrid):-
    bagof([Grid, Score],compareAllTheGrid(Grid, Score),Bag),
    getMax(Bag, BestGrid, Score).
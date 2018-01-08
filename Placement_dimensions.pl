/*-------------------------------------*/
/*             Permutations            */
/*-------------------------------------*/

/* Pour faire  toutes les permutations */
/* Code initialement fais par Yao Shi et Nathan Maraval lors du premier TP le  07/12/2017*/

/* Méthode qui va sortir toutes les permutations utiles pour les dimensions
   La première dimension est fixée sur la première position
 * @param 1 : entrée : la liste des éléments à permuter
 * @param 2 : sortie : la liste des éléments permutés
*/
permutationsDimensions([X | Liste], Sortie):-
   permutations(Liste, Permutation),
   Sortie = [X | Permutation].


/* Méthode qui va sortir toutes les permutations possibles d'une liste
 * @param 1 : entrée : la liste des éléments à permuter
 * @param 2 : sortie : la liste des éléments permutés
*/
permutations([DernierElement], ListeSortie):-
   ListeSortie = [DernierElement].
permutations(ListEntree, [ElementChoisis | FinSortie]):-
    choixDansListe(ListEntree, ElementChoisis, ResteListe),
    permutations(ResteListe, FinSortie).

/* Méthode qui va choisir un élément dans une liste
 * @param 1 : entrée : la liste dans laquelle on va chercher un élément
 * @param 2 : sortie : l'élément choisi
 * @param 3 : sortie : une liste contenant tous les autres éléments
*/
choixDansListe([A | FinListe], ElementChoisis, ResteListe) :-
    ElementChoisis = A,
    ResteListe = FinListe.
choixDansListe([PremierElement | FinListe], ElementChoisis, [PremierElement | ResteListe]) :-
    choixDansListe(FinListe, ElementChoisis, ResteListe).


/*-------------------------------------*/
/*      Calcul de l'aire               */
/*-------------------------------------*/

/* Code initialement fais par Yao Shi et Nathan Maraval lors du tp du 12/12/2017 */

/* pré-condition : Dim1 et Dim2 sont à placé à côté */

/* Donne l'aire d'un triangle sur le diagramme
 * @param 1 : entrée : le diagramme
 * @param 2 : entrée : la première dimension
 * @param 3 : entrée : une liste contenant tous les autres élémentsla seconde dimension
 * @param 4 : sortie : l'aire du triangle
*/
aireTriangle(Diag, Dim1, Dim2, Aire):-
    maxDim(Dim1, MaxDim1),
    maxDim(Dim2, MaxDim2),
    value(Diag, Dim1, ValueDiagDim1),
    value(Diag, Dim2, ValueDiagDim2),
    Aire is (1/2) * (ValueDiagDim1/MaxDim1) * (ValueDiagDim2/MaxDim2).



/* Donne l'aire d'un diagramme
 * @param 1 : entrée : le diagramme
 * @param 2 : entrée : la liste des dimensions dans l'ordre
 * @param 4 : sortie : l'aire du diagramme
*/

% Cas où on a fais le tour du diagramme, et il faut calculer l'aire du dernier triangle
aireDiagramme(Diag, [DernierDim], Aire):-
    aireTriangle(Diag, DernierDim, dim1, Aire).
aireDiagramme(Diag, [DimA, DimB | ListeDim], Aire):-
    aireTriangle(Diag, DimA, DimB, AireTriangle),
    aireDiagramme(Diag, [DimB | ListeDim], AireReste),
    Aire is AireTriangle + AireReste.


/* Code initialement fais lors du tp du 13/12/2017 par Yao Shi et Maraval Nathan */

/* Calcul la somme de l'aires des diagrammes
 * @param 1 : entrée : la liste des diagrammes
 * @param 2 : entrée : la liste des dimensions dans un ordre
 * @param 4 : sortie : l'aire du diagramme
*/
sommeAireDiagrammes([Diagramme], ListeDim, Aire):-
   aireDiagramme(Diagramme, ListeDim, Aire).
sommeAireDiagrammes([Diagramme |ListeDiag], ListeDim, Aire):-
   aireDiagramme(Diagramme, ListeDim, AireDiag),
   sommeAireDiagrammes(ListeDiag, ListeDim, AireReste),
   Aire is AireDiag + AireReste.


/*-------------------------------------*/
/*    Meilleur placement dimensions    */
/*-------------------------------------*/

/* Test toutes les permutations de dimension possibles et calcul l'aire associé
 * @param 1 : entrée : la liste des diagrammes
 * @param 2 : entrée : la liste des dimensions
 * @param 4 : sortie : une permutation de dimensions
 * @param 5 : sortie : l'aire associé à la permutation
*/
placementDimensions(ListeDiag, ListeDimensions, Placement, Aire):-
   permutationsDimensions(ListeDimensions, Placement),
   sommeAireDiagrammes(ListeDiag, Placement, Aire).

/* Donne la permutation de dimension avec la plus grande aire
 * @param 1 : entrée : la liste des diagrammes
 * @param 2 : entrée : la liste des dimensions
 * @param 3 : sortie : la meilleur permutation de dimension
 * @param 4 : sortie : l'aire associé au placement des dimensions choisi
*/
meilleurPlacementDimensions(ListeDiag, ListeDimensions, Placement, Aire):-
   bagof([Placement, Aire],placementDimensions(ListeDiag, ListeDimensions, Placement, Aire),Bag),
   getMax(Bag, Placement, Aire).

/* Méthode qui renvoie le couple avec la plus grande deuxième valeur dans une liste de couples
 * @param 1 : entrée : une liste de couple avec un nombre en deuxième valeur
 * @param 2 : sortie : la première valeur du couple avec la plus grande seconde valeur
 * @param 3: sortie : la plus grande seconde valeur dans la liste
*/
getMax([[Placement, Aire]], Placement, Aire).
getMax([[PlacementTmp, AireTmp] | ListePairePlacementAire], Placement, Aire):-
   getMax(ListePairePlacementAire, PlacementActuel, AireActuel),
   ( AireTmp > AireActuel ->
      Aire = AireTmp,
      Placement = PlacementTmp
   ;  Aire = AireActuel,
      Placement = PlacementActuel
   ).

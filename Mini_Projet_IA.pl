/*-------------------------------------*/
/*             Permutations            */
/*-------------------------------------*/


/* Pour faire  toutes les permutations */
/* Code initialement fais par Yao Shi et Nathan Maraval lors du premier TP le  07/12/2017*/

/* M�thode qui va sortir toutes les permutations utiles pour les dimensions
   La premi�re dimension est fix�e sur la premi�re position
 * @param 1 : entr�e : la liste des �l�ments � permuter
 * @param 2 : sortie : la liste des �l�ments permut�s
*/
permutationsDimensions([X | Liste], Sortie):-
   permutations(Liste, Permutation),
   Sortie = [X | Permutation].


/* M�thode qui va sortir toutes les permutations d'une liste
 * @param 1 : entr�e : la liste des �l�ments � permuter
 * @param 2 : sortie : la liste des �l�ments permut�s
*/
permutations([DernierElement], ListeSortie):-
   ListeSortie = [DernierElement].
permutations(ListEntree, [ElementChoisis | FinSortie]):-
    choixDansListe(ListEntree, ElementChoisis, ResteListe),
    permutations(ResteListe, FinSortie).

/* M�thode qui va choisir un �l�ment dans une liste
 * @param 1 : entr�e : la liste dans laquelle on va chercher un �l�ment
 * @param 2 : sortie : l'�l�ment choisi
 * @param 3 : sortie : une liste contenant tous les autres �l�ments
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


/* Fonction qui d�finie la valeur max de toutes les dimensions */
max(dim1, 10).
max(dim2, 6).
max(dim3, 5).
max(dim4, 4).
max(dim5, 5).

/* Fonction qui d�finis pour chaque dimension de chaque diagramme une valeur */
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

/* pr�-condition : Dim1 et Dim2 sont � plac� � c�t� */

/* Donne l'aire d'un triangle sur le diagramme
 * @param 1 : entr�e : le diagramme
 * @param 2 : entr�e : la premi�re dimension
 * @param 3 : entr�e : une liste contenant tous les autres �l�mentsla seconde dimension
 * @param 4 : sortie : l'aire du triangle
*/
aireTriangle(Diag, Dim1, Dim2, Aire):-
    max(Dim1, MaxDim1),
    max(Dim2, MaxDim2),
    value(Diag, Dim1, ValueDiagDim1),
    value(Diag, Dim2, ValueDiagDim2),
    Aire is (1/2) * (ValueDiagDim1/MaxDim1) * (ValueDiagDim2/MaxDim2).



/* Donne l'aire d'un diagramme
 * @param 1 : entr�e : le diagramme
 * @param 2 : entr�e : la liste des dimensions dans l'ordre
 * @param 4 : sortie : l'aire du diagramme
*/

/*  Cas o� on a fais le tour du diagramme, et il faut calculer l'aire du dernier triangle */
aireDiagramme(Diag, [DernierDim], Aire):-
    aireTriangle(Diag, DernierDim, dim1, Aire).
aireDiagramme(Diag, [DimA, DimB | ListeDim], Aire):-
    aireTriangle(Diag, DimA, DimB, AireTriangle),
    aireDiagramme(Diag, [DimB | ListeDim], AireReste),
    Aire is AireTriangle + AireReste.


/* Code initialement fais lors du tp du 13/12/2017 par Yao Shi et Maraval Nathan */

/* Calcul la somme de l'aires des diagrammes pour 1 placement de dimension
 * @param 1 : entr�e : la liste des diagrammes
 * @param 2 : entr�e : la liste des dimensions dans un ordre
 * @param 4 : sortie : l'aire du diagramme
*/
sommeAireDiagrammes([Diagramme], ListeDim, Aire):-
   aireDiagramme(Diagramme, ListeDim, Aire).
sommeAireDiagrammes([Diagramme |ListeDiag], ListeDim, Aire):-
   aireDiagramme(Diagramme, ListeDim, AireDiag),
   sommeAireDiagrammes(ListeDiag, ListeDim, AireReste),
   Aire is AireDiag + AireReste.



placementDimensions(ListeDiag, ListeDimensions, Placement, Aire):-
   permutationsDimensions(ListeDimensions, Placement),
   sommeAireDiagrammes(ListeDiag, Placement, Aire).

meilleurPlacementDimensions(ListeDiag, ListeDimensions, Placement, Aire):-
   placementDimensions(ListeDiag, ListeDimensions, Placement, Aire),    % Find the federation for which
  \+((                % there are no
    federation(_, _, _, AutreAire), % other federation with
    AutreAire > Aire             % more qualified countries
  )).



/*-------------------------------------*/
/*             Tests                   */
/*-------------------------------------*/


/* Code fais pour tester des fonctionnalit�s  */

parent('Martin', 'Pierre').
parent('John', 'Pierre').


somme([X], Solution):-
   Solution is X.
somme([X | FinListe], Solution):-
   somme(FinListe, Resultat),
   Solution is Resultat + X.


test(Liste, Solution):-
   Solution = Liste.


element([X | FinListe], Solution):-
    Solution = X.
element([X | FinListe], Solution):-
    element(FinListe, Solution).


inverse([X, Y], [Y, X]).
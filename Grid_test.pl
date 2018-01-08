% Auteur: Maraval Nathan
% Date: 08/01/2018

/*-------------------------------------*/
/*             Neighbours              */
/*-------------------------------------*/

% choixDansListe

:- begin_tests(choixDansListe).

test(choixDansListe_1_element) :-
        choixDansListe([a], a, []).

test(choixDansListe_3_elements) :-
        choixDansListe([a, b, c], b, [a, c]).

:- end_tests(choixDansListe).
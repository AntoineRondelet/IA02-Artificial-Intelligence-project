

%****************************************************  PROJET IA02 RONDELET ANTOINE/VOINIER BRUNO  ***************************************************
%======================================================================================================================================================
%*************************************************************  CODE COMMENTE  ************************************************************************




%NB: on a fait de nombreuses entrees dans notre code qui sont les predicats a entres directement dans le terminal pour obtenir un resultat. On a passe en argument des valeurs arbitraire simplement pour faciliter nos test lors de l elaboration du code.


%************************************************************** PREDICAT D INTERFACE ****************************************************************

accueil(ChoixJeu):- nl,nl,nl,nl,nl,write('     ******************************************************************'),nl, write('   *********************   CHICAGO STOCK EXCHANGE   ***********************'),nl,
write(' *******************************************************************************'), nl,nl,nl,nl,
write('----->    UN PROJET DE ANTOINE RONDELET ET DE BRUNO  VOINIER DANS LE CADRE DE L UV IA02 (UTC)    <------'), nl,nl,nl,nl,
write('______________________________BIENVENUE DANS LE MENU___________________________'), nl,nl,
write('____________________________CHOISISSEZ LE MODE DE JEU__________________________'), nl,nl,
write(' ------->   AFFRONTER UN AMIS : HOMME/HOMME (1)'),nl,nl,
write(' ------->   AFFRONTER LA MACHINE : HOMME/MACHINE (2)'),nl,nl,
write(' ------->   ASSISSTER A UNE PARTIE MACHINE/MACHINE (3)'),nl, read(ChoixJeu), confirmation(ChoixJeu),nl,nl,nl.


confirmation(1):- partie(36, [6,6,6,6,6,6], [ble,mais,riz,sucre,cafe,cacao], Res, TraderDebut, 1, 1, 1, [[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]], [], PositionTraderArrivee, ListeDepart, ListeArrivee, PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, []).

confirmation(2):- boucleDeJeuHumainVSMachine(1,1,[[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]],1,1,[[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]], [], PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, []).

confirmation(3):- boucleDeJeuMachineVSMachine(1,1,[[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]],1,1,[[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]], [], PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, []).

confirmation(X):- X\=1, X\=2, X\=3, write('  Sorry, nous n avons pas le mode que vous avez demandé, choisissez un autre mode :  '),nl, write('A quel mode de jeu voulez vous jouer ? HOMME/HOMME(1), HOMME/MACHINE(2), MACHINE/MACHINE(3)'), read(ChoixJeu2), confirmation(ChoixJeu2).


%****************************************************************************************************************************************************


%********************************************* Predicats de "base" qui nous ont servit tout au long du code ******************************************

 
choixE([],[]).
choixE(List, Element):-length(List, Res),	
		random(1, Res, Index),
		nth1(Index, List, Element).


nth1(1,[X|_],X) :- !. %car le prolog de chez antoine ne le connait pas
nth1(Idx,[_|List],X) :-Idx > 1,Idx1 is Idx-1,
    			nth1(Idx1,List,X).


ajoutTete(X,L,[X|L]).


%N=Nbre d elements dans la liste
%[T|S] la liste aleatoirement retournée
%L=la liste de marchandises initiales


%OK compte le nombre de X presents dans une liste
compteNbreDeXDansUneListe(0, X, []).
compteNbreDeXDansUneListe(N, X, [T|Q]):- T\=X, compteNbreDeXDansUneListe(N, X, Q),!.
compteNbreDeXDansUneListe(N, X, [X|Q]):- compteNbreDeXDansUneListe(M, X, Q), N is M+1.


concat([],L,L).
concat([T|Q],L,[T|R]):-concat(Q,L,R).


substitue(_,_,[],[]).
substitue(X,Y,[X|Q],[Y|NQ]):-substitue(X,Y,Q,NQ).
substitue(X,Y,[T|Q],[T|Res]):- T\=X, substitue(X,Y,Q,Res).

%Surtout utilise pour remplacer les anciennes valeurs de marchandises par les nouvelles dans nos bourses

%************************************GENERE LE PLATEAU GRAPHIQUEMENT*************************************

ligneValeur([T|[]]):-write(T),!.
ligneValeur([T|Q]):-write(T), write('|'),ligneValeur(Q).  
 
%Me genere le plateau (carré) du jeu avec les valeurs de chaque marchandises


afficheLigneValeur([T|[]]):-ligneValeur(T),!.
afficheLigneValeur([T|Q]):-ligneValeur(T),nl,write('-----------------'),nl,afficheLigneValeur(Q).


affichePlateau(L):-afficheLigneValeur(L),nl.

%Entree : affichePlateau([[7,6,5,4,3,2,1],[6,5,4,3,2,1,0],[6,5,4,3,2,1,0],[6,5,4,3,2,1,0],[6,5,4,3,2,1,0],[6,5,4,3,2,1,0]]).


%COMMENTAIRE:

%Ce predicat, non demande dans le sujet du projet, pourrait nous servir dans le cadre d une amelioration puisqu il represente la tableau meme sur lequel repose. On pourrait donc penser afficher la bourse sous cette forme graphique a chaque tour, avec un signe comme le - qui indique la valeur courante de la marchandise.
%cf lien joint: http://www.google.fr/imgres?imgurl=http%3A%2F%2Fidata.over-blog.com%2F1%2F01%2F60%2F96%2FLES-JEUX%2FJEUX-STRATEGIE%2FPAK-CHICAGO-JEU.JPG&imgrefurl=http%3A%2F%2Faillantrecreajeux.over-blog.fr%2Farticle-chicago-stock-exchange-un-jeu-de-pak-cormier-121732865.html&h=347&w=382&tbnid=reUW5OKpRJ8cNM%3A&zoom=1&docid=6OeXZD5xT-oPGM&ei=ICR_VayqMoPW7Aa-z4CgAw&tbm=isch&client=ubuntu&iact=rc&uact=3&dur=50&page=1&start=0&ndsp=28&ved=0CDMQrQMwBmoVChMIrLqXqLSSxgIVAyvbCh2-JwA0

%**********************************************************************************************************







%********************************   LA BOUCLE HUMAIN/HUMAIN ET LES PREDICATS LIES   **********************************


genereMarchandises(0,_,ListeM,_).
genereMarchandises(NbreJ,ListCompteur,ListeM,[ElementM|L]):-
				repeat, random(1, 7, X), nth1(X, ListCompteur, ElementC), 
				nth1(X, ListeM, ElementM), 
				reduitDispo(ListCompteur, X, EtatSucc), 
				%concat([ElementM], Colonne, ResColonne),
				NouveauNbreJ is NbreJ - 1,
				genereMarchandises(NouveauNbreJ,EtatSucc,ListeM,L).



%ENTREE : genereMarchandises(36,[6,6,6,6,6,6],[ble,riz,sucre,mais,cacao,cafe],ListeGeneree).

%COMMENTAIRE
%Le predicat genereMarchandises genere une liste de 36 marchandises aleatoirement (36 marchandises car 4 jetons dans 9 piles) dans la variable ListeGeneree


%-------------------------------------------------------------------------------------
	
reduitDispo([T|Q], 1, [Nt|Q]):-	Nt is T-1, Nt>=0,!. 		
reduitDispo([T|Q], X, Resultat):- Y is X-1,reduitDispo(Q, Y, Res), concat([T], Res, Resultat). 		
	
%COMMENTAIRE:

%Ce predicat retire 1 a la liste compteur [6,6,6,6,6,6] lorsqu une marchandise est placée dans une liste (on utilise nth1 deux fois, 1 fois pour prendre la marchandise correspondant a la position N dans la liste des marchandises possible et une deuxieme fois pour decrementer le compteur de la meme marchandise (on prend la Neme position de la liste compteur)).

%-------------------------------------------------------------------------------------


decoupe([],[]).
decoupe([T1,T2,T3,T4|Q],[[T1,T2,T3,T4]|Res]):-decoupe(Q,Res).

%COMMENTAIRE:

%decoupe(X,L,Res) permet de decouper notre longue liste en liste de listes de quatres elements. Chaque sous liste correspondant a une pile de marchandises

%-------------------------------------------------------------------------------------

generePiles(NbreJ,ListCompteur,ListeM,Res):-genereMarchandises(NbreJ,ListCompteur,ListeM,X), decoupe(X,Res).

%COMMENTAIRE:

%Le predicat generePiles genere une longue liste de 36 marchandises (NbreJ = 36) que l on decoupe en listes de listes grace au predicat decoupe (pour fabriquer les colonnes). Le predicat decoupe, prend les 4 premiers elements d une liste et les place dans une sous liste de cette meme liste.


%ENTREE: generePiles(36,[6,6,6,6,6,6],[ble,mais,riz,cacao,cafe,sucre],Res).

%-------------------------------------------------------------------------------------

generePlateau(NbreJ,ListCompteur,ListeM,Res,Trader,X):- 
							write('------------------------------PLATEAU----------------------------'),nl,
							generePiles(NbreJ,ListCompteur,ListeM,Res), generePilesEtPlaceLeTrader(Trader,Res,X).

%COMMENTAIRE:

%ENTREE: generePlateau(36,[6,6,6,6,6,6],[ble,mais,riz,cacao,cafe,sucre],Res,Trader,1). ATTENTION X equivaut a la premiere valeur de ma pile.Ca sera donc TOUJOURS 1 car les numerotations des piles commencent a 1.

%NB: Il aurait ete judicieux et plus pratique de faire des predicats de la forme : generePlateau(NbreJ,ListCompteur,ListeM,Res,Trader):- generePlateau(NbreJ,ListCompteur,ListeM,Res,Trader,1) de facon a ce que la numerotation des piles commence toujours a  1 sans avoir a sen preocuper. 

%------------------------------------------------------------------------------------- 

generePilesEtPlaceLeTrader(Trader,Res,X):-random(1,10,Trader), affichageTeteEtTrader(Res,Trader,X).


%COMMENTAIRE:

%Ici on genere aleatoirement le trader (un nombre entre 1 et 9 (inclus)) et on fait tourner le predicat affichageTeteEtTrader

%Res est en realite notre liste de marchandises de la forme [[a,b],[c,d],...,[e,f]] et X DOIT TOUJOURS VALOIR 1 dans notre entree car c est la valeur de la premiere colonne donc la premiere colonne doit etre associee a 1 et les autres colonnes auront un numero qui decoulera de l incrementation de X.

%NB: Ici le fait de faire random(1,10,Trader) ne gene pas puisque le trader n est genere aleatoirement qu une fois au debut de la partie. Donc on a forcement nos 9 colonnes au depart. 

%-------------------------------------------------------------------------------------

afficheTeteEtTrader([T|Q],Trader,Trader):- write('Pile'), write(Trader), write(':'), write(T), write('     <===== TRADER'), nl.

afficheTeteEtTrader([T|Q],Trader,X):- X\=Trader, write('Pile'), write(X), write(':'), write(T), nl.

%Ici on traite deux cas: le cas ou le nombre aleatoirement généré ((Trader) qui correspond a la position du trader) est egal au numero d une colonne, auquel cas on fait un affichage du mot pile et de son numero suivi d une fleche indiquant la position du trader.
%2eme option le cas ou la position du trader n est pas egale a un numero de pile auquel cas on affiche juste la pile et son numero suivi de sa tete (sans indiquer le trader puisqu il n est pas censé etre sur cette pile) 

%-------------------------------------------------------------------------------------

affichageTeteEtTrader([],_,_).
affichageTeteEtTrader([K|Q],Trader,X):-afficheTeteEtTrader(K,Trader,X), Y is X+1, affichageTeteEtTrader(Q,Trader,Y).

%predicat qui fait tourner le predicat afficheTeteEtTrader sur l ensemble de nos listes de marchandises, de maniere a ne voir QUE les jetons en tete de pile (pour se rapprocher le plus possible du jeu reel).

%-------------------------------------------------------------------------------------


%coup_possible(Plateau,Coup).
coup_possible(Plateau,TraderDepart,Deplacement,TraderArrivee,ListeDepart,ListeArrivee):- 
							Deplacement >=1, Deplacement =<3,
							nth1(TraderDepart,Plateau, ListeDepart),
							length(Plateau,X),
							TraderArrivee is TraderDepart + Deplacement,
							TraderArrivee=<X,
							nth1(TraderArrivee, Plateau, ListeArrivee),
							listeArriveeValide(ListeArrivee),!.


coup_possible(Plateau,TraderDepart,Deplacement,TraderArrivee,ListeDepart,ListeArrivee):- 
							Deplacement >=1, Deplacement =<3,
							nth1(TraderDepart,Plateau, ListeDepart),
							length(Plateau,X),
							TraderA is TraderDepart + Deplacement,
							TraderA > X,
							TraderArrivee is TraderA mod X,
							nth1(TraderArrivee, Plateau, ListeArrivee),
							listeArriveeValide(ListeArrivee),!.

coup_possible(Plateau,TraderDepart,Deplacement,TraderArrivee,ListeDepart,ListeArrivee):-write('le coup que vous voulez effectuer n est pas possible, essayez un autre deplacement').

%COMMENTAIRE:

%Ici on distingue deux cas : le cas ou la valeur du trader est inferieure ou egale la longueur de ma liste de marchandises (autrement dit le nombre de sous listes de ma liste de marchandises, donc le nombre de mes colonnes) auquel cas on ne fait rien de special, sa position correspondra au numero de colonne correspondant. En revanche si la valeur du trader est superieure a mon nombre de colonnes on fait un modulo (modulo X avec X le nombre de colonnes) pour revenir sur les colonnes du debut (on simule le fait que les colonnes soient en cercle).


%----------------------------------------------------------

listeArriveeValide(L):-L\=[]. %Une liste d arrivee est valide si elle n est pas vide (la pile a encore des jetons)

%Plateau->on rentre les colonnes du plateau (a la main), donc les piles
%traderDEpart est la position actuelle (avant que le coup soit joué), du trader
%deplacement : la valeur du deplacement(1,2,3)
%traderArrivee: la position du trader apres que le coup ne soit joué
%ListeDepart : la pile sur laquelle est le trader avant que le coup soit joué
%ListeArrivee : la pile sur laquelle se trouve le trader apres le coup (le deplacement)

%-----------------------------------------------------------



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%MARCHE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%un plateau peut être définit par la liste [Marchandises, Bourse, PositionTrader, ReserveJoueur1, ReserveJoueur2]. PositionTrader est un entier entre 1 et le nombre de piles de Marchandises.

%jouerCoup du joueur1

jouer_coup(1, PilesDeMarchandisesInitiales, BourseInitiale, TraderDepart, ReserveInitialeJoueur1, Deplacement, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1,X, ReSERVEAUTREJOUEUR):-
	coup_possible(PilesDeMarchandisesInitiales,TraderDepart,Deplacement,PositionTraderArrivee,ListeDepart,ListeArrivee),
	pieceGardeeEtJetee([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, PositionTraderArrivee, PilesDeMarchandisesInitiales),
	modifierPlateau(PilesDeMarchandisesInitiales, PilesMarchandisesApresCoup,PositionTraderArrivee),
	modifieBourse(BourseInitiale, PieceJetee, NouvelleBourse),nl,
	modifieReserveJoueur(1,ReserveInitialeJoueur1, PieceGardee, NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR),nl,
	write('--------------------------NOUVELLES TETES DE PILES----------------------'),nl,
	affichageTeteEtTrader(PilesMarchandisesApresCoup,PositionTraderArrivee,X).


%X est le num de depart de la numerotation ds listes (equivaut au NumDepartListe il vaut toujours 1), comme dans les edicats precedent.


%jouerCoup du joueur2 

jouer_coup(2, PilesDeMarchandisesInitiales, BourseInitiale, TraderDepart, ReserveInitialeJoueur2, Deplacement, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur2,X, ReSERVEAUTREJOUEUR):-
	coup_possible(PilesDeMarchandisesInitiales,TraderDepart,Deplacement,PositionTraderArrivee,ListeDepart,ListeArrivee),
	pieceGardeeEtJetee([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, PositionTraderArrivee, PilesDeMarchandisesInitiales),
	modifierPlateau(PilesDeMarchandisesInitiales, PilesMarchandisesApresCoup,PositionTraderArrivee),
	modifieBourse(BourseInitiale, PieceJetee, NouvelleBourse),nl,
	modifieReserveJoueur(2,ReserveInitialeJoueur2, PieceGardee, NouvelleReserveJoueur2, ReSERVEAUTREJOUEUR),nl,
	write('--------------------------NOUVELLES TETES DE PILES----------------------'),nl,
	affichageTeteEtTrader(PilesMarchandisesApresCoup,PositionTraderArrivee,X).
	
	
%ENTREE: jouer_coup(j1,[[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]], [[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]], 1, [], 3, TraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueurDeCeTour,1,[]).


%COMMENTAIRE:
%on peut jouer un coup si ce coup est possible et en faisant appel au predicat qui nous donne les pieces gardees et jetees.


%--------------------------------------------------------------------------------------------------

%Cas standard ou j ai bien une liste precedente et une liste suivante (directement a cote)
	
modifierPlateau(PilesDeMarchandisesInitiales, PilesMarchandisesApresCoup,PositionTraderArrivee):-
		PositionTraderPrecedent is PositionTraderArrivee-1,
		retireTete(PilesDeMarchandisesInitiales, PositionTraderPrecedent, NewPiles1), 
		PositionTraderSuivant is PositionTraderArrivee+1,
		retireTete(NewPiles1, PositionTraderSuivant, NewPiles2),
		supprimerDeLaListe(NewPiles2,[], PilesMarchandisesApresCoup).

%------------------------------------------------------------------------------------------------------

%Cas ou je n ai pas directement de liste precedente, donc ou je suis place sur la premiere pile de jetons. C est le cas ou la liste precedente est en realite la derniere liste (car on est dans un cercle). On fait comme dans le predicat pieceGardeeEtJetee, on creer une sorte de variable tampon sur laquelle on fait des tests. Si mon TraderP est egal a 0 je suis donc sur la premiere colonne et j affecte donc a ma (vraie) variable PositionTraderPrecedent la valeur de la derniere colonne via la fonction lenght.

modifierPlateau(PilesDeMarchandisesInitiales, PilesMarchandisesApresCoup,PositionTraderArrivee):-
		TraderP is PositionTraderArrivee-1,
		TraderP = 0,
		length(PilesDeMarchandisesInitiales,L),
		PositionTraderPrecedent is L,
		retireTete(PilesDeMarchandisesInitiales, PositionTraderPrecedent, NewPiles1), 
		PositionTraderSuivant is PositionTraderArrivee+1,
		retireTete(NewPiles1, PositionTraderSuivant, NewPiles2),
		supprimerDeLaListe(NewPiles2,[], PilesMarchandisesApresCoup).

%------------------------------------------------------------------------------------------------------

%Cas ou je suis place sur la derniere pile donc on je n ai pas de pile suivante. Il faut donc que j aille operer sur la premiere colonne. Je procede la aussi a l aide d une variable tampon.


modifierPlateau(PilesDeMarchandisesInitiales, PilesMarchandisesApresCoup,PositionTraderArrivee):-
		PositionTraderPrecedent is PositionTraderArrivee-1,
		retireTete(PilesDeMarchandisesInitiales, PositionTraderPrecedent, NewPiles1), 
		TraderS is PositionTraderArrivee+1,
		length(PilesDeMarchandisesInitiales,L),
		TraderS > L,
		PositionTraderSuivant = 1,
		retireTete(NewPiles1, PositionTraderSuivant, NewPiles2),
		supprimerDeLaListe(NewPiles2,[], PilesMarchandisesApresCoup).

%On retire les tetes des piles auxquelles on a jetes les jetons (jeton garde et jeton jete) et a la fin on supprime les listes qui pourraient etre vides  


%---------------------------------------------------------------------------------------------------------

supprimerDeLaListe([X|Q],X,NQ):-supprimerDeLaListe(Q,X,NQ).
supprimerDeLaListe([X|Q],Z,[X|Q1]):-Z\=X, supprimerDeLaListe(Q,Z,Q1).
supprimerDeLaListe([],X,[]).


%COMMENTAIRE: 


%Ce predicat, utilise dans le predicat modifierPlateau, modifie le plateau tout au long du jeu. Si une piles est vide alors elle est supprimée. Des que l on retire un jeton e tete de pile alors ce predicat modifie la pile

%-----------------------------------------------------------------------------------------------------------------


retireTete([T|Q], 1, [NT|Q]):- 
				retirerTete(T,NT), !. 		
retireTete([T|Q], X, Resultat):- 
				Y is X-1, retireTete(Q, Y, Res), concat([T], Res, Resultat). 


%COMMENTAIRE:

%Pour retirer des tetes de piles les jetons gardes et jetes. Ainsi, lors de la regeneration automatique des tetes de piles d autres jetons seront mis en tete et pourront etre choisit ou jetes a leur tour.


retirerTete([T|Q],Q).

%Le predicat retireTete me permet de parcourir ma liste de marchandises avant le coup et de retirer les tetes des piles precedents et suivants la position de mon trader (on retire les jetons gardes et jetes), pour avoir la liste de marchandises apres le coup


%------------------------------------------------------------------------------------------------------------------


%********************************************************************************************************

%COMMENTAIRE:

%Cas standard ou on est pas sur la premiere ni la derniere colonne. Donc on a une colonne precedente et une colonne suivante.


pieceGardeeEtJetee([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, TraderArrivee,PilesDeMarchandisesInitiales):-
						TraderPreced is TraderArrivee-1,
						TraderPreced >=1,
						nth1(TraderPreced, PilesDeMarchandisesInitiales, [Piece1|PilePreced]),
						TraderSuiv is TraderArrivee+1,
						length(PilesDeMarchandisesInitiales, L),
						TraderSuiv < L, 
						nth1(TraderSuiv, PilesDeMarchandisesInitiales, [Piece2|PileSuiv]),
						ListeChoix = [Piece1,Piece2],nl,
						write('----------------CHOIX-------------------'),nl,
						write('quelle piece voulez vous garder ?'), write(Piece1), write('(1)'), write(' ou '), write(Piece2), write('(2)'),nl,
						read(X),
						nth1(X, ListeChoix, PieceGardee),
						supUNE(PieceGardee,ListeChoix,NewListeChoix),
						nth1(1, NewListeChoix, PieceJetee).

pieceGardeeEtJetee([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, TraderArrivee,PilesDeMarchandisesInitiales):-
						TraderPreced1 is TraderArrivee-1,
						TraderPreced1 = 0,
						length(PilesDeMarchandisesInitiales,L),
						TraderPreced is L,
						nth1(TraderPreced, PilesDeMarchandisesInitiales, [Piece1|PilePreced]),
						TraderSuiv is TraderArrivee+1,
						nth1(TraderSuiv, PilesDeMarchandisesInitiales, [Piece2|PileSuiv]),
						ListeChoix = [Piece1,Piece2],nl,
						write('----------------CHOIX-------------------'),nl,
						write('quelle piece voulez vous garder ?'), write(Piece1), write('(1)'), write(' ou '), write(Piece2), write('(2)'),nl,
						read(X),
						nth1(X, ListeChoix, PieceGardee),
						supUNE(PieceGardee,ListeChoix,NewListeChoix),
						nth1(1, NewListeChoix, PieceJetee).

pieceGardeeEtJetee([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, TraderArrivee,PilesDeMarchandisesInitiales):-
						length(PilesDeMarchandisesInitiales,L),
						TraderArrivee = L,
						TraderPreced is TraderArrivee-1,
						nth1(TraderPreced, PilesDeMarchandisesInitiales, [Piece1|PilePreced]),
						TraderSuiv1 is TraderArrivee+1,
						length(PilesDeMarchandisesInitiales,L),
						TraderSuiv1 > L,
						TraderSuiv = 1,
						nth1(TraderSuiv, PilesDeMarchandisesInitiales, [Piece2|PileSuiv]),
						ListeChoix = [Piece1,Piece2],nl,
						write('----------------CHOIX-------------------'),nl,
						write('quelle piece voulez vous garder ?'), write(Piece1), write('(1)'), write(' ou '), write(Piece2), write('(2)'),nl,
						read(X),
						nth1(X, ListeChoix, PieceGardee),
						supUNE(PieceGardee,ListeChoix,NewListeChoix),
						nth1(1, NewListeChoix, PieceJetee).



%COMMENTAIRE: 

%Ces predicats nous permettent de choisir la piece que l on garde et celle que l on jete. Ainsi on creer deux variable TraderPreced et TraderSuiv qui vont pointes respectivement sur les piles situees avant et apres celle sur laquelle on se trouve pour ensuite en recuperer la tete. Ces deux tetes vont etre placees dans une liste de choix, et, en fonction de la reponse de l utilisateur,a la question "Quelle piece garder ?", unifiera une piece avec la varibale PieceGardee, on supprimera cette piece de notre liste de choix et enfin, on prendra la derniere piece restante que l on unifiera avec la varibale PieceJetee.

%------------------------------------------------------------

supUNE(X,[],[]).
supUNE(X,[X|Q],Q).
supUNE(X,[T|Q],Res):-T\=X, supUNE(X,Q,NQ), concat([T],NQ,Res).

%COMMENTAIRE:

%Nous avons fait ce predicat qui ne supprimer qu une seule fois X dans une liste, dans le cas ou il yapparaitrait plusieurs fois puisqu il fallait traiter le cas, dans le predicat ci dessus (pieceGardeeEtJetee) ou on se situait sur une tete de pile entouree a gauche et a droite par le meme jeton (donc si la piece jetee est egale a la piece gardee) , auquel cas, etant donne notre predicat ci dessus, on aurait tout supprimer de la ListeChoix. Ainsi de ce fait nous traitons toutes les eventualites.

%------------------------------------------------------------

%COMMENTAIRE:

%Cas ou on est sur la premiere colonne donc on a pas de colonne precedente a premiere vue. On creer ici une variable dite (tampon) nommée TraderPreced1 pour faire le test sur cette derniere et voir si elle est egale a 0, auquel cas on initialise la VRAIE variable qui nous interesse, a savoir TraderPreced avec la longueur de la liste pour recuperer le jeton de la derniere pile.






%------------------------------------------
%COMMENTAIRE:


%Cas ou on est sur le derniere colonne donc on a pas de colonne suivante a premiere vue. Ici aussi on utilise une variable tampon nommée TraderSuiv1 pour faire le test dessus et affecter a la variable qui nous interesse (ici, TraderSuiv) la valeur 1, pour que l on puisse recuperer la tete de liste de la premiere liste (puisque nos piles de jetons sont en cercle donc des qu on est sur la derniere colonne on doit pouvoir recuperer le jeton de la colonne suivante, a savoir la premiere dans le cas d une disposition en cercle.





%TraderArrivee : position du trader apres le deplacement 
%PilesMarchandiesInitiales: nos piles de jetons a l etat initial
%Piece1: tete de la pile precedente (a celle ou se trouve le trader)
%Piece2: tete de la pile suivante (a celle ou se trouve le trader)
%ListeChoix : represente les deux jetons parmis lesquel le joueur doit faire un choix (il doit en garder un et jeter l autre.
%Le nth1 qui suit le read permet de selectionner la piece gardee par le joueur (qui ira dans sa reserve), puis de la supprimer de la %liste de choix (le choix est effectué) pour selectionner la piece qui est jetee. C est la raison pour laquelle on repere les pieces %par des numeros (1 ou 2) pour ensuite les extraires de ListeChoix grace a leur position dans cette derniere

%-----------------------------------------------------------------------------------------------------

modifieBourse(BourseInitiale, PieceJetee, NouvelleBourse):-
		write('----------------------NOUVELLE BOURSE--------------------'),nl,
		element([PieceJetee,X],BourseInitiale), Y is X-1, substitue([PieceJetee,X], [PieceJetee,Y], BourseInitiale, NouvelleBourse),
		write(NouvelleBourse),nl.


substitue(_,_,[],[]).
substitue(X,Y,[X|Q],[Y|NQ]):-substitue(X,Y,Q,NQ).
substitue(X,Y,[T|Q],[T|Res]):- T\=X, substitue(X,Y,Q,Res).



element(X,[X|Q]).
element(X,[T|Q]):-element(X,Q).


%COMMENTAIRE:

%On verifie que l element que l on veut substituer est bien dans notre Bourse. Si oui alors on substitue cet element avec une liste de meme tete mais une queue decrementee (car la queue correspond a la valeur de ma marchandise). On modifie donc la bourse ici en fonction des hetons qui vont etre jetes. 



%-----------------------------------------------------------------------------------------------------------------------------


modifieReserveJoueur(1, ReserveInitialeJoueur1, PieceGardee, NouvelleReserveJoueur1, ReserveInitialeJoueur2):-
							write('-----------------NOUVELLE RESERVE JOUEUR 1----------------'),nl,
							concat(ReserveInitialeJoueur1, [PieceGardee], NouvelleReserveJoueur1),
							write(NouvelleReserveJoueur1),nl,
							write('-----------------RESERVE DE L AUTRE----------------'),nl,
							write(ReserveInitialeJoueur2).

modifieReserveJoueur(2, ReserveInitialeJoueur2, PieceGardee, NouvelleReserveJoueur2, ReserveInitialeJoueur1):-
							write('-----------------NOUVELLE RESERVE JOUEUR 2----------------'),nl,
							concat(ReserveInitialeJoueur2, [PieceGardee], NouvelleReserveJoueur2),
							write(NouvelleReserveJoueur2),nl,
							write('-----------------RESERVE DE L AUTRE----------------'),nl,
							write(ReserveInitialeJoueur1).

%COMMENTAIRE:

%On modifie la reserve du joueur 1 OU du joueur 2, on choisit d utiliser le predicat concat(ReserveInitialeJoueur, [PieceGardee], NouvelleReserveJoueur) car on ajoute a la ReserveInitiale la PieceGardee, donc si ma ReserveIntiale est la liste vide ([]) cela fonctionnera quand meme et ma PieceGardee sera ajoutee a la Reserve. Le resultat sera stocke dans la variable NouvelleReserveJoueur.


%--------------------------------------------------------------------------------------------------------------------------------


%RAPPEL:

%Le Res dans le predicat generePlateau est en realite le resultat de la generation aleatoire, donc, la liste aleatoirement generee, c est a dire nos piles (une liste de listes, chaque sous listes etant une pile de jetons)

%***************************************************************  LA BOUCLE HUMAIN/HUMAIN  **********************************************************

boucleDeJeu(Tour,TraderDebut,Res,NumPileDepart,JoueurX,BourseInitiale, ReserveInitialeJoueurDeCeTour, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR):- length(Res,Taille), Taille =< 2,nl,nl, write('FIN DE LA PARTIE'), calculGagnantPerdant(NouvelleBourse, NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR),nl,nl.

boucleDeJeu(Tour,TraderDebut,Res,NumPileDepart,JoueurX,BourseInitiale, ReserveInitialeJoueurDeCeTour, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR):-
		write('-----------------------------TOUR '),write(Tour),write('------------------------------------'),nl,
		write('-----------------------------PILES--------------------------'),nl,
		affichageTeteEtTrader(Res,TraderDebut,NumPileDepart),
		write('VALEUR DU DEPLACEMENT ? 1,2 ou 3'),nl,
		read(Deplacement),
		%deplacement(Deplacement),
		jouer_coup(JoueurX, Res, BourseInitiale, TraderDebut, ReserveInitialeJoueurDeCeTour, Deplacement, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1,NumPileDepart,ReSERVEAUTREJOUEUR),nl,
		write('---------------------------RESERVE DE L AUTRE JOUEUR------------------------'),nl,
		write(ReSERVEAUTREJOUEUR),nl,nl,
		write('CONTINUE ? OUI (1) NON (2)'),nl,
		read(Reponse),
		continuer(Reponse, NouvelleBourse, NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR),
		JoueurY is (JoueurX mod 2 + 1),
		write('----------------------------PLACE AU JOUEUR  '),write(JoueurY),write('  ------------------------------'),nl,
		TourSuiv is Tour+1, 
		boucleDeJeu(TourSuiv,PositionTraderArrivee,PilesMarchandisesApresCoup,NumPileDepart,JoueurY, NouvelleBourse,  ReSERVEAUTREJOUEUR, PositionTraderArriveeBis, ListeDepartBis, ListeArriveeBis,PieceGardeeBis, PieceJeteeBis,[Piece1Bis|PilePrecedBis],[Piece2Bis|PileSuivBis], PilesMarchandisesApresCoupBis,NouvelleBourseBis,NouvelleReserveDuJoueurDuTourSuivant,NouvelleReserveJoueur1).


%COMMENTAIRE:
%Si l utilisateur veut continuer il doit taper 1. on gere ici le fait que lon peut arreter le jeu quand on le desire.
%On combine ici tous les predicats precendents de facon a generer nos piles, a les afficher a chaque tour en suivant leur evolution.
%Notons que nous devons toujours garder une "trace" de la reserve du joueur qui ne joue pas ce tour ci (ReSERVEAUTREJOUEUR) puisqu elle doit pouvoir etre reutilisable dans l appel recursif quand ca sera effectivement a ce joueur de jouer. C est ce qui nous permet de garder la reserve en mememoire pour pouvoir la concatener avec la piece gardee au tour suivant et avoir une reserve qui evolue au cours de la partie.
%De plus, nous nous servons du modulo, comme cela est visible dans le code pour faire une sorte de boucle dans la numerotation des joueurs de telle facon a ce qu on incremente juste le joueur detour en tour mais que le numero de ce dernier reste toujours entre 1 et 2.

%Pour gerer les joueurs on fait une variable X que l on incremente de 1 a laquelle on applique le modulo 2 et on ajoute 1. On aura donc une boucle de la forme 2mod2+1 =1, 3mod2+1 =2, 4mod2+1 =1, 5mod2+1 =2 etc.. ainsi on a ici un moyen de faire une boucle qui nous permettra de dire (au tour 1 c est le joueur 1, au tour 2 c est le joueur 2, au tour 3 c est le joueur 1 etc..)
%Donc je dois entrer 1 ou 2 au premier tour dans ma variable Joueur (donc je dois unifier ma varibale joueur avec 1 ou 2 au debut) et ensuite mon mecanisme avec les mod 2 gerera les joueurs tout au long de ma boucle. Donc au premier tour je rentrerai 1 pour indiquer que je commence en tant que joueur 1, du coup la valeur de JoueurY sera de 1mod2+1 soit 2 au prochain tour.



%Une ENTREE: boucleDeJeu(1,1,[[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]],1,1,[[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]], [], PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueurDeCeTour,[]).



%------------------------------------------------------------------------------------


continuer(1, NouvelleBourse, NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR).
continuer(2, NouvelleBourse, NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR):- write('*************************FIN DE LA PARTIE MERCI D AVOIR JOUE ! A BIENTOT**************************'),nl, calculGagnantPerdantFIN(NouvelleBourse, NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR), fail.
continuer(X, NouvelleBourse, NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR):- X\=1, X\=2, write('Merci de bien vouloir entrer une valeur convenable, reesayez :  '), write('CONTINUE ? OUI (1) NON (2)'),nl, read(Reponse2), continuer(Reponse2).


%COMMENTAIRE:

%Ce predicat gere si l utilisateur veut arreter ou continuer la partie a chaque nouveau tour. Si la reponse est 1 alors pas de soucis, notre fait continuer(1) va etre efface sans soucis. Autrement, si la reponse est 2 alors cela signifie que l utilisateur veut stopper la partie auqeul cas on le remercie et on fait un fail pour arreter et si la repons est autre chose que 1 ou 2 alors on boucle pour demander au joueur d entrer une valeur convenable. Ce predicat a part de la boucle, nous permet donc d avoir un programme solide aux erreurs de saisies courantes. 


%-----------------------------------------------------------------------------------


%EN COURS


%deplacement(1).
%deplacement(2).
%deplacement(3).
%deplacement(X):- X\=1, X\=2, X\=3, write('Merci de bien vouloir entrer une valeur convenable pour le deplacement, reesayez :  '),write('VALEUR DU DEPLACEMENT ? 1,2 ou 3'),nl, read(Deplacement22), deplacement(Deplacement2).



%COMMENTAIRE:
%Ici de la meme maniere que dans le predicat continuer on fait un predicat deplacement qui permet de faire face aux erreurs de saisie courante de l utilisateur. Donc en faisant ces predicats, on fait en sorte que si ce dernier n entre pas une valur convenable de deplacement, le programme ne sarrete pas 


%-----------------------------------------------------------------------------------------

occurences(_,[],0).
occurences(X,[X|Q],Nbre):- occurences(X,Q,NbreBIS), Nbre is NbreBIS+1.
occurences(X,[T|Q],Nbre):- T\=X, occurences(X,Q,Nbre).

gagnant(SommeJ1, SommeJ2):- SommeJ1 > SommeJ2, write('------------------ LE GAGNANT EST LE JOUEUR 1 AVEC  '), write(SommeJ1), write('  POINTS CONTRE   '), write(SommeJ2), write('  -----------------'),!.
gagnant(SommeJ1, SommeJ2):- SommeJ2 > SommeJ1, write('------------------ LE GAGNANT EST LE JOUEUR 2 AVEC  '), write(SommeJ2),write(' POINTS CONTRE '), write(SommeJ1),write('  -----------------'),!.
gagnant(SommeJ1, SommeJ2):- SommeJ1 = SommeJ2, write('------------------ EGALITE PARFAITE AVEC  '), write(SommeJ1), write('  POINTS-----------------').


calculGagnantPerdant(NouvelleBourse, NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR):-
					occurences(ble, NouvelleReserveJoueur1, N1ble),
					occurences(cafe, NouvelleReserveJoueur1, N1cafe),
					occurences(cacao, NouvelleReserveJoueur1, N1cacao),
					occurences(riz, NouvelleReserveJoueur1, N1riz),
					occurences(mais, NouvelleReserveJoueur1, N1mais),
					occurences(sucre, NouvelleReserveJoueur1, N1sucre),
					occurences(ble, ReSERVEAUTREJOUEUR, N2ble),
					occurences(cafe, ReSERVEAUTREJOUEUR, N2cafe),
					occurences(cacao, ReSERVEAUTREJOUEUR, N2cacao),
					occurences(riz, ReSERVEAUTREJOUEUR, N2riz),
					occurences(mais, ReSERVEAUTREJOUEUR, N2mais),
					occurences(sucre, ReSERVEAUTREJOUEUR, N2sucre),
					element([ble,Vble], NouvelleBourse),
					element([riz,Vriz], NouvelleBourse),
					element([cafe,Vcafe], NouvelleBourse),
					element([cacao,Vcacao], NouvelleBourse),
					element([sucre,Vsucre], NouvelleBourse),
					element([mais,Vmais], NouvelleBourse),
					SommeJ1 is ((N1ble * Vble)+(N1riz * Vriz)+(N1cafe * Vcafe)+(N1cacao * Vcacao)+(N1sucre * Vsucre)+(N1mais * Vmais)),
					SommeJ2 is ((N2ble * Vble)+(N2riz * Vriz)+(N2cafe * Vcafe)+(N2cacao * Vcacao)+(N2sucre * Vsucre)+(N2mais * Vmais)),
					gagnant(SommeJ1, SommeJ2).
					

%COMMENTAIRE : 

%Predicats qui permettent de connaitre le gagnant, en sommant les valeurs des marchandises a la fin et de pouvoir savoir qui gagne

%ENTREE


%-----------------------------------------------------------------------------------------

gagnantFIN(SommeJ1, SommeJ2):- SommeJ1 > SommeJ2, write('------------------ LE GAGNANT ETAIT LE JOUEUR 1 AVEC  '), write(SommeJ1), write('  POINTS CONTRE   '), write(SommeJ2), write(' DOMMAGE POUR LUI... -----------------'),!.
gagnantFIN(SommeJ1, SommeJ2):- SommeJ2 > SommeJ1, write('------------------ LE GAGNANT ETAIT LE JOUEUR 2 AVEC  '), write(SommeJ2),write(' POINTS CONTRE '), write(SommeJ1),write('  DOMMAGE POUR LUI... -----------------'),!.
gagnantFIN(SommeJ1, SommeJ2):- SommeJ1 = SommeJ2, write('------------------ EGALITE PARFAITE AVEC  '), write(SommeJ1), write('  POINTS-----------------').


calculGagnantPerdantFIN(NouvelleBourse, NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR):-
					occurences(ble, NouvelleReserveJoueur1, N1ble),
					occurences(cafe, NouvelleReserveJoueur1, N1cafe),
					occurences(cacao, NouvelleReserveJoueur1, N1cacao),
					occurences(riz, NouvelleReserveJoueur1, N1riz),
					occurences(mais, NouvelleReserveJoueur1, N1mais),
					occurences(sucre, NouvelleReserveJoueur1, N1sucre),
					occurences(ble, ReSERVEAUTREJOUEUR, N2ble),
					occurences(cafe, ReSERVEAUTREJOUEUR, N2cafe),
					occurences(cacao, ReSERVEAUTREJOUEUR, N2cacao),
					occurences(riz, ReSERVEAUTREJOUEUR, N2riz),
					occurences(mais, ReSERVEAUTREJOUEUR, N2mais),
					occurences(sucre, ReSERVEAUTREJOUEUR, N2sucre),
					element([ble,Vble], NouvelleBourse),
					element([riz,Vriz], NouvelleBourse),
					element([cafe,Vcafe], NouvelleBourse),
					element([cacao,Vcacao], NouvelleBourse),
					element([sucre,Vsucre], NouvelleBourse),
					element([mais,Vmais], NouvelleBourse),
					SommeJ1 is ((N1ble * Vble)+(N1riz * Vriz)+(N1cafe * Vcafe)+(N1cacao * Vcacao)+(N1sucre * Vsucre)+(N1mais * Vmais)),
					SommeJ2 is ((N2ble * Vble)+(N2riz * Vriz)+(N2cafe * Vcafe)+(N2cacao * Vcacao)+(N2sucre * Vsucre)+(N2mais * Vmais)),
					gagnantFIN(SommeJ1, SommeJ2).
					


%-----------------------------------------------------------------------------------------


partie(NbreJ,ListCompteur,ListeM,Res,TraderDebut,NumPileDepart,Tour,JoueurX,BourseInitiale, ReserveInitialeJoueurDeCeTour, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR ):-
				nl,nl,write('                      =======  DEBUT DE LA PARTIE  ======='),nl,
				generePlateau(NbreJ,ListCompteur,ListeM,Res,TraderDebut,NumPileDepart),
				boucleDeJeu(Tour,TraderDebut,Res,NumPileDepart,JoueurX,BourseInitiale, ReserveInitialeJoueurDeCeTour, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR).


%COMMENTAIRE:
%Predicat qui fait tourner la boucle, on genere le trader aleatoirement juste avant de rentrer dans notre boucle. Notre boucle de jeu recupere ce trader genere et tourne avec la valuer de ce dernier.

%Entree partie(36, [6,6,6,6,6,6], [ble,mais,riz,sucre,cafe,cacao], Res, TraderDebut, 1, 1, 1, [[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]], [], PositionTraderArrivee, ListeDepart, ListeArrivee, PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, []).



%=====================================================================================================================================================
%===============================================================  INTELLIGENCE ARTIFICIELLE    =======================================================
%=====================================================================================================================================================

%RAPPEL:

%Ici comme dans la plupart des predicats, Res represente les piles generes aleatoirement. C est le resultat de generePiles. 




pieceGardeeEtJeteeIA([Piece1|PilePreced],[Piece2|PileSuiv],TraderArrivee,PilesDeMarchandisesInitiales,PieceGardee,PieceJetee,PieceGardee2,PieceJetee2,Deplace,BourseAInstantT,MeilleurCoup):-
						TraderPreced is TraderArrivee-1,
						TraderPreced >=1,
						nth1(TraderPreced, PilesDeMarchandisesInitiales, [Piece1|PilePreced]),
						TraderSuiv is TraderArrivee+1,
						length(PilesDeMarchandisesInitiales, L),
						TraderSuiv =< L, 
						nth1(TraderSuiv, PilesDeMarchandisesInitiales, [Piece2|PileSuiv]),
						ListeChoix = [Piece1,Piece2],nl,
						write('Voici les pieces parmis lesquelles vous avez le choix pour un deplacement de '),write(Deplace),write(' :  '),nl,nl,
						write('____________________'),nl,
						write(' |'),write(Piece1), write(' et '), write(Piece2), write(' |'),nl,
						write('____________________'),nl,nl,
						write('i. Possibilite 1  : '),nl,
						write('------------------'),nl,			
						nth1(1, ListeChoix, PieceGardee),
						supUNE(PieceGardee,ListeChoix,NewListeChoix),
						nth1(1, NewListeChoix, PieceJetee),
						element([PieceGardee,Valeur],BourseAInstantT),
%ici le predicat element([PieceGardee,Valeur],Bourse), permet de recuperer, dans la liste BourseAInstantT, l element (la liste) contenant la piece que l on garde (connu a ce stade) afin d en connaitre la valeur marchande (inconnue a ce stade, mais connue grace au predicat). La valeur marchande est la queue de la liste dont la tete est la PieceGardee (2 elements dans la liste).
						write('Vous pouvez jeter:  '), write(PieceJetee),nl,
						write('Vous pouvez garder:  '), write(PieceGardee),write(' de valeur sur le marché : '), write(Valeur),nl,nl,
						write('OU BIEN'),nl,nl,
						write('ii. Possibilite 2  : '),nl,
						write('------------------'),nl,	
						nth1(2, ListeChoix, PieceGardee2),
						supUNE(PieceGardee2,ListeChoix,NewListeChoix2),
						nth1(1, NewListeChoix2, PieceJetee2),
						element([PieceGardee2,Valeur2],BourseAInstantT),
						write('Vous pouvez jeter:  '), write(PieceJetee2),nl,
						write('Vous pouvez garder:  '), write(PieceGardee2),write(' de valeur sur le marché : '), write(Valeur2),nl,nl,
						write('-------------LE MEILLEUR COUP DE CE DEPLACEMENT-------------'),nl,nl,
						maximum([Deplace,PieceGardee,Valeur], [Deplace,PieceGardee2,Valeur2], MeilleurCoup),
						write(MeilleurCoup),nl,nl.


%--------------------------------------------------------------------------------

maximum([Deplacement1,PieceGardee1|[Element1]], [Deplacement2,PieceGardee2|[Element2]], Maximum):- Element1 =< Element2, Maximum = [Deplacement2,PieceGardee2,Element2],!.

maximum([Deplacement,PieceGardee1|[Element1]], [Deplacement,PieceGardee2|[Element2]], [Deplacement1,PieceGardee1,Element1]).

%Entree: maximum([ble,3],[riz,4],Z).



%---------------------------------------------------------------------------------

maxDeListeDesMax(Liste,MeilleurDesMeilleurs):-length(Liste,1). 
maxDeListeDesMax(Liste,MeilleurDesMeilleurs):- length(Liste,X), X\=1, nth1(1,Liste,E1), nth1(2,Liste,E2), maximum(E1,E2, MaxTemp), nth1(3,Liste,E3), maximum(MaxTemp, E3, MeilleurDesMeilleurs). 

%---------------------------------------------------------------------------------


premiersEle([T1,T2,T3|Q],[T1,T2,T3]). 

%La liste [MeilleurCoup|Reste] generee est imparfaite dans le sens ou on a des variables _ generees a la fin, donc pour se debarasser de se probleme, nous avons fait ce predicat qui ne garde que les elements qui nous interessent. Il est peu flexible mais juste adapte a nos besoins dans ce cas la.


%---------------------------------------------------------------------------------

coup_possibleIA(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[],PieceGardee,PieceJetee,PieceGardee2,PieceJetee2,[Reste]):- nl,nl, write('Tous les cas ont été traités !'),nl,nl.


coup_possibleIA(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement],PieceGardee,PieceJetee,PieceGardee2,PieceJetee2,[MeilleurCoup|Reste]):-
	Deplace is TeteListeDeplacement,
	TraderArrivee is TraderDepart + Deplace,
	pieceGardeeEtJeteeIA([Piece1|PilePreced],[Piece2|PileSuiv],TraderArrivee,PilesDeMarchandisesInitiales,PieceGardee,PieceJetee,PieceGardee2,PieceJetee2, Deplace,BourseAInstantT,MeilleurCoup),
	coup_possibleIA(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, NouveauTraderArrivee, ListeDepart, NouvelleListeArrivee,[Piece1BIS|PilePrecedBIS],[Piece2BIS|PileSuivBIS],X,QueueListeDeplacement,PieceGardeeBIS,PieceJeteeBIS,PieceGardee2BIS,PieceJetee2BIS,Reste).


%COMMENTAIRE:

%PilesDeMarchandisesInitiales represente les piles de marchandises que lon a au moment ou l on veut connaitre les coups possibles 
%BourseAInstantT la bourse que l on a au moment ou on veut connaitre les coups possibles
%TraderDepart la Position du trader a partir de laquelle on veut connaitre les coups possibles
%TraderArrivee les differentes position du trader apres les differents deplacements possibles
%ListeDepart liste sur laquelle est le trader au depart (avant tout deplacement)
%ListeArrivee liste sur laquelle est le trader apres le deplacement
%Piece1 tete de la liste precedent la liste d arrivee
%Piec2 tete de la liste suivant la liste d arrivee
%X Toujours egal a 1 c est le numero de la premiere colonne 
%[TeteListeDeplacement|QueueListeDeplacement] on entre [1,2,3], c est la liste des deplacements possibles
%On a piece gardee et piecegardee2 car dans les deux pieces des tetes de listes precedentes et suivantes on peu en garder une et jeter l autre ou inversement.
%[MeilleurCoup|Reste] est la pile qui, a partir du predicat pieceGardeeEtJEtee affiche la liste des 3 meilleurs coups (car on a 2 possibilites a chaque coup, donc on garde la meilleure).


%Entree : coup_possibleIA([[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]], [[ble,7],[riz,6],[cacao,6],[cafe,6],[sucre,6],[mais,6]], 2, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],1,[1,2,3],PieceGardee,PieceJetee,PieceGardee2,PieceJetee2,Liste).

%------------------------------------------------------------------------------


meilleur_coup(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement],PieceGardee,PieceJetee,PieceGardee2,PieceJetee2,[MeilleurCoup|Reste],MeilleurDesMeilleurs):-
	coup_possibleIA(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement],PieceGardee,PieceJetee,PieceGardee2,PieceJetee2,[MeilleurCoup|Reste]), 
	premiersEle([MeilleurCoup|Reste],ListeDesMax),
	maxDeListeDesMax(ListeDesMax, MeilleurDesMeilleurs), 
	write('_______________________LE MEILLEUR COUP A JOUER EST:___________________________'),nl,nl,
	write('=>'),write(MeilleurDesMeilleurs).

%Ici et dans les predicats ci dessus nous avons genere les differents deplacements possibles dans le predicat coup_possibleIA. Dans le predicat pieceGardeeEtJetee nous voyons, selon la valuer du deplacement, quelle piece nous pouvons garder et quelle piece nous pouvons jeter (on ne peu garder qu une seule piece conformement aux regles qui nous ont etees fournies dans le sujet). Au sein meme du predicat pieceGardeeEtJeteeIA nous faisons un premier chois des meilleurs coup a jouer, puisque pour un meme deplacement on peut garder une piece ou l autre. Ainsi, on affiche la meilleure piece a garder pour un meme deplacement (on la trouve grace au predicat maximum qui ne compare QUE le dernier element de la liste, a savoir le gain que nous rapporte cette piece (strategie tournee vers le gain)). Une fois que l on a la meilleure piece a garder par coup jouable, on les rassemble dans une liste de longueur 3 sur laquelle on fait tourner le predicat maxDeListeDesMax qui va trouver, parmis ces 3 maximums (locaux), le maximum global, autrement dit le meilleur coup a jouer tout deplacements confondus. C est la raison pour laquelle on a fait le predicat meilleur_coup qui fait tourner le predicat coup_possibleIA, qui en recupere la liste des 3 maximums, surlaquelle va tourner le predicat maxDeListeDesMax qui renvoie dans MeilleurDesMeilleurs le meilleur coup a jouer pour ce tour. Une fois cela il nous suffit d afficher MeilleurDesMeilleurs. 


%=======================================================================================================================================
%================================================================ BOUCLE IA/HOMME =================================================================
%=======================================================================================================================================

boucleDeJeuHommeIA(Tour,TraderDepart,PilesDeMarchandisesInitiales,NumPileDepart,BourseInitiale, ReserveInitialeJoueur, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur, ReserveMachineINITIALE, NouvelleReserveMachine,[TeteListeDeplacement|QueueListeDeplacement]):- 
		write('-----------------------------TOUR '),write(Tour),write('------------------------------------'),nl,
		write('-----------------------------PILES--------------------------'),nl,
		affichageTeteEtTrader(PilesDeMarchandisesInitiales,TraderDepart,NumPileDepart),
		write('VALEUR DU DEPLACEMENT ? 1,2 ou 3'),nl,
		read(Deplacement),
		jouer_coup(1, PilesDeMarchandisesInitiales, BourseInitiale, TraderDepart, ReserveInitialeJoueurDeCeTour, Deplacement, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur,NumPileDepart,ReserveMachineINITIALE),nl,
		write('---------------------------RESERVE DE LA MACHINE------------------------'),nl,
		write(ReserveMachineINITIALE),nl,nl,
		write('CONTINUE ? OUI 1 NON 2'),nl,
		read(Reponse),
		Reponse = 1,
		continuer2(Reponse),
		write('----------------------------PLACE A LA MACHINE---------------------------'),nl,
		recupereListeCoups(PilesMarchandisesApresCoup, NouvelleBourse, PositionTraderArrivee, PositionTraderArriveeBIS, ListeDepartBIS, ListeArriveeBIS,[Piece1BIS|PilePrecedBIS],[Piece2BIS|PileSuivBIS],X,[TeteListeDeplacement|QueueListeDeplacement],ListeCoups,ListeDesCoupsPossibles,ReserveInitialeMachine,NouvelleReserveJoueur,PilesMarchandisesApresCoupMachine, NouvelleBourseMachine, NouvelleReserveMachine),
		write('La bourse apres le coup de la machine est :   '), write(NouvelleBourseMachine),nl,nl,
		TourSuiv is Tour+1, 
		write('----------------------------PLACE A L HOMME---------------------------'),nl,
		boucleDeJeuHommeIA(TourSuiv,PositionTraderArriveeBIS,PilesMarchandisesApresCoupMachine,NumPileDepart, NouvelleBourseMachine,  NouvelleReserveJoueur, PositionTraderArriveeNouveauTour, ListeDepartBis, ListeArriveeBis,PieceGardeeBis, PieceJeteeBis,[Piece1Bis|PilePrecedBis],[Piece2Bis|PileSuivBis], PilesMarchandisesApresCoupMachineTour2,NouvelleBourseMachineTour2,NouvelleReserveJoueurTour2,NouvelleReserveMachine,NouvelleReserveMachineTour2,[TeteListeDeplacement|QueueListeDeplacement]).



%COMMENTAIRE :

%Ici, deux coups sont joues dans la boucle IA/HOMME puisque la boucle englobe le coup du joueur et celui de la machine pour ensuite retomber sur celui du joueur via l appel recursif sur la boucle. Notons que l appel recursif se fait en passant les nouveaux parametres au predicats boucle pour que le jeu ne revienne pas sans cesse a son etat initial. Il est est de meme dans les autres boucles.

%ENTREE boucleDeJeuHommeIA(1,2,[[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]],1,[[ble,7],[riz,6],[cacao,5],[cafe,4],[sucre,3],[mais,2]], [], PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur, [], NouvelleReserveMachine,[1,2,3]).


%--------------------------------------------------------------------------------------------------------------------

jouer_coupIA(1, PilesMarchandisesApresCoup, NouvelleBourse, PositionTraderArrivee, ReserveInitialeMachine, DeplacementMachine, PositionTraderArriveeMachine, ListeDepartMachine, ListeArriveeMachine,PieceGardeeMachine, PieceJeteeMachine, PilesMarchandisesApresCoupMachine,NouvelleBourseMachine,NouvelleReserveMachine,X, ReserveHomme,[TeteListeDeplacement|QueueListeDeplacement]):-
	coup_possibleIA(PilesMarchandisesApresCoup, NouvelleBourse, PositionTraderArrivee, PositionTraderArriveeMachine, ListeDepartMachine, ListeArriveeMachine,[Piece1M|PilePrecedM],[Piece2M|PileSuivM],X,[TeteListeDeplacement|QueueListeDeplacement],PieceGardeeM,PieceJeteeM,PieceGardee2M,PieceJetee2M,[MeilleurCoup|Reste]),
	premiersEle([MeilleurCoup|Reste],ListeDesMax),
	choixDeplacement(ListeDesMax,DeplacementMachine),
	modifierPlateau(PilesMarchandisesApresCoup, PilesMarchandisesApresCoupMachine,PositionTraderArriveeMachine),
	modifieBourse(NouveleBourse, PieceJeteeMachine, NouvelleBourseMachine),nl,
	modifieReserveJoueur(2,ReserveInitialeMachine, PieceGardeeMachine, NouvelleReserveMachine, ReserveHomme),nl,
	write('--------------------------NOUVELLES TETES DE PILES----------------------'),nl,
	affichageTeteEtTrader(PilesMarchandisesApresCoupMachine,PositionTraderArriveeMachine,X).


jouer_coupIA(2, PilesMarchandisesApresCoup, NouvelleBourse, PositionTraderArrivee, ReserveInitialeMachine, DeplacementMachine, PositionTraderArriveeMachine, ListeDepartMachine, ListeArriveeMachine,PieceGardeeMachine, PieceJeteeMachine, PilesMarchandisesApresCoupMachine,NouvelleBourseMachine,NouvelleReserveMachine,X, ReserveHomme,[TeteListeDeplacement|QueueListeDeplacement]):-
	coup_possibleIA(PilesMarchandisesApresCoup, NouvelleBourse, PositionTraderArrivee, PositionTraderArriveeMachine, ListeDepartMachine, ListeArriveeMachine,[Piece1M|PilePrecedM],[Piece2M|PileSuivM],X,[TeteListeDeplacement|QueueListeDeplacement],PieceGardeeM,PieceJeteeM,PieceGardee2M,PieceJetee2M,[MeilleurCoup|Reste]),
	premiersEle([MeilleurCoup|Reste],ListeDesMax),
	choixDeplacement(ListeDesMax,DeplacementMachine),
	modifierPlateau(PilesMarchandisesApresCoup, PilesMarchandisesApresCoupMachine,PositionTraderArriveeMachine),
	modifieBourse(NouveleBourse, PieceJeteeMachine, NouvelleBourseMachine),nl,
	modifieReserveJoueur(2,ReserveInitialeMachine, PieceGardeeMachine, NouvelleReserveMachine, ReserveHomme),nl,
	write('--------------------------NOUVELLES TETES DE PILES----------------------'),nl,
	affichageTeteEtTrader(PilesMarchandisesApresCoupMachine,PositionTraderArriveeMachine,X).

%COMMENTAIRE :

%predicat qui nous permet de jouer un coup automatiquement (la machine). Pour cela, on entre une liste de deplacement possibles [1,2,3], et la tete de cette tete va etre prise au fur et a mesure pour generer les deplacements possibles. Ici, la machine va choisir son coup grace au predicat choixdeplacement qui choisit aleatoirement un coup a jouer pour la machine. Notons ici un point important : Aucune strategie n est adoptee vis a vis de la machine. On aurait pu lui faire jouer a chaque fois le meilleur coup 

%---------------------------------------------------------------------------------------------------------------------

choixDeplacement(ListeDesMax,Deplacement):-
				choixE(ListeDesMax, [T|Q]),
				Deplacement is T.  


%COMMENTAIRE:

%Ce predicat choisit parmis la liste des meilleurs coups selon la valeur du deplacement, le deplacement que va jouer la machine a ce tour. ce choix est aleatoire ici, aucune strategie n est appliquee quant au jeu de la machine. On le repete encore une fois (A METTRE DANS LE RAPPORT) que nous aurions pu penser une amelioration qui faisait jouer a chaque fois le meilleur coup a la machine!! ce qui l a rendrait tres dure a battre.
				
			

choixE([],[]).
choixE(List, Element):-length(List, Res),
		BornePlus is Res+1,	
		random(1, BornePlus, Index),
		nth1(Index, List, Element).

%--------------------------------------------------------------------------------------------------------------------

%NB:

%On aurait pu faire un predicat jouer_coupIABIS dans lequel l IA joue a chaque fois le meilleur coup possible. Ici nous choisissons de faire choisir la machine entre les meilleurs coups de chaque deplacements (le meilleur coup du deplacement de 1, le meilleur coup de deplacement 2 et le meilleur de deplacement 3). Ces meilleurs coups sont repertories dans la liste nommee ([MeilleuCoup|Reste]) dans le predicat coup possible. 


pieceGardeeEtJeteeIA2([Piece1|PilePreced],[Piece2|PileSuiv],TraderArrivee,PilesDeMarchandisesInitiales,PieceGardee,PieceJetee,PieceGardee2,PieceJetee2,Deplace,BourseAInstantT,Maximum,Minimum):-
						TraderPreced is TraderArrivee-1,
						TraderPreced >=1,
						nth1(TraderPreced, PilesDeMarchandisesInitiales, [Piece1|PilePreced]),
						TraderSuiv is TraderArrivee+1,
						length(PilesDeMarchandisesInitiales, L),
						TraderSuiv =< L, 
						nth1(TraderSuiv, PilesDeMarchandisesInitiales, [Piece2|PileSuiv]),
						ListeChoix = [Piece1,Piece2],nl,
						write('Voici les pieces parmis lesquelles vous avez le choix pour un deplacement de '),write(Deplace),write(' :  '),nl,nl,
						write('____________________'),nl,
						write(' |'),write(Piece1), write(' et '), write(Piece2), write(' |'),nl,
						write('____________________'),nl,nl,
						write('i. Possibilite 1  : '),nl,
						write('------------------'),nl,			
						nth1(1, ListeChoix, PieceGardee),
						supUNE(PieceGardee,ListeChoix,NewListeChoix),
						nth1(1, NewListeChoix, PieceJetee),
						element([PieceGardee,ValeurG],BourseAInstantT),
						element([PieceJetee,ValeurJ],BourseAInstantT),
%ici le predicat element([PieceGardee,Valeur],Bourse), permet de recuperer, dans la liste BourseAInstantT, l element (la liste) contenant la piece que l on garde (connu a ce stade) afin d en connaitre la valeur marchande (inconnue a ce stade, mais connue grace au predicat). La valeur marchande est la queue de la liste dont la tete est la PieceGardee (2 elements dans la liste).
						write('Vous pouvez jeter:  '), write(PieceJetee),nl,
						write('Vous pouvez garder:  '), write(PieceGardee),write(' de valeur sur le marché : '), write(ValeurG),nl,nl,
						%write('OU BIEN'),nl,nl,
						write('ii. Possibilite 2  : '),nl,
						write('------------------'),nl,	
						nth1(2, ListeChoix, PieceGardee2),
						supUNE(PieceGardee2,ListeChoix,NewListeChoix2),
						nth1(1, NewListeChoix2, PieceJetee2),
						element([PieceGardee2,Valeur2G],BourseAInstantT),
						element([PieceJetee2,Valeur2J],BourseAInstantT),
						write('Vous pouvez jeter:  '), write(PieceJetee2),nl,
						write('Vous pouvez garder:  '), write(PieceGardee2),write(' de valeur sur le marché : '), write(Valeur2G),nl,nl,
						write('pieceGardee1'), write(PieceGardee),nl,		
						write(ValeurG),nl,
						write('pieceGardee2'), write(PieceGardee2),nl,
						write(Valeur2G),nl,
						write('pieceJetee1'), write(PieceJetee),nl,
						write(ValeurJ),nl,
						write('pieceJetee2'), write(PieceJetee2),nl,
						write(Valeur2J),nl,
						write('-------------LE MEILLEUR COUP DE CE DEPLACEMENT-------------'),nl,nl,
						listeMAXetMIN([[Deplace,PieceGardee,ValeurG], [Deplace,PieceJetee,ValeurJ]],[[Deplace,PieceJetee,valeurJ], [Deplace,PiecGardee,ValeurG]], [Maximum|[Minimum]]),
						write(Maximum),nl,nl,
						write(Minimum),nl,nl.


%-----------------------------------------------------------------------------------------------------------------------------


listeMAXetMIN([[Deplace,PieceGardee1|[ValeurG]], [Deplace,PieceJetee1|[ValeurJ]]],[[Deplace,PieceGardee2|[Valeur2G]], [Deplace,PieceJetee2|[Valeur2J]]], [Maximum|[PieceJ]]):- ValeurG =< Valeur2G, [Maximum|[PieceJ]] = [[Deplace,PieceGardee2,Valeur2G], [Deplace,PieceJetee2,Valeur2J]],!.

listeMAXetMIN([[Deplacement1,PieceGardee1|[ValeurG]], [Deplacement1,PieceJetee1|[ValeurJ]]],[[Deplacement1,PieceGardee2|[Valeur2G]], [Deplacement1,PieceJetee2|[Valeur2J]]], [[Deplacement1,PieceGardee1|[ValeurG]], [Deplacement1,PieceJetee1|[ValeurJ]]]).


%ENTREE: listeMAXetMIN([[1,ble,7], [1,mais,6]],[[2,riz,5], [2,cacao,6]], [Maximum|[PieceJetee]]).


%----------------------------------------------------------------------------------------------------------------------------------------

coup_possiblePourBoucleIA([Piece1|PilePreced],[Piece2|PileSuiv],TraderDepart,TraderArrivee,PilesDeMarchandisesInitiales,Deplace,BourseAInstantT,[Coup1,Coup2]):-
						TraderArrivee is TraderDepart+Deplace,
						TraderPreced is TraderArrivee-1,
						TraderPreced >=1,
						nth1(TraderPreced, PilesDeMarchandisesInitiales, [Piece1|PilePreced]),
						TraderSuiv is TraderArrivee+1,
						length(PilesDeMarchandisesInitiales, L),
						TraderSuiv =< L, 
						nth1(TraderSuiv, PilesDeMarchandisesInitiales, [Piece2|PileSuiv]),
						ListeChoix = [Piece1,Piece2],
						element([Piece1,Valeur1],BourseAInstantT),
						element([Piece2,Valeur2],BourseAInstantT),
						write('Voici les pieces parmis lesquelles vous avez le choix pour un deplacement de '),write(Deplace),write(' :  '),nl,nl, ValeurDec2 is Valeur2-1,
						Coup1 = [[Deplace,Piece1,Valeur1],[Deplace,Piece2,ValeurDec2]],
						Coup2 = [[Deplace,Piece2,Valeur2],[Deplace,Piece1,ValeurDec1]],
						write('Vous pouvez jouer le coup :  '), write(Coup1),nl,
						write('la valeur de la marchandise jetee  "'), write(Piece2), write('"  vaut maintenant :  '), write(ValeurDec2),nl, ValeurDec1 is Valeur1-1,
						write('ou bien le coup :  '), write(Coup2),
						write('la valeur de la marchandise jetee   "'), write(Piece1), write('"   vaut maintenant :   '), write(ValeurDec1),nl,
						write('Le trader est positionné en : '), write(TraderArrivee),write(' a l arrivee'),nl.



%Entree : coup_possiblePourBoucleIA([Piece1|PilePreced],[Piece2|PileSuiv],3,Arrivee,[[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]],2,[[ble,7],[riz,6],[cacao,5],[cafe,4],[sucre,3],[mais,2]],[Coup1,Coup2]).

%--------------------------------------------------------------------------------------------------------------------------

listeCoupsIA(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[],[QueueListeCoupsPossibles],4):- nl,nl, write('Tous les cas ont été traités !'),nl,nl.


listeCoupsIA(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement],[[Coup1,Coup2]|QueueListeCoupsPossibles],Compteur):-
	Deplace is TeteListeDeplacement,
	coup_possiblePourBoucleIA([Piece1|PilePreced],[Piece2|PileSuiv],TraderDepart,TraderArrivee,PilesDeMarchandisesInitiales,Deplace,BourseAInstantT,[Coup1,Coup2]),
	NewCompteur is Compteur+1,
	listeCoupsIA(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, NouveauTraderArrivee, ListeDepart, NouvelleListeArrivee,[Piece1BIS|PilePrecedBIS],[Piece2BIS|PileSuivBIS],X,QueueListeDeplacement,QueueListeCoupsPossibles,NewCompteur).



%ENTREE listeCoupsIA([[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]], [[ble,7],[riz,6],[cacao,5],[cafe,4],[sucre,3],[mais,2]], 3, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],1,[1,2,3],[[Coup1,Coup2]|QueueListeCoupsPossibles],1).


%COMMENTAIRE:

%Ce predicat renvoie une liste de tous les coups possibles a partir d une position donnée

%----------------------------------------------------------------------------------------------------------------------------


recupereListeCoups(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, PositionTraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement],ListeCoups,ListeDesCoupsPossibles,ReserveInitialeMachine,ReserveHomme,PilesMarchandisesApresCoupMachine,NouvelleBourseMachine, NouvelleReserveMachine):-
			listeCoupsIA(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement],ListeCoups,1),
			premiersEle(ListeCoups,ListeDesCoupsPossibles),
			random(1,4,ValeurDeplacement),
			write('La machine va se deplacer de :  '), write(ValeurDeplacement),nl,nl,
			elementN(ValeurDeplacement, ListeDesCoupsPossibles,CoupPossiblesPourLeDeplacement), %Ici on extrait de notre liste repertoriant tous les coups possibles, les 2 coups possibles pour le meme deplacement.
			PositionTraderArrivee is TraderDepart+ValeurDeplacement,
			write('La position du trader a la fin de ce coup est  :  '), write(PositionTraderArrivee),		
			write('   VOILA  :  '), write(CoupPossiblesPourLeDeplacement), nl,nl,
			random(1,3,ValeurCoupJouer), %On recupere des predicats precedents une liste de 2 coups associes a un deplacement. Donc ici on en selectionne un des 2 ALEATOIREMENT (AUCUNE STRATEGIE n est adoptee ici)
			elementN(ValeurCoupJouer, CoupPossiblesPourLeDeplacement, CoupJouer),
			write('Le coup joué est :  '), write(CoupJouer),nl,nl,
			[Garder|[Jeter]] = CoupJouer,
			write('La partie gardée:  '), write(Garder), write('  et la partie jetee:  '), write(Jeter),nl,nl,
			elementN(2, Jeter, MarchandiseJetee),
			write('La machine jette :  '), write(MarchandiseJetee),nl,nl,
			elementN(2, Garder, MarchandiseGardee),
			write('La machine garde :  '), write(MarchandiseGardee),nl,nl,
			modifieBourseIA(BourseAInstantT, MarchandiseJetee, NouvelleBourseMachine),nl,
			write('La nouvelle bourse est :  '),write(NouvelleBourseMachine),nl,nl,
			modifieReserveMACHINE(2,ReserveInitialeMachine, MarchandiseGardee, NouvelleReserveMachine, ReserveHomme),nl,
			modifierPlateau(PilesDeMarchandisesInitiales, PilesMarchandisesApresCoupMachine,TraderArrivee),
			write('Piles apres coup :   '), write(PilesMarchandisesApresCoupMachine),nl,nl,
			affichageTeteEtTrader(PilesMarchandisesApresCoupMachine, PositionTraderArrivee,1).


%ENTREE recupereListeCoups([[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]], [[ble,7],[riz,6],[cacao,5],[cafe,4],[sucre,3],[mais,2]], 2, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],1,[1,2,3],ListeCoups,ListeRecup,[],[ble],PilesMarchandisesApresCoupMachine, NouvelleBourseMachine, NouvelleReserveMachine).


%COMMENTAIRE:

%Ce predicat choisit parmis tous les coups possibles (generes a partir du predicat listeCoupsIA), un coup au hasard. On a pas prit en compte de strategies quelconques ici. La machine joue aleatoirement. On recupere donc la liste de tous les coups possibles dans laquelle on choisit aleatoirement un coup. A noter que la succession de predicats elementN resulte du fait que l on une liste de la forme :
% [[[[1,sucre,3],[1,riz,5]],[[1,riz,6],[1,sucre,2]]]<---,[[[2,mais,2],[2,cacao,4]],[[2,cacao,5],[2,mais,1]]]<---,[[[3,riz,6],[3,ble,6]],[[3,ble,7],[3,riz,5]]]<---]

%Les <--- representent les deux doublets piece gardee/ piece jetee possible pour chaque deplacement. De ce fait le premier random va nous permettre de choisir aleatoirement un deplacement. On prelevera donc le doublet correspondant dans la liste ci dessus. Ensuite vient le moment de choisir lequel de ces deux coups possible va etre effectivement joue. Puis il faut separer le coup joue en 2 parties : une partie contenant la piece jetee et une autre contenant la piece gardee, avant d en prelever effectivement les pieces gardees et les pieces jetees ainsi que leur valeurs que l on va ensuite pouvoir actualiser et subsituer dans la bourse.

%Sera renvoyé, dans la variable ListeCoups la liste de tous les coups possibles sous la forme [[deplacement, marchandiseGardee, valeur], [deplacement, marchandiseJetee, valeurAPRESCOUP]]
%---------------------------------------------------------------------------------------------------------


elementN(1,[X|_],X).
elementN(N,[_|Q],X):- M is N-1, elementN(M,Q,X).


%---------------------------------------------------------------------------------------------------------


%Entree listeCoupsIA([[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]], [[ble,7],[riz,6],[cacao,5],[cafe,4],[sucre,3],[mais,2]], 2, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],1,[1,2,3],ListeCoups,1).

%-------------------------------

premiersEle([T1,T2,T3|Q],[T1,T2,T3]). 

%Car la liste [MeilleurCoup|Reste] generee est imparfaite dans le sens ou on a des variables generees a la fin
%On le refais tourner sur ListeCoups pour avoir une liste de coups bien formée et retirer les _ qui sont presents a la fin.

%--------------------------------


jouer_coupMACHINE(PilesMarchandisesApresCoup, BourseAInstantT, TraderDepart, PilesMarchandisesApresCoupMachine, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement], ListeCoups,MarchandiseGardee,ValeurG,MarchandiseJetee,ValeurJ,ReserveInitialeMachine,NouvelleReserveMachine,ReserveHomme,NouvelleBourseMachine):-
		listeCoupsIA(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement],ListeCoups,1),
		premiersEle(ListeCoups,ListeDesCoupsPossibles),
		random(1,4,ValeurDeplacement),
		element(CoupSpourLeDeplacement,ListeDesCoupsPossibles),
		random(1,3,Coup),
		nth1(Coup,CoupSpourLeDeplacement,CoupJouer),
		[Garder|Jeter] = CoupJouer,
		nth1(2,Jeter,MarchandiseJetee),
		modifierPlateau(PilesMarchandisesApresCoup, PilesMarchandisesApresCoupMachine,PositionTraderArriveeMachine),
		modifieBourseIA(BourseAInstantT, MarchandiseJetee, NouvelleBourseMachine),nl,
		modifieReserveJoueur(2,ReserveInitialeMachine, MarchandiseGardee, NouvelleReserveMachine, ReserveHomme),nl,
		write('--------------------------NOUVELLES TETES DE PILES----------------------'),nl,
		affichageTeteEtTrader(PilesMarchandisesApresCoupMachine,PositionTraderArriveeMachine,X),
		write('La machine a joué son coup voici les caracteristiques : '),
		write(MarchandiseGardee),nl,nl,
		write(MarchandiseJetee),nl,nl,
		write('la position du trader est: '),write(TraderArrivee),
		write('Au tour de l hommme maintenant !').


%Entree jouer_coupMACHINE([[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]], [[ble,7],[riz,6],[cacao,5],[cafe,4],[sucre,3],[mais,2]], 3, PilesMarchandisesApresCoupMachine, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],1,[1,2,3],ListeCoups,MarchandiseGardee,ValeurG,MarchandiseJetee,ValeurJ,[],NouvelleReserveMachine,[]).

%COMMENTAIRE:

%Comme le nom du predicat l indique, ce predicat permet de simuler un coup par la machine.

%------------------------------------------------------------------------------------------


modifieBourseIA(BourseAInstantT, MarchandiseJetee, NouvelleBourseMachine):-
		write('----------------------NOUVELLE BOURSE--------------------'),nl,
		element([MarchandiseJetee,X],BourseAInstantT), Y is X-1, substitue([MarchandiseJetee,X], [MarchandiseJetee,Y], BourseAInstantT, NouvelleBourseMachine),
		write(NouvelleBourseMachine),nl.


substitue(_,_,[],[]).
substitue(X,Y,[X|Q],[Y|NQ]):-substitue(X,Y,Q,NQ).
substitue(X,Y,[T|Q],[T|Res]):- T\=X, substitue(X,Y,Q,Res).

%-------------------------------------------------------------------------------------------


modifieReserveMACHINE(2, ReserveInitialeJoueur2, PieceGardee, NouvelleReserveJoueur2, ReserveInitialeJoueur1):-
							write('-----------------NOUVELLE RESERVE MACHINE----------------'),nl,
							concat(ReserveInitialeJoueur2, [PieceGardee], NouvelleReserveJoueur2),
							write(NouvelleReserveJoueur2),nl,
							write('-----------------RESERVE DE L HOMME----------------'),nl,
							write(ReserveInitialeJoueur1).


%===================================================================================================================================================
%=================================================================   BOUCLE IA/IA  =================================================================
%===================================================================================================================================================


boucleDeJeuIAIA(Tour,JoueurX,TraderDebut,PilesDeMarchandisesInitiales,NumPileDepart,BourseInitiale, ReserveInitialeMachine1, TraderArriveeCoup, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveMachine1, ReserveInitialeMachine2, [TeteListeDeplacement|QueueListeDeplacement]):- 
		write('-----------------------------TOUR '),write(Tour),write('------------------------------------'),nl,
		write('-----------------------------PILES--------------------------'),nl,
		affichageTeteEtTrader(PilesDeMarchandisesInitiales,TraderDebut,NumPileDepart),
		write('----------------------------PLACE A LA MACHINE '),write(JoueurX),write(' --------------------------'),nl,
		recupereListeCoupsIAIA(JoueurX,PilesDeMarchandisesInitiales, BourseInitiale, TraderDebut, TraderArriveeCoup, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement],ListeCoups,ListeDesCoupsPossibles,ReserveInitialeMachine1,ReserveInitialeMachine2,PilesMarchandisesApresCoup,NouvelleBourse, NouvelleReserveMachine1),
		TourSuiv is Tour+1,
		write('NOUVELLE BOURSE :   '),
		write(NouvelleBourse),nl,
		JoueurY is (JoueurX mod 2 + 1), %On fait comme si on avait 2 joueurs (reels) ici pour se ramener le plus possible au cas homme contre homme.
		write('CONTINUE ? OUI 1 NON 2'),nl,
		read(Reponse),
		continuer2(Reponse),
		Reponse = 1,
		boucleDeJeuIAIA(TourSuiv, JoueurY, TraderArriveeCoup, PilesMarchandisesApresCoup, NumPileDepart, NouvelleBourse, ReserveInitialeMachine2, TraderArriveeNouveauTour, ListeDepartBis, ListeArriveeBis, PieceGardeeBis, PieceJeteeBis, [Piece1Bis|PilePrecedBis],[Piece2Bis|PileSuivBis], PilesMarchandisesApresCoupTour2,NouvelleBourseTour2,NouvelleReserveMachine2,NouvelleReserveMachine1,[TeteListeDeplacement|QueueListeDeplacement]).


%ENTREE boucleDeJeuIAIA(1,2,3,[[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]],1,[[ble,7],[riz,6],[cacao,5],[cafe,4],[sucre,3],[mais,2]], [], PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveMachine1, [], [1,2,3]).


%-------------------------------------------------------------------------------------------------------------------------------------

modifieReserveMACHINEIAIA(1, ReserveInitialeMachine1, PieceGardee, NouvelleReserveJoueur1, ReserveInitialeJoueur2):-
							write('-----------------NOUVELLE RESERVE MACHINE----------------'),nl,
							concat(ReserveInitialeJoueur1, [PieceGardee], NouvelleReserveJoueur1),
							write(NouvelleReserveJoueur1),nl,
							write('-----------------RESERVE DE L AUTRE MACHINE----------------'),nl,
							write(ReserveInitialeJoueur2).

modifieReserveMACHINEIAIA(2, ReserveInitialMachine2, PieceGardee, NouvelleReserveJoueur2, ReserveInitialeJoueur1):-
							write('-----------------NOUVELLE RESERVE MACHINE----------------'),nl,
							concat(ReserveInitialeJoueur2, [PieceGardee], NouvelleReserveJoueur2),
							write(NouvelleReserveJoueur2),nl,
							write('-----------------RESERVE DE L AUTRE MACHINE----------------'),nl,
							write(ReserveInitialeJoueur1).


%---------------------------------------------------------------------------------------------------------------------------------------


recupereListeCoupsIAIA(Joueur,PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement],ListeCoups,ListeDesCoupsPossibles,ReserveInitialeMachine1,ReserveInitialeMachine2,PilesMarchandisesApresCoupMachine,NouvelleBourse, NouvelleReserveMachine1):-
			listeCoupsIA(PilesDeMarchandisesInitiales, BourseAInstantT, TraderDepart, TraderArrivee, ListeDepart, ListeArrivee,[Piece1|PilePreced],[Piece2|PileSuiv],X,[TeteListeDeplacement|QueueListeDeplacement],ListeCoups,1),
			premiersEle(ListeCoups,ListeDesCoupsPossibles),
			random(1,4,ValeurDeplacement),
			write('La machine va se deplacer de :  '), write(ValeurDeplacement),nl,nl,
			elementN(ValeurDeplacement, ListeDesCoupsPossibles,CoupPossiblesPourLeDeplacement), %Ici on extrait de notre liste repertoriant tous les coups possibles, les 2 coups possibles pour le meme deplacement.
			PositionTraderArrivee is TraderDepart+ValeurDeplacement,
			moduloTrader(PositionTraderArrivee, PositionTraderArrivee, PilesDeMarchandisesInitiales),
			write('La position du trader a la fin de ce coup est:  '), write(PositionTraderArrivee),
			write('    VOILA  :  '), write(CoupPossiblesPourLeDeplacement), nl,nl,
			random(1,3,ValeurCoupJouer), %On recupere des predicats precedents une liste de 2 coups associes a un deplacement. Donc ici on en selectionne un des 2 ALEATOIREMENT (AUCUNE STRATEGIE n est adoptee ici)
			elementN(ValeurCoupJouer, CoupPossiblesPourLeDeplacement, CoupJouer),
			write('Le coup joué est :  '), write(CoupJouer),nl,nl,
			[Garder|[Jeter]] = CoupJouer,
			write('La partie gardée:  '), write(Garder), write('  et la partie jetee:  '), write(Jeter),nl,nl,
			elementN(2, Jeter, MarchandiseJetee),
			write('La machine jette :  '), write(MarchandiseJetee),nl,nl,
			elementN(2, Garder, MarchandiseGardee),
			write('La machine garde :  '), write(MarchandiseGardee),nl,nl,
			modifieBourseIA(BourseAInstantT, MarchandiseJetee, NouvelleBourse),nl,
			write('La nouvelle bourse est :  '),write(NouvelleBourse),nl,nl,
			modifieReserveMACHINEIAIA(Joueur,ReserveInitialeMachine1, MarchandiseGardee, NouvelleReserveMachine1, ReserveInitialeMachine2),nl,
			modifierPlateau(PilesDeMarchandisesInitiales, PilesMarchandisesApresCoupMachine,TraderArrivee),
			write('Piles apres coup :   '), write(PilesMarchandisesApresCoupMachine),nl,nl,
			affichageTeteEtTrader(PilesMarchandisesApresCoupMachine, PositionTraderArrivee,1).













moduloTrader(PositionTraderArrivee, PositionTraderArrivee, PilesDeMarchandisesInitiales):- 
							length(PilesDeMarchandisesInitiales,L),
							PositionTraderArrivee =< L.



moduloTrader(PositionTraderArrivee, PositionRenvoyee, PilesDeMarchandisesInitiales):- 
							length(PilesDeMarchandisesInitiales,L),
							PositionTraderArrivee > L,
							PositionRenvoyee is PositionTraderArrivee mod L.





boucleDeJeuMachineMachine(Tour,TraderDebut,Res,NumPileDepart,JoueurX,BourseInitiale, ReserveInitialeJoueurDeCeTour, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoupMachine,NouvelleBourse,NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR, ListeDeplacement):- length(Res,Taille), Taille =< 2,nl,nl, write('FIN DE LA PARTIE, COMPTEZ VOS POINTS'),nl,nl.

boucleDeJeuMachineMachine(Tour,TraderDebut,Res,NumPileDepart,JoueurX,BourseInitiale, ReserveInitialeJoueurDeCeTour, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourseMachine,NouvelleReserveMachine, ReSERVEAUTREJOUEUR,ListeDeplacement):-
		write('-----------------------------TOUR '),write(Tour),write('------------------------------------'),nl,
		write('-----------------------------PILES--------------------------'),nl,
		affichageTeteEtTrader(Res,TraderDebut,NumPileDepart),
		jouer_coupIAB(JoueurX, Res, BourseInitiale, TraderDebut, ReserveInitialeJoueurDeCeTour, DeplacementMachine, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoupMachine,NouvelleBourse,NouvelleReserveJoueur1,NumPileDepart,ReSERVEAUTREJOUEUR,ListeDeplacement),nl,
		write('---------------------------RESERVE DE L AUTRE JOUEUR------------------------'),nl,
		write(ReSERVEAUTREJOUEUR),nl,nl,
		write('CONTINUE ? OUI (1) NON (2)'),nl,
		read(Reponse),
		continuer2(Reponse),
		JoueurY is (JoueurX mod 2 + 1),
		write('----------------------------PLACE AU JOUEUR  '),write(JoueurY),write('  ------------------------------'),nl,
		TourSuiv is Tour+1, 
		boucleDeJeuMachineMachine(TourSuiv,PositionTraderArrivee,PilesMarchandisesApresCoupMachine,NumPileDepart,JoueurY, NouvelleBourseMachine,  ReSERVEAUTREJOUEUR, PositionTraderArriveeBis, ListeDepartBis, ListeArriveeBis,PieceGardeeBis, PieceJeteeBis,[Piece1Bis|PilePrecedBis],[Piece2Bis|PileSuivBis], PilesMarchandisesApresCoupBis,NouvelleBourseBis,NouvelleReserveDuJoueurDuTourSuivant,NouvelleReserveMachine, ListeDeplacement).


jouer_coupIAB(JoueurX, PilesMarchandisesApresCoup, BourseInitiale, TraderDebut, ReserveInitialeMachine, DeplacementMachine, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1M|PilePrecedM],[Piece2M|PileSuivM],PilesMarchandisesApresCoupMachine,NouvelleBourseMachine,NouvelleReserveMachine,X, ReSERVEAUTREJOUEUR,[TeteListeDeplacement|QueueListeDeplacement]):-
	random(1,4,Deplacement),
	PositionTraderArrivee is TraderDebut+Deplacement,
	pieceGardeeEtJeteeIAB([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, PositionTraderArrivee,PilesMarchandisesApresCoup),
	modifierPlateau(PilesMarchandisesApresCoup, PilesMarchandisesApresCoupMachine,PositionTraderArrivee),
	modifieBourse(BourseInitiale, PieceJetee, NouvelleBourseMachine),nl,
	modifieReserveJoueur(JoueurX,ReserveInitialeMachine, PieceGardee, NouvelleReserveMachine, ReSERVEAUTREJOUEUR),nl,
	write('--------------------------NOUVELLES TETES DE PILES----------------------'),nl,
	affichageTeteEtTrader(PilesMarchandisesApresCoupMachine,PositionTraderArrivee,X).



%CELLE CIIIIIIIIIIIIIIIIIIIIIIII !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%=======================================================================================================================================
%=======================================    MACHINE/MACHINE CA MAAAAAAARCHE     ========================================================
%=======================================================================================================================================


pieceGardeeEtJeteeMachineVSMachine([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, TraderArrivee,PilesMarchandisesApresCoup):-
						TraderPreced is TraderArrivee-1,
						TraderPreced >=1,
						nth1(TraderPreced, PilesMarchandisesApresCoup, [Piece1|PilePreced]),
						TraderSuiv is TraderArrivee+1,
						length(PilesMarchandisesApresCoup, L),
						TraderSuiv =< L,
						nth1(TraderSuiv, PilesMarchandisesApresCoup, [Piece2|PileSuiv]),
						ListeChoix = [Piece1,Piece2],nl,
						random(1,3,X),
						write('----------------CHOIX-------------------'),nl,
						nth1(X, ListeChoix, PieceGardee),
						supUNE(PieceGardee,ListeChoix,NewListeChoix),
						nth1(1, NewListeChoix, PieceJetee),
						write('LA MACHINE GARDE :  '), write(PieceGardee),nl.




pieceGardeeEtJeteeMachineVSMachine([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, TraderArrivee,PilesDeMarchandisesInitiales):-
						TraderPreced1 is TraderArrivee-1,
						TraderPreced1 = 0,
						length(PilesDeMarchandisesInitiales,L),
						TraderPreced is L,
						nth1(TraderPreced, PilesDeMarchandisesInitiales, [Piece1|PilePreced]),
						TraderSuiv is TraderArrivee+1,
						nth1(TraderSuiv, PilesDeMarchandisesInitiales, [Piece2|PileSuiv]),
						ListeChoix = [Piece1,Piece2],nl,
						random(1,3,X),
						write('-----------------CHOIX-------------------'),nl,				
						nth1(X, ListeChoix, PieceGardee),
						supUNE(PieceGardee,ListeChoix,NewListeChoix),
						nth1(1, NewListeChoix, PieceJetee),
						write('LA MACHINE GARDE :  '), write(PieceGardee),nl.





pieceGardeeEtJeteeMachineVSMachine([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, TraderArrivee,PilesDeMarchandisesInitiales):-
						length(PilesDeMarchandisesInitiales,L),
						TraderPreced is TraderArrivee-1,
						nth1(TraderPreced, PilesDeMarchandisesInitiales, [Piece1|PilePreced]),
						TraderSuiv1 is TraderArrivee+1,
						TraderSuiv1 > L,
						TraderSuiv = 1,
						nth1(TraderSuiv, PilesDeMarchandisesInitiales, [Piece2|PileSuiv]),
						ListeChoix = [Piece1,Piece2],nl,
						random(1,3,X),
						write('-----------------CHOIX-------------------'),nl,				
						nth1(X, ListeChoix, PieceGardee),
						supUNE(PieceGardee,ListeChoix,NewListeChoix),
						nth1(1, NewListeChoix, PieceJetee),
						write('LA MACHINE GARDE :  '), write(PieceGardee),nl.



boucleDeJeuMachineVSMachine(Tour,TraderDebut,Res,NumPileDepart,JoueurX,BourseInitiale, ReserveInitialeJoueurDeCeTour, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR):- length(Res,Taille), Taille =< 2,nl,nl, write('FIN DE LA PARTIE, COMPTEZ VOS POINTS'),nl,nl.

boucleDeJeuMachineVSMachine(Tour,TraderDebut,Res,NumPileDepart,JoueurX,BourseInitiale, ReserveInitialeJoueurDeCeTour, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR):-
		write('-----------------------------TOUR '),write(Tour),write('------------------------------------'),nl,
		write('-----------------------------PILES--------------------------'),nl,
		affichageTeteEtTrader(Res,TraderDebut,NumPileDepart),
		random(1,4,Deplacement),
		jouer_coupMachineVSMachine(JoueurX, Res, BourseInitiale, TraderDebut, ReserveInitialeJoueurDeCeTour, Deplacement, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1,NumPileDepart,ReSERVEAUTREJOUEUR),nl,
		write('---------------------------RESERVE DE L AUTRE JOUEUR------------------------'),nl,
		write(ReSERVEAUTREJOUEUR),nl,nl,
		write('CONTINUE ? OUI (1) NON (2)'),nl,
		read(Reponse),
		continuer2(Reponse),
		JoueurY is (JoueurX mod 2 + 1),
		write('----------------------------PLACE AU JOUEUR  '),write(JoueurY),write('  ------------------------------'),nl,
		TourSuiv is Tour+1, 
		boucleDeJeuMachineVSMachine(TourSuiv,PositionTraderArrivee,PilesMarchandisesApresCoup,NumPileDepart,JoueurY, NouvelleBourse,  ReSERVEAUTREJOUEUR, PositionTraderArriveeBis, ListeDepartBis, ListeArriveeBis,PieceGardeeBis, PieceJeteeBis,[Piece1Bis|PilePrecedBis],[Piece2Bis|PileSuivBis], PilesMarchandisesApresCoupBis,NouvelleBourseBis,NouvelleReserveDuJoueurDuTourSuivant,NouvelleReserveJoueur1).



jouer_coupMachineVSMachine(2, PilesDeMarchandisesInitiales, BourseInitiale, TraderDepart, ReserveInitialeJoueur2, Deplacement, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur2,X, ReSERVEAUTREJOUEUR):-
	coup_possible(PilesDeMarchandisesInitiales,TraderDepart,Deplacement,PositionTraderArrivee,ListeDepart,ListeArrivee),
	pieceGardeeEtJeteeMachineVSMachine([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, PositionTraderArrivee, PilesDeMarchandisesInitiales),
	modifierPlateau(PilesDeMarchandisesInitiales, PilesMarchandisesApresCoup,PositionTraderArrivee),
	modifieBourse(BourseInitiale, PieceJetee, NouvelleBourse),nl,
	modifieReserveJoueur(2,ReserveInitialeJoueur2, PieceGardee, NouvelleReserveJoueur2, ReSERVEAUTREJOUEUR),nl,
	write('--------------------------NOUVELLES TETES DE PILES----------------------'),nl,
	affichageTeteEtTrader(PilesMarchandisesApresCoup,PositionTraderArrivee,X).

jouer_coupMachineVSMachine(1, PilesDeMarchandisesInitiales, BourseInitiale, TraderDepart, ReserveInitialeJoueur2, Deplacement, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur2,X, ReSERVEAUTREJOUEUR):-
	coup_possible(PilesDeMarchandisesInitiales,TraderDepart,Deplacement,PositionTraderArrivee,ListeDepart,ListeArrivee),
	pieceGardeeEtJeteeMachineVSMachine([Piece1|PilePreced],[Piece2|PileSuiv],PieceGardee, PieceJetee, PositionTraderArrivee, PilesDeMarchandisesInitiales),
	modifierPlateau(PilesDeMarchandisesInitiales, PilesMarchandisesApresCoup,PositionTraderArrivee),
	modifieBourse(BourseInitiale, PieceJetee, NouvelleBourse),nl,
	modifieReserveJoueur(2,ReserveInitialeJoueur2, PieceGardee, NouvelleReserveJoueur2, ReSERVEAUTREJOUEUR),nl,
	write('--------------------------NOUVELLES TETES DE PILES----------------------'),nl,
	affichageTeteEtTrader(PilesMarchandisesApresCoup,PositionTraderArrivee,X).



%CELLE CIIIIIIIIIIIIIIIIIIIIIIII !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
%=======================================================================================================================================
%==============================================    HUMAIN/MACHINE CA MAAAAAARCHE     ==============================================================
%=======================================================================================================================================


boucleDeJeuHumainVSMachine(Tour,TraderDebut,Res,NumPileDepart,JoueurX,BourseInitiale, ReserveInitialeJoueurDeCeTour, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR):- length(Res,Taille), Taille =< 2,nl,nl, write('FIN DE LA PARTIE, COMPTEZ VOS POINTS'),nl,nl.

boucleDeJeuHumainVSMachine(Tour,TraderDebut,Res,NumPileDepart,JoueurX,BourseInitiale, ReserveInitialeJoueurDeCeTour, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, ReSERVEAUTREJOUEUR):-
		write('-----------------------------TOUR '),write(Tour),write('------------------------------------'),nl,
		write('-----------------------------PILES--------------------------'),nl,
		affichageTeteEtTrader(Res,TraderDebut,NumPileDepart),
		write('VALEUR DU DEPLACEMENT ? 1,2 ou 3'),nl,
		read(Deplacement),
		%deplacement(Deplacement),
		jouer_coup(JoueurX, Res, BourseInitiale, TraderDebut, ReserveInitialeJoueurDeCeTour, Deplacement, PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1,NumPileDepart,ReSERVEAUTREJOUEUR),nl,
		write('---------------------------  RESERVE DE LA MACHINE  ------------------------'),nl,
		write(ReSERVEAUTREJOUEUR),nl,nl,
		partieContinue(PileMarchandisesApresCoup), 
		write('CONTINUE ? OUI (1) NON (2)'),nl,
		read(Reponse),
		continuer2(Reponse),
		JoueurY is (JoueurX mod 2 + 1),
		write('----------------------------PLACE A LA MACHINE  '), write('------------------------------'),nl,
		affichageTeteEtTrader(Res,TraderDebut,NumPileDepart),
		random(1,4,DeplacementM),
		jouer_coupMachineVSMachine(JoueurY, PilesMarchandisesApresCoup, NouvelleBourse, PositionTraderArrivee, ReSERVEAUTREJOUEUR, DeplacementM, PositionTraderArriveeM, ListeDepartM, ListeArriveeM,PieceGardeeM, PieceJeteeM,[Piece1M|PilePrecedM],[Piece2M|PileSuivM], PilesMarchandisesApresCoupM,NouvelleBourseM,NouvelleReserveJoueurTourSuivant,NumPileDepart,ReserveInitialeJoueurDeCeTour),nl,
		write('---------------------------RESERVE DE L AUTRE JOUEUR------------------------'),nl,
		write(NouvelleReserveJoueur1),nl,nl,
		write('CONTINUE ? OUI (1) NON (2)'),nl,
		read(Reponse),
		continuer2(Reponse),
		TourSuiv is Tour+1, 
		boucleDeJeuHumainVSMachine(TourSuiv,PositionTraderArriveeM,PilesMarchandisesApresCoupM,NumPileDepart,JoueurX, NouvelleBourseM,  NouvelleReserveJoueur1, PositionTraderArriveeM, ListeDepartBis, ListeArriveeBis,PieceGardeeBis, PieceJeteeBis,[Piece1Bis|PilePrecedBis],[Piece2Bis|PileSuivBis], PilesMarchandisesApresCoupBis,NouvelleBourseBis,NouvelleReserveDuJoueur1BIS,NouvelleReserveJoueurTourSuivant).


%ce Predicat, inserer apres le coup du joueur permet de stopper la boucle au cas ou juste apres le coup de l homme le nombre de pile etait inferieur ou egal a 2.

partieContinue(PileMarchandisesApresCoup):- length(PileMarchandisesApresCoup, TailleListe), TailleListe >= 2.
partieContinue(PileMarchandisesApresCoup):- length(PileMarchandisesApresCoup, TailleListe), TailleListe =< 2, 
					write('********************************** FIN DE LA PARTIE MERCI D AVOIR JOUE *********************************').


%ENTREE : boucleDeJeuHumainVSMachine(1,1,[[sucre,riz,cafe,cafe],[sucre,mais,riz,cafe],[mais,cacao,riz,cacao],[riz,cacao,sucre,sucre],[cacao,cafe,ble,cacao],[ble,mais,ble,cafe],[ble,riz,ble,ble],[sucre,mais,cacao,sucre],[mais,riz,mais,cafe]],1,1,[[ble,7],[riz,6],[cacao,5],[cafe,4],[sucre,3],[mais,2]], [], PositionTraderArrivee, ListeDepart, ListeArrivee,PieceGardee, PieceJetee,[Piece1|PilePreced],[Piece2|PileSuiv], PilesMarchandisesApresCoup,NouvelleBourse,NouvelleReserveJoueur1, []).


continuer2(1).
continuer2(2):- write('*************************FIN DE LA PARTIE MERCI D AVOIR JOUE ! A BIENTOT**************************'),nl, fail.
continuer2(X):- X\=1, X\=2, write('Merci de bien vouloir entrer une valeur convenable, reesayez :  '), write('CONTINUE ? OUI (1) NON (2)'),nl, read(Reponse2), continuer(Reponse2).



 

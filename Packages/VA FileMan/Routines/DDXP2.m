DDXP2 ;SFISC/DPC-SELECTED FIELDS FOR EXPORT ;10/11/94  14:34
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN1 ;
 N Y,D,DICS D ^DICRW I Y=-1 G QUIT
 S Q="""",C=",",DC=0,L=1,DI=DIC,DALL(1)=1 W !
 D ^DIP2
 I $D(DDXPFDTM) S DIE="^DIPT(",DA=DDXPFDTM,DR="8///7" D ^DIE
QUIT ;
 K C,DA,DALL,DC,DI,DIE,DIC,DR,DTOUT,DUOUT,L,Q
 Q
VALALL ;
 W !,$C(7),"SORRY.  When choosing export fields, you cannot use ALL to select all fields.",!
 S Y=0 K X
 Q
VAL1 ;validates raw user input -- X contains user input
 S DDXPNG=0
 F DDXPCK=";C",";D",";L",";N",";R",";S",";T",";W",";X" D
 . I X[DDXPCK S DDXPNG=1 W !!,$C(7),"SORRY.  You cannot add "_DDXPCK_" to the export field specifications.",!
 . Q
 F DDXPCK="+","#","*","&","!" D
 . I $E(X)=DDXPCK S DDXPNG=1 W !!,$C(7),"SORRY.  You cannot choose the "_DDXPCK_" statistical operator when selecting fields for export.",!
 . Q
 I $E(X,$L(X))=":" S DDXPNG=1 W !!,$C(7),"SORRY.  You cannot jump to another file when selecting fields for export.",!
 I X[";""" S DDXPNG=1 W !!,$C(7),"SORRY.  You cannot enter a custom heading when selecting fields for export."
 K:DDXPNG X K DDXPNG,DDXPCK
 Q
VAL2 ;validates found field -- Y(0) contains 0-node of field DD
 S DDXPNG=0
 S %=+$P(Y(0),U,2) I '% G VAL2OUT
 I $P($G(^DD(%,.01,0)),U,2)["W" S DDXPNG=1 W !!,$C(7),"SORRY.  You cannot choose a word processing field for export.",!
VAL2OUT K:DDXPNG Y(0) K %,DDXPNG
 Q
VAL3 ;validates expression returned from DICOMP -- S contains expression
 S DDXPNG=0
 I S[";W"!(S[";m") S DDXPNG=1 W !!,$C(7),"SORRY.  That response is not acceptable when selecting fields for export.",!
 K:DDXPNG S K DDXPNG
 Q

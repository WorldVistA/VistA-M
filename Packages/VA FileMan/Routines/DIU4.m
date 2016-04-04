DIU4 ;SFISC/XAK-SPECIFIER ;6/11/93  2:29 PM
 ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
 W ! S DIU=Y K DIR G S:'$D(^DD(DI,0,"SP",+Y))
 S DIR("A",1)=$P(DIU,U,2)_" is already a specifier."
 S DIR("A")="Do you want to delete it"
 S DIR("??")="^W !!?5,""Deleting a specifier means that this field will not be used"",!?5,""in trying to match entries going from one system to another."""
 S DIR("B")="NO",DIR(0)="Y" D ^DIR G Q:$D(DTOUT)!$D(DUOUT),E:'Y
 K:Y ^DD(DI,0,"SP",+DIU) G Q
S S DIR("A")="Want to make "_$P(Y,U,2)_" a specifier"
 S DIR("??")="^W !!?5,""Making this field a specifier means that it will be used in"",!?5,""finding a specific entry when it is sent from one system to another."""
 S DIR("B")="NO",DIR(0)="Y" D ^DIR G Q:$D(DIRUT)!'Y
E K DIR("A") S DIR("A")="Is the value of this field unique for each entry"
 S DIR("??")="^W !!?5,""If this field is unique, then each entry in the file"",!?5,""has a different "_$P(DIU,U,2)_"."""
 D ^DIR G Q:$D(DIRUT) S:Y!('Y&(+DIU'=.01)) ^DD(DI,0,"SP",+DIU)=$S(Y:Y,1:"") G Q:'Y
 K DIR S DIR(0)="SO^"
 F %=0:0 S %=$O(^DD(DI,+DIU,1,%)) Q:+%'=%  I $D(^(%,0)),+^(0) S DIR(0)=DIR(0)_%_":"_$P(^(0),U,2)_"  "_$S($P(^(0),U,3)]"":$P(^(0),U,3),1:"REGULAR")_";"
 I $P(DIR(0),U,2)="" K:+DIU=.01 ^DD(DI,0,"SP",+DIU) G Q
 S DIR("?")="Enter one of the cross-references in the list, or press return."
 S DIR("A",1)="If one of the above provides a direct lookup by "_$P(DIU,U,2)_","
 S DIR("A")="please enter its number or name"
 D ^DIR I '$D(DTOUT),'$D(DUOUT) S ^DD(DI,0,"SP",+DIU)="1^"_$S(Y:$P(Y(0)," "),1:"")
 I $D(DIRUT),(+DIU=.01) K ^DD(DI,0,"SP",+DIU)
Q K DUOUT,DTOUT,C,DIR,DIRUT,DIROUT
 Q

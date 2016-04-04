DDPA2 ;SFISC/TKW  FIND NON-CANONIC SORT RANGES WITH NO ASK NODE ;8/8/95  10:46
V ;;22.2;MSC Fileman;;Jan 05, 2015;
 ;;Submitted to OSEHRA 5 January 2015 by the VISTA Expertise Network.
 ;;Based on Medsphere Systems Corporation's MSC Fileman 1051.
 ;;Licensed under the terms of the Apache License, Version 2.0.
 ;
EN ;  This routine will find any sort templates that have a sort field
 ; with a range that is FROM or TO a non-canonic number, has no
 ; ASK node, and that has
 ; had an extra space inserted by FM21 prior to patch DI*21*9.
 N I,J,X,Y,DIR,DIERR,DTOUT,DIRUT,DIROUT,DUOUT
 W !!,"This routine will report any sort templates that have been corrupted due to",!,"a bug in FM21 that has been repaired by patch DI*21*9.",!!
 W "If any templates are reported here, you can repair them by editing the template,",!,"without changing any of the sort fields.",!
 S DIR("?",1)="This routine will report any sort templates that may have been corrupted.",DIR("?",2)="If none show on the report, it means that none of the templates on your system"
 S DIR("?")="needed to be edited."
 S DIR(0)="Y",DIR("A")="Report corrupted sort templates",DIR("B")="Yes" D ^DIR K DIR Q:Y'=1
 W !!,"Searching Sort Template file...please wait",!!,"Report of templates that need to be repaired",!!
 F I=0:0 S I=$O(^DIBT(I)) Q:'I  S X=$P($G(^(I,0)),U) D
 . S DIERR=0 F J=0:0 Q:DIERR=1  S J=$O(^DIBT(I,2,J)) Q:'J  I $P($G(^(J,0)),U,10)=4,'$G(^("ASK")),$G(^("SRTTXT"))]"" D
 .. S Y=$P($G(^DIBT(I,2,J,"F")),U,2) I Y?1." "1.E S DIERR=1 Q
 .. S Y=$P($G(^DIBT(I,2,J,"T")),U,2) I Y?1." "1.E S DIERR=1 Q
 .. Q
 . I DIERR=1 W "No. "_I_"   Name: "_X,!
 . Q
 Q

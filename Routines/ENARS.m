ENARS ;(WIRMFO)/SAB-SEACH ARCHIVE LOG FOR EQUIPMENT ;2.24.97
 ;;7.0;ENGINEERING;**40**;Aug 17, 1993
 ;CALLED BY ENAR
 Q
S ; entry point
 ; ask equipment entry #
 S DIR(0)="FO^1:16",DIR("A")="Search for Equipment ENTRY #"
 S DIR("?")="Enter an archived equipment Entry # (e.g. 4157)"
 D ^DIR K DIR G:Y=""!$D(DIRUT) EXIT
 S ENEQ=$S(Y["-":$P(Y,"-",2),1:Y)
 ;
 I ENEQ'?1.10N W $C(7),!,"Equipment ENTRY #: ",ENEQ," is not valid",! G S
 S ENDA=$O(^ENG(6919,"AE",ENEQ,0))
 I ENDA'?1.N W $C(7),!,"Equipment ENTRY #: ",ENEQ," was not found in an archive set",! G S
 ; show set info
 D ID^ENAR2
 S ENDA(1)=$O(^ENG(6919,"AE",ENEQ,ENDA,0))
 W !!!!,"Equipment ENTRY #: ",ENEQ," was saved with record name "
 W $P($G(^ENG(6919,ENDA,3,ENDA(1),0)),U)
 W !,"in the archive set shown above.",!
 D RECALL^DILFD(6919,ENDA_",",DUZ) ; save log entry for space bar recall
 ;
 G S
EXIT ;
 K DIR,DIROUT,DIRUT,DTOUT,DUOUT,X,Y
 K DIC,DIE,DJL,DJLIN,DJN,DJNM,DJSW2,DX,DY,XY
 K ENDA,ENEQ
 Q

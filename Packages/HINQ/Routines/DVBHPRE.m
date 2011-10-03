DVBHPRE ;ALB/JLU;Pre init for HINQ v4.0
 ;;V4.0;HINQ;;03/25/92 
EN ;
 I $D(DUZ)>10,$D(DUZ(0)),DUZ(0)="@"
 E  W !!,$C(7,7),?10,"DUZ must be set, DUZ(0) Must be set to @ !" K DIFQ Q
 ;
 ;Checks to see if version of HINQ was 3.2 or greater.
 S ^TMP("DVBHINQ")=$S($D(^DD(395,0,"VR")):^("VR"),1:"")
 ;Will ask if site wants to purge only keeping 7 days
P S DIR(0)="YA",DIR("A")="Do you wish to purge the HINQ Suspense file only keeping 7 days? " D ^DIR
 S ^TMP("DVBHINQPURGE")=$S(Y=1:"YES",1:"NO")
 ;sets compile routine size if inter systems.
S I ^%ZOSF("OS")["M/11" W !!!,"The compiled routines will need to be compiled at 2401.",!,"At the routine size input 2401 and return past the rest." D ^DIEZ
 Q

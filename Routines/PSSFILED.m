PSSFILED ;BIR/CML3-VARIOUS FILED UPKEEP ;09/15/97
 ;;1.0;PHARMACY DATA MANAGEMENT;**38,47**;9/30/97
 ;Reference to ^PSGGAO supported by DBIA #2148
 ;Reference to ^PSGSET supported by DBIA #2152
 ;Reference to ^PSGSETU supported by DBIA 2153
 ;Reference to ^PS(57.7 supported by DBIA 2111
 ;Reference to ^PS(59.6 supported by DBIA 2110
 ;Reference to ^PS(57.5 supported by DBIA 2112
 ;Reference to ^PS(53.2 supported by DBIA 2115
 ;
 ;This routine is no longer used, with the exception of the ENMI Line
 ;Tag. Quits were inserted at each sub-routine in Patch PSS*1*38. Later
 ;on, this routine should be deleted, and the code at ENMI needs to be
 ;moved somewhere, since that is being called by the PSSJU MI option.
DONE ;S X="PSGSETU" X ^%ZOSF("TEST") I  D ENKV^PSGSETU K D0,D1,D2,PSGRBS Q
 Q
 ;
GED ; generic edit
 ;S DA=+Y,DR=".01;1" W ! D ^DIE Q
 Q
 ;
ENAT ; team file
 Q
 ;F  S DIC="^PS(57.7,",DIC(0)="QEAMIL",DLAYGO=57.7,DIC("A")="Select WARD: " W ! D ^DIC K DIC,DLAYGO Q:Y'>0  S DA=+Y,DIE="^PS(57.7,",DR="[PSJUMATE]" D ^DIE
 G DONE
 ;
ENAS ; schedules file - no longer used
 ;F  S DIC="^PS(51.1,",DIC(0)="QEAMIL",DIC("W")="W ""   "",$P(^(0),""^"",2)",DLAYGO=51.1,DIC("DR")="4////PSJ" W ! D ^DIC K DIC,DLAYGO Q:+Y'>0  S DIE="^PS(51.1,",DR="[PSJUADE]",DA=+Y W ! D ^DIE
 Q
 ;
ENMR ; med route file
 Q
 N MRNO,MR K DIE,DIC,DR,Y
 S PSSOTH=$S($P($G(^PS(59.7,1,40.2)),"^"):1,1:0)
 F  S DIC="^PS(51.2,",DIC(0)="QEAMIL",DLAYGO=51.2 W ! D
 .D ^DIC K DIC,DLAYGO Q:+Y'>0  S MRNO=+Y,MR=$P(Y,U,2),DA=+Y,DIE="^PS(51.2,",DR=".01;1;3;4;S:'$G(PSSOTH) Y=""@1"";4.1;@1"
 .D ^DIE D DF
 K X,MRNO,MR,Y,DA,DR,PSSOTH,DIE
 Q
 ;
ENWG ; ward group file
 Q
 ;F  S DIC="^PS(57.5,",DIC(0)="QEAMIL",DLAYGO=57.5 W ! D ^DIC K DA,DIC,DR Q:+Y'>0  S DA=+Y,DIE="^PS(57.5,",DR="[PSJU WG]" D ^DIE
 G DONE
 ;
ENMI ; medication instruction file
 S PSSOTH=$S($P($G(^PS(59.7,1,40.2)),"^"):1,1:0)
 F  S DIC="^PS(51,",DIC(0)="QEAMIL",DLAYGO=51 W ! D ^DIC K DIC Q:+Y'>0  S DIE="^PS(51,",DA=+Y,DR=".01;.5;1;S:'$G(PSSOTH) Y=""@1"";1.1;@1;9;30;31" D ^DIE
 K DIC,DIE,DLAYGO,DA,DR,Y,PSSOTH
 Q
 ;
ENDRG ; standard drug fields
 Q
 D NOW^%DTC S PSGDT=% F  S DIC="^PSDRUG(",DIC(0)="AEIMOQ",DIC("A")="Select DISPENSE DRUG: " W ! D ^DIC K DIC Q:+Y'>0  D DE
 K PSIUA,PSIUDA,PSIUX G DONE
 ;
DE ;
 Q
 I $D(^PSDRUG(+Y,"I")),^("I"),^("I")<PSGDT W $C(7),$C(7),!!?3,"*** WARNING, THIS DRUG IS INACTIVE. ***",!
 ;W ! S DIE="^PSDRUG(",(DA,PSIUDA)=+Y,DR="[PSJ FILED]"
 S PSIUX="U^UNIT DOSE PHARMACY^1" D ^PSSGIU,^DIE:PSIUA'["^" K DA,DIE,DR Q
 ;
ENOSE ; order set enter/edit
 Q
 ;K DIC F  S DLAYGO=53.2,DIC="^PS(53.2,",DIC(0)="QEAML",DIC("A")="Select ORDER SET: " W ! D ^DIC K DIC Q:Y'>0  S DA=+Y S DIE="^PS(53.2,",DR="[PSJUOSE]" D ^DIE K D0,D1,DA,DIE,DR,PSGNEDFD,PSGS0XT,PSGS0Y
 G DONE
 ;
RBCHK ; used to validate room-bed
 Q
 ;F Z0=0:0 S Z0=$O(^PS(57.7,DA(2),1,Z0)) Q:'Z0  I Z0'=DA(1),$D(^(Z0,1,"B",X)) W !?19,X," is already under ",$S('$D(^PS(57.7,DA(2),1,Z0,0)):"another team ("_Z0_")!",$P(^(0),"^")]"":$P(^(0),"^")_"!",1:"another team ("_Z0_")!") Q
 I 'Z0,$D(^DIC(42,DA(2),2,+$O(^DIC(42,DA(2),2,"B",$P(X,"-"),0)),1,"B",$P(X,"-",2))) K Z0 Q
 K X,Z0 Q
 ;
RBQ ; show room-beds for a ward
 Q
 W !,"ANSWER WITH A ROOM-BED FROM THIS WARD ",$S('$D(^DIC(42,DA(1),0)):"",$P(^(0),"^")]"":" ("_$P(^(0),"^")_")",1:"") Q:'$D(^(0))  W !,"DO YOU WANT THE ENTIRE ROOM-BED LIST" S %=0 D YN^DICN Q:%'=1
 W ! S (Z0,Z3)=0 F Z1=0:0 S Z1=$O(^DIC(42,DA(1),2,Z1)) Q:'Z1  I $D(^(Z1,0)) S Z4=$P(^(0),"^") I Z4]"" F Z2=0:0 S Z2=$O(^DIC(42,DA(1),2,Z1,1,Z2)) Q:'Z2  I $D(^(Z2,0)),$P(^(0),"^")]"" S Z0=Z0+1 D:'(Z0#11) RBNP Q:Z3["^"  W ?1,Z4,"-",$P(^(0),"^"),!
 K Z0,Z1,Z2,Z3,Z4 Q
 ;
RBNP ;W """^"" TO STOP: " R Z3:DTIME W:'$T $C(7) S:'$T Z3="^" W *13,"            ",*13 Q
 Q
 ;
ENPPD ; edit pharmacy patient data
 Q
 ; W !!?3,"...This option is still under development...",! Q
 ;D ENCV^PSGSETU I $D(XQUIT) Q
 ;S PSGRETF=1 F  D ENDPT^PSGP Q:PSGP'>0  D ENHEAD^PSGO S DA=PSGP,DR="[PSJUPDE]",DIE="^PS(55," W ! D ^DIE
 ;K PSGRETF G DONE
 ;
ENCPDD ; edit patient's default stop date (wall)
 Q
 ;S X="PSGSETU" X ^%ZOSF("TEST") I  D ENCV^PSGSETU I $D(XQUIT) Q
 ;S X="PSGGAO" X ^%ZOSF("TEST") I  F  D ENAO^PSGGAO Q:PSGP'>0  D
 ;.S WDN=$P($G(^DPT(PSGP,.1)),"^") W:WDN="" !!?2,"The patient is not currently on a ward."
 ;.I WDN]"" S WD=$O(^DIC(42,"B",WDN,0)),WD=$O(^PS(59.6,"B",+WD,0)) I $S('WD:1,1:'$P($G(^PS(59.6,WD,0)),"^",4)) S X="PLEASE NOTE: The 'SAME STOP DATE' parameter for the ward ("_WDN_") is not turned on.  Any date entered here will be ignored "
 ;.I  S X=X_"until the parameter is turned on for this ward." W $C(7),!!?2 F Y=1:1:$L(X," ") S X(1)=$P(X," ",Y) W:$L(X(1))+$X>78 ! W X(1)," "
 ;.S DA=PSGP,DR="62.01T",DIE="^PS(55," W !! D ^DIE
 ;K WD,WDN G DONE
 ;
ENSYS ; edit system file
 Q
 S DIE="^PS(59.7,",DA=1,DR="21;26;26.2" W ! D ^DIE K DIE,DA,DR Q
 ;
ENPLSP ; edit pick list site parameters
 Q
 ;K DIC F Q=0:1 S DIC="^PS(59.4,",DIC(0)="QEAM" S:'Q DIC("B")=PSJSYSW W ! D ^DIC K DIC Q:Y'>0  S DA=+Y,DIE="^PS(59.4,",DR="[PSJUPLSP]" D ^DIE
 ;G DONE
 ;
ENCS ; change current site & parameters
 Q
 I $D(PSJSYSW0)#2 W !!,"Current site: ",$P(PSJSYSW0,"^")
 ;S PSGCSF=1 S X="PSGSET" X ^%ZOSF("TEST") I  D ^PSGSET,ENKV^PSGSETU W:$D(XQUIT) !!?5,"(The Inpatient site you are currently working under has not changed.)" K PSGCSF,PSGORSET,XQUIT Q
 ;
DF ; Add/edit Med route, instruction... to the Dosage form file.
 Q
 S DIR("A")="Would you like to update the Dosage Form file"
 S DIR("?")="If your answer is Yes, you will be able to Add/edit the Med routes, Instructions, Verb, Noun and Preposition that associate with this Dosage form."
 S DIR(0)="Y",DIR("B")="Y" D ^DIR Q:Y'=1
 NEW Y,DFNO K DIE,DIC,DA,DR
 F  S DIC="^PS(50.606,",DIC(0)="QEAMI" D ^DIC Q:+Y'>0  S DFNO=+Y D
 . I $G(MR)]"",'$D(^PS(50.606,DFNO,"MR","B",MRNO)) S DIE="^PS(50.606,",DR="1",DA=DFNO D ^DIE
 . K DIE,DIC,DR,MR S DIE="^PS(50.606,",DR="1;2;3;5;6",DA=DFNO D ^DIE
 Q

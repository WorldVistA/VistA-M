PSGFILED ;BIR/CML3-VARIOUS FILES' UPKEEP ;16 Mar 99 / 10:22 AM
 ;;5.0; INPATIENT MEDICATIONS ;**20,50,63,119,110,111,112,154,184,181**;16 DEC 97;Build 190
 ;
 ; Reference to ^PS(50.606 supported by DBIA# 2174.
 ; Reference to ^PSDRUG supported by DBIA# 2192.
 ; Reference to ^PS(59.7 is supported by DBIA# 2181.
 ; Reference to ^PS(51 is supported by DBIA# 2176.
 ; Reference to ^PS(51.2 is supported by DBIA# 2178.
 ; Reference to ^PS(55 is supported by DBIA# 2191.
 ;
DONE D ENKV^PSGSETU K D0,D1,D2,PSGRBS Q
 ;
GED ; generic edit
 S DA=+Y,DR=".01;1" W ! D ^DIE Q
 ;
ENAT ; team file
 F  S DIC="^PS(57.7,",DIC(0)="QEAMIL",DLAYGO=57.7,DIC("A")="Select WARD: " W ! D ^DIC K DIC,DLAYGO Q:Y'>0  S DA=+Y,DIE="^PS(57.7,",DR="[PSJUMATE]" D ^DIE
 G DONE
 ;
ENAS ; schedules file - no longer used
 ;
ENMR ; med route file
 NEW MRNO,MR K DIE,DIC,DR,Y
 F  S DIC="^PS(51.2,",DIC(0)="QEAMIL",DLAYGO=51.2 W ! D ^DIC K DIC,DLAYGO Q:+Y'>0  S MRNO=+Y,MR=$P(Y,U,2),DA=+Y,DIE="^PS(51.2,",DR=".01;1;3;4" D ^DIE D DF
 G DONE
 ;
ENWG ; ward group file
 F  S DIC="^PS(57.5,",DIC(0)="QEAMIL",DLAYGO=57.5 W ! D ^DIC K DA,DIC,DR Q:+Y'>0  S DA=+Y,DIE="^PS(57.5,",DR="[PSJU WG]" D ^DIE
 G DONE
 ;
ENMI ; medication instruction file
 F  S DIC="^PS(51,",DIC(0)="QEAMIL",DLAYGO=51 W ! D ^DIC K DIC Q:+Y'>0  S DIE="^PS(51,",DA=+Y,DR=".01;1;30" D ^DIE
 G DONE
 ;
ENDRG ; standard drug fields
 D NOW^%DTC S PSGDT=% F  S DIC="^PSDRUG(",DIC(0)="AEIMOQ",DIC("A")="Select DISPENSE DRUG: " W ! D ^DIC K DIC Q:+Y'>0  D DE
 K PSIUA,PSIUDA,PSIUX G DONE
 ;
DE ;
 I $D(^PSDRUG(+Y,"I")),^("I"),^("I")<PSGDT W $C(7),$C(7),!!?3,"*** WARNING, THIS DRUG IS INACTIVE. ***",!
 W ! S DIE="^PSDRUG(",(DA,PSIUDA)=+Y,DR="[PSJ FILED]"
 S PSIUX="U^UNIT DOSE PHARMACY^1" D ^PSGIU,^DIE:PSIUA'["^" K DA,DIE,DR Q
 ;
ENOSE ; order set enter/edit
 K DIC F  S DLAYGO=53.2,DIC="^PS(53.2,",DIC(0)="QEAML",DIC("A")="Select ORDER SET: " W ! D ^DIC K DIC Q:Y'>0  S DA=+Y S DIE="^PS(53.2,",DR="[PSJUOSE]" D ^DIE K D0,D1,DA,DIE,DR,PSGNEDFD,PSGS0XT,PSGS0Y
 G DONE
 ;
RBCHK ; used to validate room-bed
 ;No longer used.
 ;F Z0=0:0 S Z0=$O(^PS(57.7,DA(2),1,Z0)) Q:'Z0  I Z0'=DA(1),$D(^(Z0,1,"B",X)) W !?19,X," is already under ",$S('$D(^PS(57.7,DA(2),1,Z0,0)):"another team ("_Z0_")!",$P(^(0),"^")]"":$P(^(0),"^")_"!",1:"another team ("_Z0_")!") Q
 ;I 'Z0,$D(^DIC(42,DA(2),2,+$O(^DIC(42,DA(2),2,"B",$P(X,"-"),0)),1,"B",$P(X,"-",2))) K Z0 Q
 ;K X,Z0 Q
 ;
RBQ ; show room-beds for a ward
 ;No longer used.
 Q
 ;
RBNP W """^"" TO STOP: " R Z3:DTIME W:'$T $C(7) S:'$T Z3="^" W $C(13),"            ",$C(13) Q
 ;
ENPPD ; edit pharmacy patient data
 ; W !!?3,"...This option is still under development...",! Q
 ;
ENCPDD ; edit patient's default stop date (wall)
 D ENCV^PSGSETU I $D(XQUIT) Q
 F  D ENAO^PSGGAO Q:PSGP'>0  D
 .S WDN=$P($G(^DPT(PSGP,.1)),"^") W:WDN="" !!?2,"The patient is not currently on a ward."
 .I WDN]"" S WD=$O(^DIC(42,"B",WDN,0)),WD=$O(^PS(59.6,"B",+WD,0)) I $S('WD:1,1:'$P($G(^PS(59.6,WD,0)),"^",4)) S X="PLEASE NOTE: The 'SAME STOP DATE' parameter for the ward ("_WDN_") is not turned on.  Any date entered here will be ignored "
 .I  S X=X_"until the parameter is turned on for this ward." W $C(7),!!?2 F Y=1:1:$L(X," ") S X(1)=$P(X," ",Y) W:$L(X(1))+$X>78 ! W X(1)," "
 .S DA=PSGP,DR="62.01T",DIE="^PS(55," W !! D ^DIE
 K WD,WDN G DONE
 ;
ENSYS ; edit system file
 ;/S DIE="^PS(59.7,",DA=1,DR="21;26;26.3;26.4;26.2;20.412ALLOW THE CHANGE OF ORDER TYPES ON ORDERS FROM OERR;32"
 S DIE="^PS(59.7,",DA=1,DR="21;26;26.3;26.4;26.2;26.5;26.6;26.7;26.8;34;27;27.1"
 W ! D ^DIE K DIE,DA,DR Q
 ;
ENPLSP ; edit pick list site parameters
 ;
ENCS ; change current site & parameters
 I $D(PSJSYSW0)#2 W !!,"Current site: ",$P(PSJSYSW0,"^")
 S PSGCSF=1 D ^PSGSET,ENKV^PSGSETU W:$D(XQUIT) !!?5,"(The Inpatient site you are currently working under has not changed.)" K PSGCSF,PSGORSET,XQUIT Q
 ;
DF ; Add/edit Med route, instruction... to the Dosage form file.
 S DIR("A")="Would you like to update the Dosage Form file"
 S DIR("?")="If your answer is Yes, you will be able to Add/edit the Med routes, Instructions, Verb, Noun and Preposition that associate with this Dosage form."
 S DIR(0)="Y",DIR("B")="Y" D ^DIR Q:Y'=1
 NEW Y,DFNO K DIE,DIC,DA,DR
 F  S DIC="^PS(50.606,",DIC(0)="QEAMI" D ^DIC Q:+Y'>0  S DFNO=+Y D
 . I $G(MR)]"",'$D(^PS(50.606,DFNO,"MR","B",MRNO)) S DIE="^PS(50.606,",DR="1///"_MR,DA=DFNO D ^DIE
 . K DIE,DIC,DR,MR S DIE="^PS(50.606,",DR="1;3;4;5",DA=DFNO D ^DIE
 ;. K DIE,DIC,DR,MR S DIE="^PS(50.606,",DR="1;2;3;4;5",DA=DFNO D ^DIE
 Q
ENCD ;edit Clinic Definitions file
 F  K DIC S DIC="^PS(53.46,",DIC(0)="AELMQ",DIC("A")="Select CLINIC: ",DLAYGO=53.46 D ^DIC K DIC Q:Y<0  D
 . S DIE="^PS(53.46,",DA=+Y,DR="1;2;3" D ^DIE K DIE,DA,DR Q
 Q
ENCG ; ward group file0
 F  S DIC="^PS(57.8,",DIC(0)="QEAMIL",DLAYGO=57.8 W ! D ^DIC K DA,DIC,DR Q:+Y'>0  S DA=+Y,DIE="^PS(57.8,",DR=".01;1" D ^DIE
 G DONE
 ;

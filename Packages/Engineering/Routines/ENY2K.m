ENY2K ;;(WIRMFO)/DH-Equipment Y2K Management ;5.18.98
 ;;7.0;ENGINEERING;**51**;August 17, 1993
 ;
 ; This module identifies individual pieces of equipment that may fail
 ;   to operate properly as of January 1, 2000.
 ; It also provides a means (the Y2K worklist) of tracking the
 ;   necessary corrective actions.
 ;
IND ; data entry for manually selected equipment list
 K ^TMP($J)
 N DIC,ENY2K,ESCAPE,COUNT
 S COUNT=0
 W !!,"First we'll get answers for the Y2K questions, then we'll ask for an",!,"equipment list.",!
 D DATA^ENY2K1
 G:$G(ESCAPE) EXIT
 F J="PRE","FC","NC","CC","NA" S COUNT(J)=0
 S DIC="^ENG(6914,",DIC(0)="AEQM"
 F  D GETEQ^ENUTL Q:Y'>0  D:$D(^ENG(6914,+Y,0))
 . Q:$D(^TMP($J,+Y))
 . I "^4^5^"[(U_$P($G(^ENG(6914,+Y,3)),U)_U) W !,?5,"Sorry, but "_+Y_" is not an active equipment record." Q
 . S X=$P($G(^ENG(6914,+Y,11)),U) I X]"" S COUNT("PRE")=COUNT("PRE")+1,COUNT(X)=COUNT(X)+1,^TMP($J,X,+Y)=""
 . S ^TMP($J,+Y)="",COUNT=COUNT+1
 D:$D(^TMP($J))
 . W !!,"You have selected "_COUNT_" equipment records for updating."
 . W !,"Do you wish to proceed?"
 . S DIR(0)="Y",DIR("B")="YES"
 . D ^DIR K DIR Q:$D(DIRUT)!('Y)
 . D:COUNT("PRE") OVERWRT^ENY2K8
 . D:'$G(ESCAPE) UPDATE^ENY2K1
 G EXIT
 ;
CAT ; data entry by EQUIPMENT CATEGORY
 N CAT,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE
 F  D CAT1 D  Q:$G(ESCAPE)
 . I $G(ESCAPE),$G(CAT)]"" L -^ENG("CAT",CAT)
 . Q:$G(ESCAPE)
 . D:$G(ENY2K("CONT")) DATA^ENY2K1
 . I $G(ESCAPE) L -^ENG("CAT",CAT) Q
 . D UPDATE^ENY2K1
 . L -^ENG("CAT",CAT) S CAT="",CAT(0)=""
 G EXIT
 ;
CAT1 K ^TMP($J) W !
 S DIC="^ENG(6911,",DIC(0)="AEMQ" D ^DIC I Y'>0 S ESCAPE=1 Q
 S CAT=$P(Y,U,2),CAT(0)=$P(Y,U)
 L +^ENG("CAT",CAT):1 I '$T W !,"Another user is editing this equipment category. Can't proceed." S CAT="",CAT(0)="" G CAT1
 F J="PRE","FC","NC","CC","NA" S COUNT(J)=0
 S (DA,COUNT)=0 F  S DA=$O(^ENG(6914,"G",CAT(0),DA)) Q:'DA  D
 . I $D(^ENG(6914,DA,0)),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)="",X=$P($G(^ENG(6914,DA,11)),U) I X]"" S COUNT("PRE")=COUNT("PRE")+1,COUNT(X)=COUNT(X)+1,^TMP($J,X,DA)=""
 I 'COUNT W !!,"There are no active equipment records in the EQUIPMENT CATEGORY of",!,CAT_"." L -^ENG("CAT",CAT) S CAT="",CAT(0)="" G CAT1
 W !!,"There are "_COUNT_" active equipment records in the "_CAT,!,"EQUIPMENT CATEGORY. Do you wish to proceed?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("CONT")=Y I 'ENY2K("CONT") L -^ENG("CAT",CAT) S CAT="",CAT(0)="" G CAT1
 I COUNT("PRE"),'$D(CRITER) D OVERWRT^ENY2K8
 Q
 ;
CSN ; data entry by CATEGORY STOCK NUMBER
 N CSN,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE
 F  D CSN1 D  Q:$G(ESCAPE)
 . I $G(ESCAPE),$G(CSN)]"" L -^ENG("CSN",CSN)
 . Q:$G(ESCAPE)
 . D:$G(ENY2K("CONT")) DATA^ENY2K1
 . I $G(ESCAPE) L -^ENG("CSN",CSN) Q
 . D UPDATE^ENY2K1
 . L -^ENG("CSN",CSN) S CSN="",CSN(0)=""
 G EXIT
 ;
CSN1 K ^TMP($J) W !
 S DIC="^ENCSN(6917,",DIC(0)="AEQM" D ^DIC I Y'>0 S ESCAPE=1 Q
 S CSN=$P(Y,U,2),CSN(0)=$P(Y,U)
 L +^ENG("CSN",CSN):1 I '$T W !,"Another user is editing this CATEGORY STOCK NUMBER. Can't proceed." S CSN="",CSN(0)="" G CSN1
 F J="PRE","FC","NC","CC","NA" S COUNT(J)=0
 S (DA,COUNT)=0 F  S DA=$O(^ENG(6914,"J",CSN(0),DA)) Q:'DA  D
 . I $D(^ENG(6914,DA,0)),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)="",X=$P($G(^ENG(6914,DA,11)),U) I X]"" S COUNT("PRE")=COUNT("PRE")+1,COUNT(X)=COUNT(X)+1,^TMP($J,X,DA)=""
 I 'COUNT W !!,"There are no active equipment records whose CATEGORY STOCK NUMBER is",!,CSN_"." S CSN="",CSN(0)="" G CSN1
 W !!,"There are "_COUNT_" active equipment records whose CATEGORY STOCK ",!,"NUMBER is "_CSN_". Do you wish to proceed?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("CONT")=Y I 'ENY2K("CONT") L -^ENG("CSN",CSN) S CSN="",CSN(0)="" G CSN1
 I COUNT("PRE"),'$D(CRITER) D OVERWRT^ENY2K8
 Q
 ;
MFG ; data entry by MANUFACTURER (all models)
 N MFG,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE
 F  D MFG1 D  Q:$G(ESCAPE)
 . I $G(ESCAPE),$G(MFG)]"" L -^ENG("MFG",MFG)
 . Q:$G(ESCAPE)
 . D:$G(ENY2K("CONT")) DATA^ENY2K1
 . I $G(ESCAPE) L -^ENG("MFG",MFG) Q
 . D UPDATE^ENY2K1
 . L -^ENG("MFG",MFG) S MFG="",MFG(0)=""
 G EXIT
 ;
MFG1 K ^TMP($J)
 S DIC="^ENG(""MFG"",",DIC(0)="AEMQ" D ^DIC I Y'>0 S ESCAPE=1 Q
 S MFG=$P(Y,U,2),MFG(0)=$P(Y,U)
 L +^ENG("MFG",MFG):1 I '$T W !,"Another user is editing this MANUFACTURER. Can't proceed." S MFG="",MFG(0)="" G MFG1
 F J="PRE","FC","NC","CC","NA" S COUNT(J)=0
 S (DA,COUNT)=0 F  S DA=$O(^ENG(6914,"K",MFG(0),DA)) Q:'DA  D
 . I $D(^ENG(6914,DA,0)),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)="",X=$P($G(^ENG(6914,DA,11)),U) I X]"" S COUNT("PRE")=COUNT("PRE")+1,COUNT(X)=COUNT(X)+1,^TMP($J,X,DA)=""
 I 'COUNT W !!,"There are no active equipment entries manufactured by "_MFG_"." L -^ENG("MFG",MFG) S MFG="",MFG(0)="" G MFG1
 W !!,"There are "_COUNT_" equipment entries that were manufactured by",!,MFG_". Do you wish to proceed?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("CONT")=Y I 'ENY2K("CONT") L -^ENG("MFG",MFG) S MFG="",MFG(0)="" G MFG1
 I COUNT("PRE"),'$D(CRITER) D OVERWRT^ENY2K8
 Q
 ;
LOC ; data entry by LOCAL ID
 N LOC,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE,PAGE,DATE
 F  D LOC1^ENY2K9 D  Q:$G(ESCAPE)
 . I $G(ESCAPE),$G(LOC)]"" L -^ENG("LOC",LOC)
 . Q:$G(ESCAPE)
 . D:$G(ENY2K("CONT")) DATA^ENY2K1
 . I $G(ESCAPE) L -^ENG("LOC",LOC) Q
 . D UPDATE^ENY2K1
 . L -^ENG("LOC",LOC) S LOC="",LOC(0)="",END=""
 G EXIT
 ;
MOD ; data entry by MANUFACTURER and MODEL
 N MFG,MOD,DIC,DIE,DA,DR,COUNT,ENY2K,ESCAPE,ENDX
 F  D MOD1 D  Q:$G(ESCAPE)
 . I $G(ESCAPE),$G(MFG)]"" L -^ENG("MFG","MOD",MFG,MOD)
 . Q:$G(ESCAPE)
 . D:$G(ENY2K("CONT")) DATA^ENY2K1
 . I $G(ESCAPE) L -^ENG("MFG","MOD",MFG,MOD)
 . D UPDATE^ENY2K1
 . L -^ENG("MFG","MOD",MFG,MOD) S (MFG,MOD)="",MFG(0)=""
 G EXIT
 ;
MOD1 K ^TMP($J) W !
 S DIC="^ENG(""MFG"",",DIC(0)="AEQM" D ^DIC I Y'>0 S ESCAPE=1 Q
 S MFG=$P(Y,U,2),MFG(0)=$P(Y,U)
 I '$O(^ENG(6914,"K",MFG(0),0)) W !!,"There are no active equipment records for devices made by",!,MFG_"." S MFG="",MFG(0)="" G MOD1
MOD2 R !,"Please enter the MODEL (as recorded in Equipment File): ",X:DTIME I '$T!($E(X)="^")!(X="") S ESCAPE=1,MFG="",MFG(0)="" Q
 I $E(X)="?" W !,"Enter a valid MODEL number (ex: "_$O(^ENG(6914,"E","M"))_")." G MOD2
 I '$D(^ENG(6914,"E",X)) D  I X="" W "??",*7 G MOD2
 . S DIC="^ENG(6914,",ENDX="E"
 . D IX^ENLIB1
 S MOD=X
 L +^ENG("MFG","MOD",MFG,MOD):1 I '$T W !,"Another user is editing this MANUFACTURER~MODEL. Can't proceed." S (MFG,MOD)="",MFG(0)="" G MOD1
 F J="PRE","FC","NC","CC","NA" S COUNT(J)=0
 S (DA,COUNT)=0 F  S DA=$O(^ENG(6914,"E",MOD,DA)) Q:'DA  D
 . I $D(^ENG(6914,DA,0)),$P($G(^(1)),U,4)=MFG(0),"^4^5^"'[(U_$P($G(^(3)),U)_U) S COUNT=COUNT+1,^TMP($J,DA)="",X=$P($G(^ENG(6914,DA,11)),U) I X]"" S COUNT("PRE")=COUNT("PRE")+1,COUNT(X)=COUNT(X)+1,^TMP($J,X,DA)=""
 I 'COUNT W !!,"There are no active equipment records for which MANUFACTURER and MODEL are",!,MFG_" and "_MOD_", respectively." L -^ENG("MFG","MOD",MFG,MOD) S (MFG,MOD)="",MFG(0)="" G MOD1
 W !!,"There are "_COUNT_" active equipment records that meet your search criteria.",!,"Do you wish to proceed?"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR K DIR I $D(DIRUT) S ESCAPE=1 Q
 S ENY2K("CONT")=Y I 'ENY2K("CONT") L -^ENG("MFG","MOD",MFG,MOD) S (MFG,MOD)="",MFG(0)="" G MOD1
 I COUNT("PRE"),'$D(CRITER) D OVERWRT^ENY2K8
 Q
 ;
EXIT K ^TMP($J)
 Q
 ;ENY2K

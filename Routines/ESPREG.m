ESPREG ;DALISC/CKA- EDIT REGISTRATION PROGRAM ;5/91
 ;;1.0;POLICE & SECURITY;;Mar 31, 1994
EN ;
 S DIR(0)="910.2,.04" D ^DIR K DIR G:$D(DIRUT) EXIT S ESPRT=$S($D(Y(0)):Y(0),X'?1N:X,1:""),ESPRT(1)=+Y
NAM W ! S DIR(0)="P^910:EMZ" D ^DIR K DIR G:$D(DIRUT) EXIT S ESPFN=+Y,ESPNAM=$P(Y,U,2) D REG G ESPREG
 ;
REG S DIR(0)="FO:1:30",DIR("A")="Select VA TAG ID",DIR("?")="^S D=""B"",DZ=""??"",DIC=""^ESP(910.2,"",DIC(0)=""AEQZ"",DIC(""S"")=""I $P(^(0),U,4)=ESPRT(1)&($P(^(0),U,3)=ESPFN)"" D DQ^DICQ K DIC" D ^DIR K DIR G:'Y EXIT
 S DIC="^ESP(910.2,",DIC("S")="I $P(^(0),""^"",4)=ESPRT(1)",DIC(0)="E" D ^DIC K DIC G:Y'>0 MES S ESPY=Y I '$D(^ESP(910.2,+Y,0)) W !!,"Invalid selection made...try again please!",$C(7) G REG
DISPLAY ;Show the record to be edited
 S DIC="^ESP(910.2,",DA=+ESPY D EN^DIQ
EDIT ;
 L +^ESP(910.2,+ESPY):0 E  W !!?5,"Record is in use.  Try later.",!,$C(7) G REG
 S DIE="^ESP(910.2,",DA=+ESPY,DR=".01DECAL NO.;.02:.07",DR=DR_";"_$P($T(DR+ESPRT(1)),";;",2) D ^DIE L -^ESP(910.2,+ESPY) K DR,DIE G:'$D(ESPVAR) REG G EXIT
 ;
DR ;
 ;;1.01:1.09;20
 ;;4.01:4.05;20
 ;;2.01:2.08;20
 ;;3.01:3.08;20
 ;;5.02;20
 ;;10;5;20
EXIT W:$D(DTOUT) $C(7)
 K ESPNAM,ESPRT,ESPRTD,ESPY QUIT
MES ;
 I ESPRT(1)=1 W !,$C(7),ESPNAM," does not have a vehicle registered with this decal." E  W !,$C(7),ESPNAM," does not have this va tag id."
 G REG

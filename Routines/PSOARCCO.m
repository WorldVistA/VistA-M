PSOARCCO ;BHAM ISC/LGH - find rxs that to be archived ; 07/07/92
 ;;7.0;OUTPATIENT PHARMACY;**268**;DEC 1997;Build 9
 S X1=DT,X2=-121 D C^%DTC S %DT(0)=-X
AC S PSOAPG=1,PG=1,X2=-360,X1=DT D C^%DTC S Y=X X ^DD("DD") S %DT("B")=Y
 L +^PSOARC:$S(+$G(^DD("DILOCKTM"))>0:+^DD("DILOCKTM"),1:3) I '$T W !!,"Archive global locked by another user!",! K PSOALAST,PSOAC,Y,PSOAPG Q 
 W !! S %DT("A")="Archive all scripts which expired on or before: "
DT S %DT="AEXP" D ^%DT G:Y=-1 EXIT S PSOAC=Y
ST G:$D(PSOACRS) RST^PSOARCSV
 S LC=0,LC=$O(^PSOARC(LC)) I $G(LC) W !!,"WARNING!!  There are entries in the ",$P(^PSOARC(0),"^")," file!",! S DIR("?")="^D STQ^ZPSOARCC"
 I $G(LC) S DIR("A")="Do you want to delete these entries ",DIR(0)="YO",DIR("B")="No" D ^DIR G:$D(DIRUT)!('Y) EXIT
 D:$G(LC) KILLARC W !!,"Collecting Rx Information",!
 S ZI=0 F J=1:1 S ZI=$O(^PSRX(ZI)) Q:+ZI'>0  I $D(^PSRX(ZI,0)),$P($G(^(2)),"^",6)]"",$P($G(^(2)),"^",6)'>PSOAC,$P(^(0),"^",2)'="" D COLLECT W "."
 S LC=0,LC=$O(^PSOARC(LC))
 W !!,$S($G(LC):"I'm finished finding things!!",1:"I didn't find anything!!"),$C(7) G EXIT
 ;
COLLECT S PSDFN=+$P(^PSRX(ZI,0),"^",2) I '$D(^DPT(PSDFN,0))#2 Q
 S SSN=$P(^DPT(PSDFN,0),"^",9) Q:SSN=""  S $P(^PSOARC(0),"^",4)=($P(^PSOARC(0),"^",4)+1),$P(^PSOARC(0),"^",3)=ZI
 S ^PSOARC(ZI,0)=ZI_"^"_PSDFN,^PSOARC("B",$P(^DPT(PSDFN,0),"^"),SSN,ZI)="",^PSOARC("C",PSDFN,ZI)=""
 Q
KILLARC ;delete all entries in ^PSOARC
 S DIK="^PSOARC(",DA=0 F  S DA=$O(^PSOARC(DA)) Q:'DA   D ^DIK
 K ^PSOARC("B"),^PSOARC("C"),DA,DIK
 Q
STQ W !,"The entries that are currently in the file should probably be archived before",!,"continuing.  Use the archive 'SAVE' option to write the entries to file or"
 W !,"tape and then return to this option.  If you delete the entries now, this"
 W !,"archive 'FIND' option will re-enter them and then you should use the 'SAVE'",!,"option to archive them.",!
 Q
CONT S DIR("A")="Do you want to continue? ",DIR(0)="Y",DIR("T")=DTIME D ^DIR K DIR G:'Y EXIT ;G:Y EN01^PSOARCS1
 ;
EXIT K PSABS,PSOAC,PSOACP,PSOACT,PSOAF,PSOAM,PSOAPAR,PSOAT,IOP,PSOACPF,X,X1,X2,Y,PSOACPL,PSOACPM,PSPRNP,RFDATE,RFL,RM,ST,ST0,PSOACRS,PSPRCNT,RFL1,PSOAPG,PSOAP,D,J,K,PG,PSDFN,SSZ,Z,ZI,DIR,PSOAC1,%DT,PSOALAST,LC
 K DIRUT,DUOUT,DTOUT
 L -^PSOARC
 Q 

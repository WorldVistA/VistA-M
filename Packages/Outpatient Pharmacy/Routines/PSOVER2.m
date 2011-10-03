PSOVER2 ;BHAM ISC/SAB - edit and/or discontinue unverified rx's ;07/03/95 9:32
 ;;7.0;OUTPATIENT PHARMACY;**131,251**;DEC 1997;Build 202
 ;Reference ^PSDRUG( supported by DBIA 221
 S DIR("B")="C",DIR("A")="Do you want to DELETE or EDIT Rx # "_$P(^PSRX(PSONV,0),"^")_" or Discontinue "_$P(DUPRX0,"^")_" ",DIR("?",1)="This is a duplicate drug.  Your options are to :"
 S DIR("?",2)="   (1) - Discontinue the old Rx ("_$P(DUPRX0,"^")_")",DIR("?",3)="   (2) - DELETE this Rx ("_$P(^PSRX(PSONV,0),"^")_")"
 S DIR("?",4)="or (3) - EDIT this Rx ("_$P(^PSRX(PSONV,0),"^")_")",DIR("?")="You MUST select one of the 3 actions!"
 S DIR(0)="SA^1:DISCONTINUE;2:DELETE;3:EDIT" D ^DIR K DIR G CANOLD^PSOVERC:Y=1,DELETE:Y=2,CHANGE:Y=3,QUIT^PSOVER1:"123"'[$E(Y)
CHANGE S DA=PSONV,PSDOLD=DRGG,GOOF=0,(PSRX1,PSRX2)=$P(^PSRX(PSONV,0),"^",6)
 S DIE="^PSRX(",DR="@1;3;S PSRX1=$P(D,""^"",6);6;S PSRX2=X D:PSRX1=PSRX2 MUST^PSOVER2 D:PSRX1'=PSRX2 NO^PSOVER2;10;7;8;9;4;5;12;1;22;11;"_$S($P(PSOPAR,"^",12):"35;",1:"")_$S($P(PSOPAR,"^",15):"10.6",1:"")_";@2" D ^DIE
 I GOOF=1 S DR="6////"_PSRX1 D ^DIE G PSOVER2
 I GOOF=2 G PSOVER2
 K DIE,DR,DEA1,DEA2,PSRX1,PSRX2,GOOF G REDO^PSOVER1
 ;
NO ;called by `dr strings' at change+1^psover2 and at change^psover1
 I $P($G(^PSDRUG(PSRX1,2)),"^")'=$P($G(^PSDRUG(PSRX2,2)),"^") D  G OITEM
 .W !!,"You MUST select a drug with the same Orderable Item!",! K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
 S DEA1=$P(^PSDRUG(PSRX1,0),"^",3)["A",DEA2=$P(^PSDRUG(PSRX2,0),"^",3)["A"
 I DEA1&DEA2!('DEA1&'DEA2) Q
 W !,$C(7),?12,"You CANNOT change a "_$S(DEA1:"",1:"NON-")_"Narcotic Drug to a "_$S(DEA2:"",1:"Non-"),"Narcotic Drug",!?13,"You must discontinue this prescription and enter a new one",!
 W ?5,"Use the DELETE option rather than the EDIT option on this prescription",!!,$C(7) K DIR S DIR(0)="E",DIR("A")="Press RETURN to continue" D ^DIR K DIR
OITEM S Y="@2",GOOF=1 Q
 ;
MUST ;called by `dr string' at change+1^psover2
 W !!!,$C(7),"This is a duplicate drug for an existing prescription",!!,"You MUST either CHANGE the drug in this prescription",!,?16,"DELETE this prescription",!,?13,"or DISCONTINUE the existing prescription",!!,$C(7) S Y="@2",GOOF=2 Q
 ;
DELETE ;
 I '$G(DRG) S DRG=$P(^PSRX(PSONV,0),"^",6)
 D NOOR^PSOCAN4 I $D(DIRUT) D DR Q
 K PSD(DRG_"^"_PSONV) S DA=PSONV I $G(PKI1) D DCV^PSOPKIV1 G:$D(PKIR) KILL D DR Q
 D ENQ^PSORXDL
KILL S DA=PSONV,DIK="^PS(52.4," D ^DIK K DA,DIK
 K Z,Z1,Z2,PSOKL,PSOKL1,PSOKL2,PSOKL3,PSOKL6,PSOKL7,PSONOOR,DA
 Q
DR W $C(7)," ACTION NOT TAKEN!",!
 K DIR S DIR(0)="E",DIR("A")="Press Return to Continue" D ^DIR K DIR
 S UPFLAGX=1 Q
 ;

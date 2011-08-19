PSXLBL ;BIR/HTW,BAB-CMOP Host Label Print..User Input ; [ 05/01/97  11:47 AM ]
 ;;2.0;CMOP;**1**;11 Apr 97
START ;
 L +^PSX(553):1 I '$T D MSG Q
 I ^PSX(553,1,"S")="R" D MSG Q
 G:'$D(^PSX(554,"AB")) SS
 S R554=$O(^PSX(554,"AB",""))
 I $P($G(^PSX(554,1,1,R554,0)),"^",4)="R" S ZH="F" D MSG Q
SS I ^PSX(553,1,"S")="S" S ^PSX(553,1,"P")="R"
 L -^PSX(553)
SS1 W @IOF,!
SS2 S DIC=552.1,DIC(0)="AEQMZ",DIC("A")="Print Facility-Batch #: "
 I $G(REPRINT) S DIC("S")="I $P(^(0),U,2)=""3""",PSXREF="AP" G ENTER
 I $G(REJECT) S DIC("S")="I $P(^(0),U,2)'=""2""",PSXREF="AR" G ENTER
 S DIC("S")="I $P(^(0),U,2)=""2""",PSXREF="AQ"
ENTER D ^DIC K DIC I $D(DUOUT)!($D(DTOUT))!(""[X)!(X["^") G END
 S BATREF=($P(Y,U,2)),N514=+Y K X,Y,DIC
 I $D(^PSX(552.1,"APR",BATREF)) W !!,"BATCH "_BATREF_" is currently being printed.",!,"Please select another batch or ""^"" to exit.",!! K N514,X,Y,DIC G SS2
 I $G(REPRINT) D  K J,N G CHECK
 .S N="",(J,PSXBEG,PSXEND)=0
 .F  S N=$O(^PSX(552.2,"AP",N)) Q:($G(N)']"")  I N[BATREF D
 ..F J=0:0 S J=$O(^PSX(552.2,"AP",N,J)) Q:'J  D
 ...S:J>PSXEND PSXEND=J S:PSXBEG=0 PSXBEG=J
 I $D(^PSX(552.2,PSXREF,BATREF)) S (PSXBEG,X)=0 F  S X=$O(^PSX(552.2,PSXREF,BATREF,X)) Q:'X  S:PSXBEG=0 PSXBEG=X S PSXEND=X
CHECK I '$G(PSXBEG)!('$G(PSXEND)) S ^PSX(553,1,"P")="S" W !!,"No data to "_$S($G(REPRINT):"reprint",1:"print")_" for CMOP Msg # ",BATREF,".  Select another batch.",! H 3 G START
 K X D DEVICE
END S ^PSX(553,1,"P")="S"
 K PSXBEG,PSXEND,BATREF,Z,ER,NTE,Q,V,C,ZZ,Z,X,Y,G,A,CT,CH1,L,PSXST
 K ZY,IEN14,CNT,R554,DUOUT,DTOUT,DIRUT,DIROUT,N514
 K PSXLAP,PSXREF,REPRINT,PSXBLR,POP,PSXBAR,PSXIOS,REJECT
 Q
DEVICE W !! S %ZIS="MNQ",%ZIS("A")="Select Label Printer: ",%ZIS("B")=""
 D ^%ZIS K %ZIS,IO("Q"),IOP G:POP END I $E(IOST,1,2)["C-" W !,"You must choose a printer or ""^"" to exit" G DEVICE
 S PSXLAP=ION D PSET^%ZISP I $G(IOBARON)]"" S PSXBAR=1,PSXIOS=IOS
 D ^%ZISC K J,C
TOF S DIR("A")="OK TO ASSUME LABEL ALIGNMENT IS CORRECT ?"
 S DIR("B")="YES",DIR(0)="SB^Y:YES;N:NO",DIR("?")="Enter Y if labels are OK, N if they need to be aligned."
 D ^DIR K DIR G:$D(DIRUT) END
 G:("Yy"[$E(Y)) QUE
P2 S IOP=$G(PSXLAP) D ^%ZIS K IOP I POP W !?5,"PRINTER IS BUSY. " G TOF
 U IO(0) W !,"ALIGN LABELS SO THAT A PERFORATION IS AT THE TOP OF THE"
 W !,"PRINT HEAD AND THE LEFT SIDE IS AT COLUMN ZERO."
 R !,"PRESS RETURN WHEN READY:",X:DTIME Q:"^"=X!'$T  D PTEST^PSXLBLPT D ^%ZISC
 S DIR("A")="IS THIS CORRECT ?",DIR("B")="YES"
 S DIR(0)="SB^Y:YES;N:NO",DIR("?")="Enter Y if labels are OK, N if they need to be aligned."
 D ^DIR K DIR G:$D(DIRUT) END
 K DIR G:("Yy"[$E(Y)) QUE
 G P2
QUE S ZTSAVE("PSXBEG")="",ZTSAVE("PSXEND")="",ZTSAVE("BATREF")=""
 S ZTSAVE("PSXBAR")="",ZTSAVE("REPRINT")=""
 S ZTSAVE("N514")="",ZTIO=PSXLAP,ZTSAVE("RESET")="",ZTSAVE("PSXREF")=""
 S ZTSAVE("PSXBLR")="",ZTSAVE("IOBARON")="",ZTSAVE("IOBAROFF")=""
 S ZTRTN="^PSXLBL1",ZTDESC="CMOP Host Label Print" D ^%ZTLOAD
Q1 W:$D(ZTSK) !!,"LABELS Queued to Print!!"
 Q
MSG W !!,"Labels may NOT be printed while the CMOP "_$S($G(ZH)="F":"Background Filer ",1:"Interface ")_"is running.",!!,"Please try again later...",!! L -^PSX(553)
 K ZH
 Q
REPRINT S REPRINT=1 G START
REJECT S REJECT=1 G START

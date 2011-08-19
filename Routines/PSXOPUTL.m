PSXOPUTL ;BIR/HTW-Utility for Hold/Can ;[ 04/08/97   2:06 PM ]
 ;;2.0;CMOP;;11 Apr 97
 ;Required input:  DA - internal entry # -  ^PSRX
 ;Returns:
 ;PSXZ("L")=LAST FILL... if it is orig Rx =0
 ;PSXZ(FILL #)=CMOP status from 52...Trans/0,DISP/1,RETRAN/2,NOT DISP/3
 ;If suspended PSXZ("S")=CMOP suspense status Q,L,X,P,R
 ;All returned variables can be killed by K PSXZ
 ;
 N X
 S (PSXZ("L"),X)=0  F  S X=$O(^PSRX(DA,1,X)) Q:'X  S PSXZ("L")=X
 I $O(^PSRX(DA,4,0)) F X=0:0 S X=$O(^PSRX(DA,4,X)) Q:'X  D
 .S PSXZ($P($G(^PSRX(DA,4,X,0)),"^",3))=$P($G(^(0)),"^",4)
 S X=$O(^PS(52.5,"B",DA,0)) I X]"" S PSXZ("S")=$P($G(^PS(52.5,X,0)),"^",7)
 K X
 Q
UNHOLD N FDT S FDT=PSORX("FILL DATE"),PSXFROM="UNHOLD" G EN1
REINS S PSXFROM="REINSTATE"
EN1 D SUS1^PSXNEW I '$G(PSXFLAG) G KILL
 D PSXOPUTL
 I $G(PSXEDREL)]""!($G(PSXZ(PSXZ("L")))=0)!($G(PSXZ(PSXZ("L")))=2) D  G KILL
 .I PSXFROM="REINSTATE" W !!,RX_" REINSTATED -- ",! Q
 .I PSXFROM="UNHOLD" W !!,$P(^PSRX(DA,0),"^")_" Removed from Hold Status",!!
 I $G(PSXZ(PSXZ("L")))']"" D S^PSXNEW G KILL
 I $G(PSXZ(PSXZ("L")))=3,(FDT>DT) D S^PSXNEW G KILL
 I $G(PSXZ(PSXZ("L")))=3,((FDT<DT)!(FDT=DT)) D QS
KILL D D1^PSXNEW
 K PSXZ,DIR,X,DIRUT,DUOUT,Y,DTOUT,PSXFROM
 Q
 ;
QS W !! S DIR("A")="LABEL: QUEUE"_$S($P(PSOPAR,"^",24):"/SUSPEND",1:"")_" or '^' to bypass "
 S DIR("?",1)="Enter 'Q' to queue labels for printing" S:$P(PSOPAR,"^",24) DIR("?",2)="Enter 'S' to suspend labels for printing at a later date"
 S DIR(0)="SA^Q:QUEUE"_$S($P(PSOPAR,"^",24):";S:SUSPENSE",1:""),DIR("B")="Q" D ^DIR K DIR
 I $D(DUOUT)!$D(DIRUT) G KILL
 I $G(Y)="S" D S^PSXNEW K PSXZ Q
 I $G(Y)="Q" D D1^PSXNEW K PSXZ I $G(PSOLAP)]"",($G(PSOLAP)'=ION) S PPL=DA D QLBL^PSORXL Q
 I $G(Y)="Q" S PPL=DA D Q1^PSORXL
 Q
HLD N PSOFROM S PSOFROM="HOLD"
EN ;  Called from PSORXDL,HLD+4^PSOHLD, PSOCAN
 ; if in suspense and "loading" no delete
 Q:'$G(DA)  D ^PSXOPUTL
 I $G(PSXZ("S"))="L" D MSG K PSXZ Q
 I $G(PSOFROM)="DELETE",($G(PSXZ(PSXZ("L")))=0!($G(PSXZ(PSXZ("L")))=2)) D MSG
 K PSXZ
 Q
MSG W !!,"A CMOP Rx cannot be"_$S($G(PSOFROM)="HOLD":" placed on HOLD",$G(PSOFROM)="CANCEL":" CANCELLED",1:" DELETED")
 W $S($G(PSOFROM)="DELETE":" while in",1:" during")
 W $S($G(PSOFROM)="DELETE":" transmission status!",1:" transmission! ")_"  Try later.",!!
 S PSXDFLAG=1
 Q
CMOP ;
 I $D(^PSRX(RXN,4)) F PSXZ=0:0 S PSXZ=$O(^PSRX(RXN,4,PSXZ)) Q:'PSXZ  D
 .S PSX($P(^PSRX(RXN,4,PSXZ,0),U,3))=$P(^PSRX(RXN,4,PSXZ,0),U,4)
 K PSXZ
 Q
DUPCAN N DA,PSOFROM S DA=+PSOSD(DNM),PSOFROM="CANCEL" G EN
 ;Called from ASK+4^PSORENW
MW(PSODIR) ;
 K DIR,DIC
 S DIR(0)="52,11"
 S DIR("B")=$S($G(PSORX("MAIL/WINDOW"))]"":PSORX("MAIL/WINDOW"),1:"WINDOW")
 D DIR G:PSODIR("DFLG")!PSODIR("FIELD") MWX
 I $G(Y(0))']"" S PSODIR("DFLG")=1 G MWX
 S PSODIR("MAIL/WINDOW")=Y,PSORX("MAIL/WINDOW")=Y(0)
MW1 G:PSODIR("MAIL/WINDOW")'="W"!('$P($G(PSOPAR),"^",12)) MWX
 S DIR(0)="52,35O"
 S:$G(PSORX("METHOD OF PICK-UP"))]"" DIR("B")=PSORX("METHOD OF PICK-UP")
 D DIR G:PSODIR("DFLG") MWX
 I X[U W !,"Cannot jump to another field ..",! G MW1
 S (PSODIR("METHOD OF PICK-UP"),PSORX("METHOD OF PICK-UP"))=Y
MWX K X,Y
 Q
DIR ;
 S PSODIR("FIELD")=0
 G:$G(DIR(0))']"" DIRX
 D ^DIR K DIR,DIE,DIC,DA
 I $D(DUOUT)!($D(DTOUT))!($D(DIROUT)),$L($G(X))'>1!(Y="") S PSODIR("DFLG")=1 G DIRX
DIRX K DIRUT,DTOUT,DUOUT,DIROUT,PSOX
 Q

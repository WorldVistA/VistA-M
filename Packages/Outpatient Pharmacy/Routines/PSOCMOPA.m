PSOCMOPA ;BIR/HTW-Utility for Hold/Can ;[ 12/30/96  10:28 AM ]
 ;;7.0;OUTPATIENT PHARMACY;**61,76**;DEC 1997
 ;External Referrence to file # 550.2 granted by DBIA 2231
 ;Required input:  DA - internal entry # -  ^PSRX
 ;Returns:
 ;CMOP("L")=LAST FILL... if it is orig Rx =0
 ;CMOP(FILL #)=CMOP status from 52...Trans/0,DISP/1,RETRAN/2,NOT DISP/3
 ;If suspended CMOP("S")=CMOP suspense status Q,L,X,P,R
 ;PSOCMOP=STATUS_^_TRAN DATE_^_LAST FILL
 ;All returned variables can be killed by K CMOP,PSOCMOP 
 ;
 N X,XN,BATCH,TDT,BIEN
 K PSOCMOP
 S (CMOP("L"),X)=0  F  S X=$O(^PSRX(DA,1,X)) Q:'X  S CMOP("L")=X
 I $O(^PSRX(DA,4,0)) F X=0:0 S X=$O(^PSRX(DA,4,X)) Q:'X  D
 .S XN=$G(^PSRX(DA,4,X,0)),BATCH=$P($G(XN),"^") Q:$G(BATCH)']""
 .S BIEN=$O(^PSX(550.2,"B",BATCH,"")) Q:$G(BIEN)']""  S TDT=$P(^PSX(550.2,BIEN,0),"^",6)
 .S CMOP($P($G(XN),"^",3))=$P($G(XN),"^",4),PSOCMOP=$P($G(XN),"^",4)_"^"_$G(TDT)_"^"_CMOP("L")
 S X=$O(^PS(52.5,"B",DA,0)) I X]"" S CMOP("S")=$P($G(^PS(52.5,X,0)),"^",7),CMOP("52.5")=X
 K X,XN,BATCH,TDT,BIEN
 Q
UNHOLD N FDT S FDT=PSORX("FILL DATE"),XFROM="UNHOLD" G EN1
REINS S XFROM="REINSTATE"
EN1 D SUS1^PSOCMOP I '$G(XFLAG) G KILL
 D PSOCMOPA
 I $G(REL)]""!($G(CMOP(CMOP("L")))=0)!($G(CMOP(CMOP("L")))=2) D  G KILL
 .I XFROM="REINSTATE" W !!,RX_" REINSTATED -- ",! Q
 .I XFROM="UNHOLD" W !!,$P(^PSRX(DA,0),"^")_" Removed from Hold Status",!!
 I $G(CMOP(CMOP("L")))']"" D S^PSOCMOP G KILL
 I $G(CMOP(CMOP("L")))=3,(FDT>DT) D S^PSOCMOP G KILL
KILL D D1^PSOCMOP
 K CMOP,DIR,X,DIRUT,DUOUT,Y,DTOUT,XFROM
 Q
 ;
QS W !! S DIR("A")="LABEL: QUEUE"_$S($P(PSOPAR,"^",24):"/SUSPEND",1:"")_" or '^' to bypass "
 S DIR("?",1)="Enter 'Q' to queue labels for printing" S:$P(PSOPAR,"^",24) DIR("?",2)="Enter 'S' to suspend labels for printing at a later date"
 S DIR(0)="SA^Q:QUEUE"_$S($P(PSOPAR,"^",24):";S:SUSPENSE",1:""),DIR("B")="Q" D ^DIR K DIR
 I $D(DUOUT)!$D(DIRUT) G KILL
 I $G(Y)="S" D S^PSOCMOP K CMOP Q
 I $G(Y)="Q" D D1^PSOCMOP K CMOP I $G(PSOLAP)]"",($G(PSOLAP)'=ION) S PPL=DA,RXLTOP=1 D QLBL^PSORXL Q
 I $G(Y)="Q" S PPL=DA,RXLTOP=1 D Q1^PSORXL
 Q
HLD N PSOFROM S PSOFROM="HOLD"
EN ;  Called from PSORXDL,HLD+4^PSOHLD, PSOCAN
 ; if in suspense and "loading" no delete
 Q:'$G(DA)  D PSOCMOPA
 I $G(CMOP("S"))="L" D MSG K CMOP Q
 I $G(PSOFROM)="DELETE",($G(CMOP(CMOP("L")))=0!($G(CMOP(CMOP("L")))=2)) D MSG
 K CMOP
 Q
MSG W !!,"A CMOP Rx cannot be"_$S($G(PSOFROM)="HOLD":" placed on HOLD",$G(PSOFROM)="CANCEL":" DISCONTINUED",1:" DELETED")
 W $S($G(PSOFROM)="DELETE":" while in",1:" during")
 W $S($G(PSOFROM)="DELETE":" transmission status!",1:" transmission! ")_"  Try later.",!!
 S XFLAG=1
 Q
CMOP ;
 I $D(^PSRX(RXN,4)) F PSXZ=0:0 S PSXZ=$O(^PSRX(RXN,4,PSXZ)) Q:'PSXZ  D
 .S PSX($P(^PSRX(RXN,4,PSXZ,0),U,3))=$P(^PSRX(RXN,4,PSXZ,0),U,4)
 K PSXZ
 Q
DUPCAN N DA,PSOFROM S DA=+PSOSD(STA,DNM),PSOFROM="CANCEL" G EN
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

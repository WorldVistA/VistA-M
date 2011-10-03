RMPRSTI ;HINCIO/RVD-ISSUE FROM STOCK ;11/6/00
 ;;3.0;PROSTHETICS;**53,62**;Feb 09, 1996
 ;
 ;RVD patch #62 - modified for PCE interface
 ;
 S (RMPRG,RMPRF,RMENTSUS)="" D HOME^%ZIS W @IOF
 I '$D(RMPR) D DIV4^RMPRSIT G:$D(X) EXIT^RMPRSTE
 I $D(RMPRDFN),$D(^TMP($J,"RMPRPCE")) D LINK^RMPRS
 K ^TMP($J,"RMPRPCE")
 W ! D GETPAT^RMPRUTIL G:'$D(RMPRDFN) EXIT^RMPRSTE
VIEW ;
 N RMPRBAC1,RMDES
 S RMPRBAC1=1 D ^RMPRPAT K RMPRBAC1
 I $D(RMPRKILL)!($D(DTOUT)) W $C(7),!,"Deleted..." G EXIT^RMPRSTE
 S CK="W:$D(DUOUT) @IOF,!!!?28,$C(7),""Deleted..."" G EXIT^RMPRSTE"
 S CK2="W @IOF,!!!?28,$C(7),""Deleted..."" H 2"
 S CK1="W $C(7),!,""Timed-Out, Deleted..."" G EXIT^RMPRSTE"
 S R3("D")=""
 ;
RES ;ENTRY POINT TO ADD ADDITIONAL ITEMS FOR ISSUE FROM STOCK
 Q:$G(RMPRDFN)<1
 K DA,DD,DIC,PRC,X,Y,RMSO,RMQTY,RMDAHC,RMLACO,RMITDA,RMHCOLD
 S (R1(1),R1(0),R3("D"),R4("D"),R1("AM"),RMPRI("AMS"),R1("D"),RMLOC)=""
 S RMLODES=""
 S (RMLOCOLD,RMIT,RMHCNEW,RMHCOLD,RMITDESC,RMITIEN,R1(2))="",REDIT=0
 S R1(0)=DT_U_RMPRDFN_U_DT,$P(R1(0),U,10)=RMPR("STA"),$P(R1(0),U,27)=DUZ
 ;
1 ;ENTRY POINT TO EDIT ITEM ON ISSUE FROM STOCK
 S (RMHCNEW,RMHCOLD)=$P(R1(1),U,4),RMLOCOLD=RMLOC,RMITOLD=RMIT
 K RQUIT S RMHCFLG=0
 W @IOF,!?30,RMPRNAM,!
 W:$G(REDIT) !!,"Editing a Stock Item!!!"
 W:'$G(REDIT) !!,"Entering a Stock Item!!!"
 ;
TRAN ;TYPE OF TRANSACTION
 W !
 ;S DIR(0)="660,2"
 K DIR
 S:$P(R1(0),U,4)?.E&($P(R3("D"),U,4)'="") DIR("B")=$P(R3("D"),U,4)
 S DIR(0)="SO^I:INITIAL ISSUE;X:REPAIR;R:REPLACE;S:SPARE"
 S DIR("A")="TYPE OF TRANSACTION"
 D ^DIR
 I (Y=""),($P(R3("D"),U,4)="") G ^RMPRSTI
 I $P(R3("D"),U,4)'=""&($D(DUOUT)) G LIST^RMPRSTE
 I $D(DTOUT) X CK1 Q
 I $D(DUOUT) G ^RMPRSTI
 S $P(R1(0),U,4)=Y K DIR
 S $P(R3("D"),U,4)=$S(Y="I":"INITIAL ISSUE",Y="X":"REPAIR",Y="R":"REPLACE",Y="S":"SPARE",1:"")
 ;
PCAT ;
 S DIR(0)="660,62" S:$P(R1("AM"),U,3)?1N.N DIR("B")=$P(R4("D"),U,3)
 D ^DIR I $P(R1("AM"),U,3)'=""&($D(DUOUT)) G LIST^RMPRSTE
 I $D(DTOUT) X CK1 Q
 I $D(DUOUT) X CK2 G ^RMPRSTI
 S $P(R1("AM"),U,3)=Y,$P(R4("D"),U,3)=$S(Y=1:"SC/OP",Y=2:"SC/IP",Y=3:"NSC/IP",Y=4:"NSC/OP",1:"") K DIR
 I Y<4 S $P(R1("AM"),U,4)="",$P(R4("D"),U,4)="" G 2
 ;
SPE I Y=4 S DIR(0)="660,63" S:$P(R1("AM"),U,4)?1N.N DIR("B")=$P(R4("D"),U,4) D ^DIR I $D(DTOUT) X CK1 Q
 I $G(REDIT)&($D(DUOUT)) G LIST^RMPRSTE
 I $D(DUOUT) X CK2 G ^RMPRSTI
 I $P(R1("AM"),U,3)=4 S $P(R1("AM"),U,4)=Y,$P(R4("D"),U,4)=$S(Y=1:"SPECIAL LEGISLATION",Y=2:"A&A",Y=3:"PHC",Y=4:"ELIGIBILITY REFORM",1:"")
 ;
2 S DIC(0)="AEQM",DIC=661 S:$P(R1(0),U,6) DIC("B")=$P(^RMPR(661,$P(R1(0),U,6),0),U) S DIC("A")="ITEM: "
 K DIC("S") D ^DIC
 I $P(R3("D"),U,6)&$D(DUOUT) G LIST^RMPRSTE
 I $D(DUOUT) X CK2 G ^RMPRSTI
 I $D(DTOUT) X CK1 Q
 I +Y'>0 W !!,?5,$C(7),"This is a required response.  Enter '^' to exit",! G 2
 S $P(R1(0),U,6)=+Y,$P(R3("D"),U,6)=$P(Y,U,2)
 ;
LOC ;ask for location
 S (RMITFLG,RMHCFLG,RMHCDA,RMITDA,RMAV,RMAVA,RMCO,RMBAL)=0
 K DIC,Y,X,RQUIT,DTOUT,DUOUT
 S DZ="??",D="B",DIC("S")="I $P(^RMPR(661.3,+Y,0),U,3)=RMPR(""STA"")"
 S:RMLOCOLD'="" DIC("B")=RMLOCOLD
 S DIC="^RMPR(661.3,",DIC(0)="AEQM"
 S DIC("A")="Enter Pros Location: " D MIX^DIC1
 I $G(REDIT)&$D(DUOUT) G LIST^RMPRSTE
 I $D(DUOUT) X CK2 G ^RMPRSTI
 I $D(DTOUT) X CK1 Q
 I X="" W !,"This is a mandatory field!!!",! G LOC
 S RMLOC=+Y
 G:'$D(^RMPR(661.3,RMLOC,0)) LOC
 ;
HCPCS ;HCPCS code
 K DIC,RMR,RMX,RQUIT S DIC("A")="PSAS HCPCS: ",DA(1)=RMLOC,RMF=1
 I $P(R1(1),U,4)&(RMLOCOLD=RMLOC) S DIC("B")=$P(R1(1),U,4)
 S DIC="^RMPR(661.3,"_DA(1)_",1,",DIC(0)="AEMNZ"
 S DIC("W")="S RZ=$P(^RMPR(661.3,RMLOC,1,+Y,0),U,1) I RZ W ?30,$P(^RMPR(661.1,RZ,0),U,2)"
 D ^DIC
 I $D(DUOUT) G LOC
 I $D(DTOUT) X CK1 Q
 I X="" W !,"This is a mandatory field!!!",! G HCPCS
 S (RMHCNEW,RMDAHC)=$P($G(^RMPR(661.3,RMLOC,1,+Y,0)),U,1)
 I $G(RMDAHC),$P(^RMPR(661.1,RMDAHC,0),U,5)'=1 D INACT G HCPCS
 S RMHCPC=$P(^RMPR(661.1,RMDAHC,0),U,1),RMHCDA=+Y
 S RDESC=$P(^RMPR(661.1,RMDAHC,0),U,2)
 ;
CPT ;ask for CPT Modifier
 K DIC,Y,RQUIT
 S RDA=RMDAHC_"^"_$P(R1(0),U,4)_"^"_$P(R1(0),U,14)_"^"_660
 D:$D(RMCPT) CHK^RMPRED5
 W:$G(REDIT) !,"OLD CPT MODIFIER: ",$P(R1(1),U,6)
 I RMHCOLD'=RMDAHC D CPT^RMPRCPTU(RDA) G:$D(DUOUT)!$D(DTOUT) LIST^RMPRSTE S $P(R1(1),U,6)=$G(RMCPT) W:$G(REDIT) !,"NEW CPT MODIFIER: ",$G(RMCPT)
 I RMHCOLD'="",(RMHCOLD=RMDAHC),$G(REDIT) D
 .S DIR(0)="Y",DIR("A")="Would you like to Edit CPT MODIFIER Entry  ",DIR("B")="N" D ^DIR Q:$D(DTOUT)!$D(DUOUT)
 .I $G(Y) D CPT^RMPRCPTU(RDA) Q:$D(DUOUT)!$D(DUOUT)  S $P(R1(1),U,6)=$G(RMCPT) W !,"NEW CPT MODIFIER: ",$G(RMCPT)
 K DIR
 ;
 ;D ITEM^RMPR5NU1(REDIT,RMLOC,RMLOCOLD,RMDAHC,RMHCOLD,RMHCDA,RMIT)
 ;
ITEM ;ask for PSAS Item to edit.
 S DA(2)=RMLOC,DA(1)=RMHCDA K DIC,RMU3,RMUBA,RQUIT
 S DIC("A")="Enter PSAS Item: ",DIC(0)="AEMNQ"
 I RMDAHC=RMHCOLD S DIC("B")=$G(RMIT)
 S DIC="^RMPR(661.3,"_DA(2)_",1,"_DA(1)_",1,"
 D ^DIC
 I $D(DUOUT) G LOC
 I $D(DTOUT) X CK1 Q
 I X="" W !,"This is a mandatory field!!!",! G ITEM
 S RMITDA=+Y
 S RMU3=$G(^RMPR(661.3,RMLOC,1,RMHCDA,1,RMITDA,0))
 S RMUBA=$P(RMU3,U,2)
 S (RMITDES,RMIT)=$P(RMU3,U,1)
 S RMDES=RMIT K DIC("B"),DIC("S")
 I RMUBA<1 D LOWBA G LOC
 ;
 I $D(RMLOC),$D(RMHCDA),$D(RMITDA) S RMSO=$$SOURCE^RMPR5NU1
 I $D(RMSO),RMSO="" D MESSO G LOC
 S:$D(RMSO) $P(R1(0),U,14)=RMSO
 S $P(R3("D"),U,14)=$S(RMSO="C":"COMMERCIAL",RMSO="V":"VA",1:"")
 I $P(R1(1),U,4)'="",$D(DUOUT) G LIST^RMPRSTE
 I $G(RMLOC),'($G(RMHCDA)&$G(RMITDA)) W !,"PSAS Item was not selected!!" G LOC
 I $G(RMLOC),$G(RMHCDA),$G(RMITDA) S RMPRUCST=$$COST^RMPR5NU1
 I '$G(RMPRUCST) D MESSI G LOC
 S:$G(REDIT) $P(R1(0),U,16)=RMPRUCST*$P(R1(0),U,7),$P(R3("D"),U,16)=RMPRUCST*$P(R1(0),U,7)
 K DIC
 ;
VEN ;vendor
 S $P(R1(1),U,4)=RMDAHC,$P(R1(0),U,22)=$P(^RMPR(661.1,RMDAHC,0),U,4)
 S RMITNEW=RMIT D NODE2
 I $D(RMLOC),$D(RMHCDA),$D(RMITDA) S DIC("B")=$$VEND^RMPR5NU1
 S $P(R1(0),U,9)=DIC("B")
 S DIC(0)="AEQM",DIC=440,DIC("A")="VENDOR: "
 D ^DIC I $P(R3("D"),U,9)'=""&$D(DUOUT) G LIST^RMPRSTE
 I $D(DTOUT) X CK1 Q
 I $D(DUOUT)  G LOC
 I +Y'>0 W !!,?5,$C(7),"This is a required response.  Enter '^' to exit",! G VEN
 S $P(R1(0),U,9)=+Y,$P(R3("D"),U,9)=$P(Y,U,2) K DIC,Y,X
 G ^RMPRSTE
 ;
NODE2 ;set node2 of file #660
 N RMDAHC,RMITDESC
 S RMDAHC=$P(R1(1),U,4)
 Q:'$G(RMDAHC)
 S:$D(RMIT) RMITIEN=$P(RMIT,"-",2)
 I $G(RMITIEN),$G(RMDAHC) S:$D(^RMPR(661.1,RMDAHC,3,RMITIEN,0)) RMITDESC=$P(^(0),U,1)
 S:$D(RMIT) $P(R1(2),U,1)=RMIT S:$D(RMITDESC) $P(R1(2),U,2)=RMITDESC
 Q
 ;
MESSI ;print message if COST is not defined in the inventory (661.3)
 S:'$D(RMIT) RMIT=""
 W !!,"***ITEM COST is not defined @:"
 W !,"    PSAS Item = ",RMIT
 W !,"    Location  = ",$P($G(^RMPR(661.3,RMLOC,0)),U,1)
 W !,"***Fix your inventory or use a different PSAS ITEM!!",!!
 Q
 ;
MESSO ;print message if SOURCE is not defined in the inventory (661.3)
 W !!,"***PSAS ITEM has no SOURCE at this location..."
 W !,"***Fix your inventory or use a different PSAS ITEM!!",!!
 Q
 ;
INACT ;print message if HCPCS is inactive.
 W !!,"*** You have selected an INACTIVE HCPCS..."
 W !,"*** Please REMOVE this HCPCS from inventory..."
 W !,"*** And use a different HCPCS!!!",!
 Q
 ;
LOWBA ;print message if inventory balance is low.
 S:'$D(RMUBA) RMUBA="" S:'$D(RMIT) RMIT=""
 W !!,"*** PSAS Item ",RMIT," balance is = ",RMUBA
 W !,"*** You are unable to use this PSAS ITEM..."
 W !,"*** Please use a different Location, HCPCS or PSAS Item !!!!",!
 Q
 ;
LKP ;print a message if PSAS HCPCS not in PIP or invalid HCPCS.
 Q:'$G(RMF)!(X=" ")
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 K RX
 I $D(^RMPR(661.3,"D1",X,RMLOC)) S RX=1
 I '$G(RX),$D(^RMPR(661.1,"B",X)) D EN^DDIOL("*** Only PSAS HCPCS in PIP can be issued.  Please verify your Location and PSAS HCPCS!!","","!!")
 K RX
 Q

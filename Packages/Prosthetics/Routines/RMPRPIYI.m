RMPRPIYI ;HINCIO/RVD-ISSUE FROM STOCK ;6/16/04  08:18
 ;;3.0;PROSTHETICS;**61,128**;Feb 09, 1996
 ; RVD #61 - phase IIIa of PIP
 ;
 S RMPR699("AMIS GROUPER")=""
 S (RMPRG,RMPRF)="" D HOME^%ZIS W @IOF
 I '$D(RMPR) D DIV4^RMPRSIT G:$D(X) EXIT^RMPRPIYJ
 I $D(RMPRDFN),$D(^TMP($J,"RMPRPCE")) D LINK^RMPRS
 I $D(RMPRDFN),'$D(^TMP($J,"RMPRPCE")) G EXIT^RMPRPIYJ
 K ^TMP($J,"RMPRPCE")
 D GETPAT^RMPRUTIL G:'$D(RMPRDFN) EXIT^RMPRPIYJ
VIEW ;
 N RMPRBAC1,RMDES,RMITQTY
 S (RSTCK,RMPRBAC1)=1 D ^RMPRPAT K RMPRBAC1
 I $D(RMPRKILL)!($D(DTOUT)) W $C(7),!,"Deleted..." G EXIT^RMPRPIYJ
 S CK="W:$D(DUOUT) @IOF,!!!?28,$C(7),""Deleted..."" G EXIT^RMPRPIYJ"
 S CK2="W @IOF,!!!?28,$C(7),""Deleted..."" H 2"
 S CK1="W $C(7),!,""Timed-Out, Deleted..."" G EXIT^RMPRPIYJ"
 S R3("D")=""
 ;
RES ;ENTRY POINT TO ADD ADDITIONAL ITEMS FOR ISSUE FROM STOCK
 Q:$G(RMPRDFN)<1
 K DA,DD,DIC,PRC,X,Y,RMSO,RMQTY,RMDAHC,RMLACO,RMITDA,RMHCOLD,RMPRVEN
 K RMPR11IS,RMPR5SA,RMPR6SA
 S (R1(1),R1(0),R3("D"),R4("D"),R1("AM"),RMPRI("AMS"),R1("D"),RMLOC)=""
 S RMLODES=""
 S (RMLOCOLD,R1,RMIT,RMHCNEW,RMHCOLD,RMITDESC,RMITIEN,R1(2))="",REDIT=0
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
 I (Y=""),($P(R3("D"),U,4)="") G ^RMPRPIYI
 I $P(R3("D"),U,4)'=""&($D(DUOUT)) G LIST^RMPRPIYJ
 I $D(DTOUT) X CK1 Q
 I $D(DUOUT) G ^RMPRPIYI
 S $P(R1(0),U,4)=Y K DIR
 S $P(R3("D"),U,4)=$S(Y="I":"INITIAL ISSUE",Y="X":"REPAIR",Y="R":"REPLACE",Y="S":"SPARE",1:"")
 ;
PCAT ;
 S DIR(0)="660,62" S:$P(R1("AM"),U,3)?1N.N DIR("B")=$P(R4("D"),U,3)
 D ^DIR I $P(R1("AM"),U,3)'=""&($D(DUOUT)) G LIST^RMPRPIYJ
 I $D(DTOUT) X CK1 Q
 I $D(DUOUT) X CK2 G ^RMPRPIYI
 S $P(R1("AM"),U,3)=Y,$P(R4("D"),U,3)=$S(Y=1:"SC/OP",Y=2:"SC/IP",Y=3:"NSC/IP",Y=4:"NSC/OP",1:"") K DIR
 I Y<4 S $P(R1("AM"),U,4)="",$P(R4("D"),U,4)="" G 2
 ;
SPE I Y=4 S DIR(0)="660,63" S:$P(R1("AM"),U,4)?1N.N DIR("B")=$P(R4("D"),U,4) D ^DIR I $D(DTOUT) X CK1 Q
 I $G(REDIT)&($D(DUOUT)) G LIST^RMPRPIYJ
 I $D(DUOUT) X CK2 G ^RMPRPIYI
 I $P(R1("AM"),U,3)=4 S $P(R1("AM"),U,4)=Y,$P(R4("D"),U,4)=$S(Y=1:"SPECIAL LEGISLATION",Y=2:"A&A",Y=3:"PHC",Y=4:"ELIGIBILITY REFORM",1:"")
 ;
 ; prompt for and scan barcode label
 ; if scan is successful then all vars will be set and go to Edit prompt
2 I $G(REDIT),$D(RMPR11I) M RMPR11IS=RMPR11I,RMPR5SA=RMPR5,RMPR6SA=RMPR6
 W ! D SCAN^RMPRPIYS
 I $P(R3("D"),U,6)&((RMPREXC="^")!(RMPREXC="P")) G LIST^RMPRPIYJ
 I (RMPREXC="^"),$G(REDIT) G LIST^RMPRPIYJ
 I RMPREXC="^" X CK2 G ^RMPRPIYI
 I RMPREXC="P" G PCAT
 I RMPREXC="T" X CK1 Q
 I RMPRBARC="",$G(REDIT) M RMPR11I=RMPR11IS,RMPR5=RMPR5SA,RMPR6=RMPR6SA G ^RMPRPIYJ
 I RMPRBARC="" G 2
 D HCPCS3^RMPRPIY1
 G ^RMPRPIYJ
HCPCS ;HCPCS code
 S (RMITFLG,RMHCFLG,RMHCDA,RMITDA,RMAV,RMAVA,RMCO,RMBAL)=0
 S RMPRHCPC="" I $D(RMHCPC) S RMPRHCPC=RMHCPC
 D HCPCS^RMPRPIY1(RMPR("STA"),RMPRHCPC,.RMPR1,.RMPR11,.RMPREXC)
 I RMPREXC="T" X CK1 Q
 I RMPREXC="P" G 2
 I $G(REDIT),(RMPREXC="^") G LIST^RMPRPIYJ
 I RMPREXC="^" X CK2 G ^RMPRPIYI
 W !
 S RMITNO=RMPR11("ITEM")
 S RMHCPC=RMPR1("HCPCS")
 S (RMHCNEW,RMDAHC,RMHCDA)=RMPR1("IEN")
 S RDESC=RMPR1("SHORT DESC")
 K RMPR11I
 S RMPRERR=$$ETOI^RMPRPIX1(.RMPR11,.RMPR11I)
 I RMPR11I("ITEM MASTER IEN")="" D  G 2
 . W !,"This item is not associated with an IFCAP Item.",!
 . W "Please use the Edit Inventory option before trying to issue this item."
 . W !
 . Q
 I '$D(^RMPR(661.7,"XSHIDS",RMPR("STA"),RMHCPC,RMITNO)) D  G 2
 . W !,"This HCPCS-ITEM is not associated with any Location."
 . W !,"Please update your inventory!!.",!
 . W !
 . Q
 S $P(R1(0),U,6)=RMPR11I("ITEM MASTER IEN")
 S $P(R1(0),U,8)=$G(RMPR11("UNIT"))
 S $P(R3("D"),U,6)=RMPR11("ITEM MASTER")
 ;check for location if multiple then ask for LOCATION
 S RMLCNT=0
 F I=0:0 S I=$O(^RMPR(661.7,"XSLHIDS",RMPR("STA"),I)) Q:I'>0  I $D(^(I,RMHCPC)) S RMLCNT=RMLCNT+1,(RMPR5("IEN"),RMLOC)=I
 I RMLCNT<2 G ITEM
 ;
ASKLOC ;ask for location
 K DIC,Y,X,RQUIT,RMPR5
 S DZ="??",D="B"
 S DIC("S")="I ($P(^RMPR(661.5,+Y,0),U,2)=RMPR(""STA"")),($P(^(0),U,4)=""A""),($D(^RMPR(661.7,""XSLHIDS"",RMPR(""STA""),+Y,RMHCPC,RMITNO)))"
 S:RMLOCOLD'="" DIC("B")=RMLOCOLD
 S DIC="^RMPR(661.5,",DIC(0)="AEQMN"
 S DIC("A")="Enter Pros Location: " D MIX^DIC1
 I $G(REDIT)&$D(DUOUT) G LIST^RMPRPIYJ
 I $D(DUOUT) G 2^RMPRPIYI
 I $D(DTOUT) X CK1 Q
 I X="" W !,"This is a mandatory field!!!",! G ASKLOC
 S RMLOC=+Y
 S RMPR5("IEN")=RMLOC
 G:'$D(^RMPR(661.5,RMLOC,0)) ASKLOC
 ;
ITEM ;PSAS Item details.
 K RMPR11I
 S RMCHCK=$$ETOI^RMPRPIX1(.RMPR11,.RMPR11I)
 I RMCHCK W !,"*** ERROR IN API RMPRPIX1 !!!!",! X CK1 Q
 S RMIT=RMPR11("HCPCS-ITEM")
 S $P(R1(2),U,1)=RMIT S $P(R1(2),U,2)=RMPR11("DESCRIPTION")
 I RMDAHC=RMHCOLD S DIR("B")=$G(RMIT)
 ;
 ;call stock record in 661.7
 S RMR("STATION IEN")=RMPR("STA")
 S RMR("LOCATION IEN")=RMLOC
 S RMR("HCPCS")=RMHCPC
 S RMR("ITEM")=RMPR11("ITEM")
 S RMR("VENDOR IEN")=$P(R1(0),U,9)
 S RMCHCK=$$STOCK^RMPRPIUE(.RMR)
 I RMCHCK W !,"*** ERROR IN API RMPRPIUE !!!!",! X CK1 Q
 S (RMITDES,RMDES)=RMIT K DIC("B"),DIC("S")
 S RMUBA=RMR("QOH")
 I RMUBA<1 D LOWBA G 2
 ;
 I $D(RMLOC),$D(RMHCDA) S RMSO=RMPR11I("SOURCE")
 I $D(RMSO),RMSO="" D MESSO G 2
 S:$D(RMSO) $P(R1(0),U,14)=RMSO
 S $P(R3("D"),U,14)=$S(RMSO="C":"COMMERCIAL",RMSO="V":"VA",1:"")
 I $P(R1(1),U,4)'="",$D(DUOUT) G LIST^RMPRPIYJ
 ;I $G(RMLOC),'($G(RMHCDA)&$G(RMITDA)) W !,"PSAS Item was not selected!!" G 2
 I $G(RMLOC),$G(RMHCDA) S RMPRUCST=RMR("UNIT COST")
 I '$G(RMPRUCST) D MESSI G 2
 S:$G(REDIT) $P(R1(0),U,16)=RMPRUCST*$P(R1(0),U,7),$P(R3("D"),U,16)=RMPRUCST*$P(R1(0),U,7)
 K DIC
 ;
CPT ;ask for CPT Modifier
 D CPT^RMPRPIYS(RMDAHC_"^"_$P(R1(0),U,4)_"^"_$P(R1(0),U,14)_"^"_660)
 I RMPREXC="T" X CK1 Q
 I RMPREXC="^" G 2
 I RMPREXC="P" G 2
 ;
VEN ;vendor
 ;call routine RMPRPIYV for vendor from file 661.6.
 S $P(R1(1),U,4)=RMDAHC,$P(R1(0),U,22)=$P(^RMPR(661.1,RMDAHC,0),U,4)
 ;If there is only one vendor use it as a default.  
 K RMPRVEN
 S RMERR=$$STOCK^RMPRPIUV(.RMR,.RMPRVEN)
 I RMERR W !,"*** ERROR IN API RMPRPIUV !!!!",! X CK1 Q
 I RMPRVEN=1 S DIC("B")=$O(RMPRVEN(0))
 I $G(REDIT) S DIC("B")=$P(R1(0),U,9)
 S DIC(0)="AEQM"
 S DIC("A")="VENDOR: ",DIC=440,DIC("S")="I $D(RMPRVEN(+Y))"
 D ^DIC I $P(R3("D"),U,9)'=""&$D(DUOUT) G LIST^RMPRPIYJ
 I $D(DTOUT) X CK1 Q
 I $D(DUOUT) G 2
 I +Y'>0 W !!,?5,$C(7),"This is a required response.  Enter '^' to exit",! G VEN
 S $P(R1(0),U,9)=+Y,$P(R3("D"),U,9)=$P(Y,U,2) K DIC,Y,X
 G ^RMPRPIYJ
 ;
 ;
MESSI ;print message if COST is not defined in the inventory (661.5)
 S:'$D(RMIT) RMIT=""
 W !!,"***ITEM COST is not define @:"
 W !,"    PSAS Item = ",RMIT
 W !,"    Location  = ",$P($G(^RMPR(661.5,RMLOC,0)),U,1)
 W !,"***Fix your inventory or use a different PSAS ITEM!!",!!
 Q
 ;
MESSO ;print message if SOURCE is not defined in the inventory (661.11)
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
 W !,"*** Please use a different HCPCS or PSAS Item !!!!",!
 Q
 ;
LKP ;print a message if PSAS HCPCS not in PIP or invalid HCPCS.
 Q:'$G(RMF)!(X=" ")
 S X=$TR(X,"abcdefghijklmnopqrstuvwxyz","ABCDEFGHIJKLMNOPQRSTUVWXYZ")
 K RX
 I $D(RSTCK),$D(^RMPR(661.7,"XSHIDS",RMPR("STA"),X)) S RX=1
 I '$D(RSTCK),$D(^RMPR(661.11,"ASHD",RMPR("STA"),X)) S RX=1
 I '$G(RX),$D(^RMPR(661.1,"B",X)) D EN^DDIOL("*** Only PSAS HCPCS in PIP can be accessed.  Please verify your Location and PSAS HCPCS!!","","!!")
 K RX
 Q

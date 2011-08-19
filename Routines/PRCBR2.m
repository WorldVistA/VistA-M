PRCBR2 ;WISC@ALTOONA/CTB-ENTER CEILING TRANSACTION BY FISCAL ;12/28/94  09:24
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
ENC ;ENTER CEILING TRANSACTION
 D EN G:'% EXIT S X1=X,X=$$BBFY^PRCSUT(PRC("SITE"),PRC("FY"),PRC("CP")) G EXIT:'X
 S X=X1 D EN1^PRCSUT3 S X1=X D EN2^PRCSUT3 S X=X1 D W,LOCK^PRCSUT G:PRCSL=0 ENC
 S DIC(0)="AEMQ",DIE=DIC,DR="[PRCSENC]" D ^DIE,ERS410^PRC0G(DA_"^O") D
 . N A,B,X,Y,XMY
 . D NAMES^PRCBBUL
 . S X(1)="CP: "_PRC("CP")_"   QTR: "_PRC("QTR")_"  REF #: "_$P($G(^PRCS(410,DA,4)),"^",5)_"   AMT: "_$P($G(^(4)),"^",3) QUIT:'$P($G(^(4)),"^",3)
 . S X(2)="COMMENT:"
 . S A=2,B=0 F  S B=$O(^PRCS(410,DA,"CO",B)) QUIT:'B  S A=A+1,X(A)=$G(^(B,0))
 . D:$O(XMY("")) MM^PRC0B2("Place a Ceiling Transaction","X(",.XMY)
 . QUIT
 L @("-"_DIC_DA_")") S T(1)="Ceiling" D W3 G:%'=1 EXIT W !! G ENC
W W !!,"This transaction is assigned transaction number: ",X Q
 Q
W2 W !!,"You are not an authorized control point user.",!,"Contact your control point official" R X:5 G EXIT
W3 W ! S %A="Would you like to enter another "_T(1)_" transaction",%B="",%=1 D ^PRCFYN Q:%'=0
EXIT K DA,DIC,DIE,DR,PRCF,PRCS,PRCSL,X,X1 Q
EN ;CREATE NEW TRANSACTION NUMBER
 D EN1^PRCBSUT K C1,DA,DIC Q
QDEV ;ask devide
 I '$$TM^%ZTLOAD D  G OUT
 . W !,"The DHCP system job 'TASK MANAGER' is not running."
 . W !,"The release of these transactions cannot be queued."
 . W !,"Please call site manager to start the TASK MANAGER and try later."
 . QUIT
 D DEV G:POP OUT^PRCBR
QUE ;queue release as a background job
 I '$D(^PRCF(421,"AL",PRCF("SIFY"),1)) W !,"No transactions have been selected for release at this time.",!! G OUT
 D NOW^%DTC S PRCFTIME=%,ZTRTN="^PRCBR1",ZTSAVE("PRCFTIME")="",ZTSAVE("PRCF*")="",ZTSAVE("PRC*")="",ZTSAVE("PRCB*")="",ZTDESC="RELEASE BUDGET TRANSACTIONS",ZTDTH=$H,ZTIO=ION_";"_IOST_";"_IOM_";"_IOSL D ^PRCFQ ;CHANGED "ZTIO=IO"-TEN
OUT S X="BUDGET RELEASE" D UNLOCK^PRCFALCK
KILL K %,%X,D,FAIL,J,K,PRCF,Y,RUN Q
 ;
REL ;reader help
 W !!,"If you answer 'NO', you will have to release these transactions at a later time."
 W !,"By answering 'YES', the transaction(s) selected will be released and posted to",!,"the Control Point(s) now.  If you answer 'YES', you will NOT be able to",!
 W "'^' to quit or access your CRT will this job is running.",!,"This job must run to completion."
 Q
 ;
DEV ;device selection
 W ! S %ZIS="N",IOP="Q",%ZIS("A")="Select DEVICE: ",%ZIS("B")="" D ^%ZIS
 I POP W "Try releasing transaction(s) at a later time" Q
 I IO=$G(IO(0)) W !,"You cannot select your home device.",$C(7),! G DEV
 I IOST'?1"P".E W !,"You must select a printer device.",$C(7),! G DEV
 I $G(IO("Q"))'=1 W !,"You must select a printer device for queuing",$C(7),! G DEV
 Q
 ;
REL1 ;reader help from ^PRCBE
 W !!,"Answer 'YES' if this transaction is complete and ready to be released to",!,"the Fund Control Point."
 W !!,"Enter 'NO' if you want to edit this transaction at a later time.",!!
 Q
 ;
 ;A=file 421 ri
FCPVAL(A) ;EF valid fcp in file 421, EF value=1 if invalid
 N B,C,Z
 S B=$G(^PRCF(421,A,0)),C=$P(B,"^",22) D  I Z="",C S B=$G(^PRCF(421,C,0)) D
 . S Z=$$FCPVAL^PRC0D("^"_$P(B,"-")_"^"_(+$P(B,"^",2))_"^"_$P(B,"-",2)_"^"_(+$$DATE^PRC0C($P(B,"^",23),"I")))
 . D:Z EN^DDIOL("   Transaction "_$P(B,"^")_" has an invalid set-up FCP "_$P(B,"^",2))
 QUIT Z
 ;

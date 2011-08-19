FBAAPIE ;AISC/GRR-ENTER FEE PHARMACY INVOICE ;7/8/2003
 ;;3.5;FEE BASIS;**61**;JAN 30, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 D SITEP^FBAAUTL W:FBPOP !!,*7,"Fee site parameters must be initialized!!" Q:FBPOP  S FBMDF=$P(FBSITE(0),"^",10),FBAAPTC=$S($D(FBAAPTC):FBAAPTC,1:"V")
RD1 W ! S DIR("A")="Are you sure you want to enter a new invoice",DIR("B")="Yes",DIR(0)="Y" D ^DIR K DIR G Q^FBAAPIE1:$D(DIRUT),RDM^FBAAPIE1:'Y
ENTER S (LCNT,TAC,FBINTOT)=0,STAT(0)="",FBAAOUT=1 K FBTOUT
 D GETNXI^FBAAUTL S X=FBAAIN
 S DLAYGO=162.1,DIC="^FBAA(162.1,",DIC(0)="LQ" D ^DIC K DLAYGO G:Y<0 PROB^FBAAPIE1 W !!,"Invoice # assigned is: ",X S IN=X,DA(1)=IN
RDV I '$D(FB583) W !! S DLAYGO=161.2,(DIE,DIC)="^FBAAV(",DIC(0)="AEQLM" D ^DIC K DLAYGO G CHK:Y<0 S DA=+Y D NEW^FBAAVD:$P(Y,"^",3)=1
 I $D(FB583) S DA=FBVEN
 I $D(^FBAAV(DA,0)),$P($G(^("ADEL")),"^")="Y" W !!,"Vendor is flagged for Austin deletion!" G RDV:'$D(FB583),Q^FBAAPIE1
 D EN1^FBAAVD:$P(FBSITE(0),"^",12)="Y" S VIN=DA
RDV1 I $D(^XUSEC("FBAA ESTABLISH VENDOR",DUZ)) W ! S DIR("A")="Want to edit Vendor data",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR G CHK:$D(DIRUT) D:Y EDITV^FBAAVD S VIN=DA
 S FBAR(DA)="" D ^FBAACO4
 W !! S %DT="AEQXP",%DT(0)=-DT,%DT("A")="Date Correct Invoice Received: " D ^%DT K %DT(0),%DT("A") G CHK:Y<0 S INVDATE=Y
 W !! S %DT="AEQXP",%DT(0)=-INVDATE,%DT("A")="Vendor Invoice Date:  " D ^%DT K %DT(0),%DT("A") G CHK:Y<0 S FBVINVDT=Y
 ; if U/C then get FPPS Claim ID else ask user
 I $D(FB583) S FBFPPSC=$P($G(^FB583(FB583,5)),U) W !,"FPPS CLAIM ID: ",$S(FBFPPSC="":"N/A",1:FBFPPSC)
 E  S FBFPPSC=$$FPPSC^FBUTL5() I FBFPPSC=-1 K FBFPPSC G CHK
 S (DIE,DIC)="^FBAA(162.1,",DA=IN
 S DR="1////^S X=INVDATE;1.5////^S X=DT;2////^S X=DUZ;3////^S X=VIN;5////^S X=1;12////^S X=FBVINVDT;13///^S X=FBFPPSC"
 D ^DIE
 I '$D(^FBAA(162.1,IN,"RX",0)) S ^FBAA(162.1,IN,"RX",0)="^162.11A^^"
RDP S FBPHARM=1 W:FBINTOT>0 !,?15,"Pharmacy Invoice #: "_IN_"  Totals: $ "_$J(FBINTOT,1,2)
 ; if EDI then ask FPPS Line Item
 I FBFPPSC]"" W !!! S FBFPPSL=$$FPPSL^FBUTL5() I FBFPPSL=-1 K FBFPPSL G CHK
 D ^FBAASAP K FBPHARM I 'DFN K DFN G CHK
 I FBTT=1 S FBMST="Y",FBTTYPE="A",FBFDC="",FBD1=FTP D ENT^FBAAAUT
 D HOME^%ZIS,FBPH^FBAAUTL2 I $D(DIRUT),$D(FB583) G CHK
RDD W !! S %DT(0)=-DT,%DT="AEXP",%DT("A")="DATE PRESCRIPTION FILLED: " D ^%DT K %DT G:X["^"!(X="") RDP G RDD:Y<0 S DATEF=Y
 I DATEF<FBAABDT!(DATEF>FBAAEDT) W !!,*7,"Date Prescription Filled is ",$S(DATEF<FBAABDT:" prior to ",1:"later than "),"authorization period!!" G RDD
 I '$D(^FBAA(162.1,IN,"RX",0)) S ^FBAA(162.1,IN,"RX",0)="^162.11A^^"
RDRX S DIR(0)="162.11,.01",DIR("A")="Select PRESCRIPTION NUMBER" D ^DIR K DIR G CHK:Y="^"!(Y="") S PSRX=Y,AC=0
 I $D(^FBAA(162.1,IN,"RX","B",PSRX)) G RX2^FBAAPIE1
 D CHK2^FBAAPIE1 I FBJ]"" K FBJ G CHKK^FBAAPIE1
RXADD K DA S DLAYGO=162.1,DA(1)=IN,DIC="^FBAA(162.1,"_IN_",""RX"",",DIC(0)="EQL",X=""""_PSRX_"""" D ^DIC K DLAYGO G:Y<0 RDRX S FBDA=+Y
 S DIE="^FBAA(162.1,",DA=IN,DR="[FB ADD RX]" D ^DIE I $D(DTOUT)!('$G(FBUP)) G DELRX
 S LCNT=LCNT+1,TAC=TAC+AC K FBUP
RDDER W !!,*7,"Prescription referred to Pharmacy Service for determination.",! S X="Y"
 S STAT(1)="" G RDP:'$D(FB583),Q^FBAAPIE1
 S $P(^FBAA(162.1,IN,"RX",DA,2),"^")="P",^FBAA(162.1,"AH","P",IN,DA)="",$P(^FBAA(162.1,IN,0),"^",10)="P"
 S DA(1)=IN,DIE=DIC
HERE S:$D(FBAP) FBINTOT=FBINTOT+FBAP S:$D(DTOUT) FBTOUT="" G OVR:$D(DTOUT),RDD
CHK I LCNT'>0 W !!,"Since you didn't enter any line items",!,"Invoice # ",IN," has been Deleted!!",*7 D KILL G Q^FBAAPIE1:$D(FBTOUT),MORE:'$D(FB583),Q^FBAAPIE1
OVR K DTOUT,DR,DQ,DG
 K STAT(2)
 S (DIE,DIC)="^FBAA(162.1,",DA=IN,STAT=$O(STAT(0)),DR="5////^S X=STAT;6///^S X=TAC;7///^S X=FBINTOT;8///^S X=LCNT" D ^DIE G:$D(FBTOUT) Q^FBAAPIE1 W !!,"Invoice No.: ",IN," Completed!" W:FBINTOT>0 ?45,"Invoice Total: $ ",$J(FBINTOT,1,2)
MORE K STAT,FBHX W ! S DIR("A")="Want to enter another Invoice",DIR("B")="No",DIR(0)="Y" D ^DIR K DIR G Q^FBAAPIE1:$D(DIRUT)!('Y),ENTER
 Q
KILL S DIK="^FBAA(162.1,",DA=IN D ^DIK K DIK Q
DELRX S DIK="^FBAA(162.1,"_DA(1)_",""RX"",",DA=FBDA D ^DIK K DTOUT,DQ,DR,DG S FBTOUT="" W !,"Incomplete prescription entry.  Deleted.",! G CHK

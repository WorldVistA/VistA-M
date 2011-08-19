PRCPSLOI ;WISC/RFJ-create and transmit 663,669 code sheets          ;19 Feb 92
 ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
 ;
DQ(TRANNO,TRANID) ;  create/trans receiving code sheets to log
 ;  tranno=transaction number
 ;  tranid=tran register id number
 N %,%H,%I,COSTCNTR,COUNT,CP,DATA,DATE,DATEREC,DEPT,DESC,DIETPER,DISYS,INVPT,ITEMDATA,NSN,QTY,PRCPXMZ,TRANDA,TRANREG,TRANTYPE,UI,V,X
 S CP=$P(TRANNO,"-",4),TRANTYPE=663 I $P($G(^PRC(420,+TRANNO,1,+CP,0)),"^",12)=3 S TRANTYPE=669,CP="CTN"
 I $P($G(^PRC(420,+TRANNO,1,+CP,0)),"^",12)=1 S TRANTYPE=669,CP="GPF"
 S TRANDA=+$O(^PRCS(410,"B",TRANNO,0)),INVPT=+$P($G(^PRCS(410,TRANDA,0)),"^",6),DEPT=$P($G(^PRCP(445,INVPT,0)),"^",8) I DEPT="",'$G(PRCPFLAG) D ASKDEPT I $G(PRCPFLAG) W !,$$ERROR^PRCPSLOR
 S DEPT=$E("   ",$L(DEPT)+1,3)_DEPT,COSTCNTR=+$P($G(^PRCS(410,TRANDA,3)),"^",3) S:COSTCNTR=0 COSTCNTR="" S COSTCNTR=$E("      ",$L(COSTCNTR)+1,6)_COSTCNTR S:TRANTYPE=669!(CP="GPF") COSTCNTR="000000"
 S DIETPER=" " I $E(DEPT,1,2)=11 S DIETPER=$P($G(^PRCS(410,TRANDA,100)),"^",2) I DIETPER="",'$G(PRCPFLAG) D ASKPER I $G(PRCPFLAG) W !,$$ERROR^PRCPSLOR
 S:DIETPER="" DIETPER=" "
 K ^TMP($J,"STRING") S TRANREG=0,COUNT=1 F  S TRANREG=$O(^PRCP(445.2,"C",TRANNO,TRANREG)) Q:'TRANREG  S DATA=$G(^PRCP(445.2,TRANREG,0)) I DATA'="",$P(DATA,"^",2)=TRANID D
 .   I '$G(DATE) S DATE=$P(DATA,"^",3),DATEREC=+$E(DATE,4,5),DATEREC=$S(DATEREC=10:0,DATEREC=11:"J",DATEREC=12:"K",1:DATEREC)
 .   S ITEMDATA=$G(^PRC(441,+$P(DATA,"^",5),0)),NSN="   "_$E($TR($P($P(ITEMDATA,"^",5),"-",2,4),"-")_"          ",1,10),UI=$E($P($P(DATA,"^",6),"/",2)_"  ",1,2)
 .   S DESC=$E($P(ITEMDATA,"^",2)_"                     ",1,21),V=$E($P(DATA,"^",15),2,6),V=$E("     ",$L(V)+1,5)_V,QTY=-$P(DATA,"^",7) S:QTY<0 QTY=-QTY S QTY=$E("00000",$L(QTY)+1,5)_QTY
 .   S ^TMP($J,"STRING",COUNT)=NSN_$P(TRANNO,"-")_TRANTYPE_" "_DESC_UI_DEPT_V_"        "_QTY_"  "_DIETPER_CP_DATEREC_COSTCNTR_"   ",COUNT=COUNT+1
 I COUNT=1 Q
 D TRANSMIT^PRCPSMCL($P(TRANNO,"-"),TRANTYPE,"LOG")
 W !!?4,"LOG ",TRANTYPE," Transmitted in MailMan Messages:" I $D(PRCPXMZ) S %=0 F  S %=$O(PRCPXMZ(%)) Q:'%  W " ",PRCPXMZ(%),"  "
 Q
 ;
 ;
ASKDEPT ;  ask department number
 ;  prcpflag is returned if incorrect response
 N DTOUT,DUOUT,DIRUT S DIR(0)="F^3:3",DIR("A")="Enter DEPARTMENT NUMBER" W ! D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) S PRCPFLAG=1 Q
 I Y["^" S PRCPFLAG=1 Q
 S DEPT=X S:$D(^PRCP(445,INVPT,0)) $P(^(0),"^",8)=DEPT Q
 ;
 ;
ASKPER ;  ask dietetic period
 ;  prcpflag is returned if incorrect response
 N DTOUT,DUOUT,DIRUT S DIR(0)="S^1:FIRST REPORT;2:SECOND REPORT;N:NO REPORT;",DIR("A")="Enter DIETETIC COST REPORT" W ! D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) S PRCPFLAG=1 Q
 I Y["^" S PRCPFLAG=1 Q
 S DIETPER=Y,$P(^PRCS(410,TRANDA,100),"^",2)=Y Q
 ;
 ;
ASKDEPOT ;  ask depot number (field 107 in 442)
 ;  prcpflag is returned if incorrect response
 N DTOUT,DUOUT,DIRUT S DIR(0)="F^3:3",DIR("A")="Enter DEPOT Number from shipping document" W ! S:$G(DEPOT)'="" DIR("B")=DEPOT D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) S PRCPFLAG=1 Q
 I Y["^" S PRCPFLAG=1 Q
 S DEPOT=X,$P(^PRC(442,PODA,18),"^")=X Q
 ;
 ;
ASKVOUCH ;  ask depot voucher number (field .09 in 442)
 ;  prcpflag is returned if incorrect response
 N DTOUT,DUOUT,DIRUT S DIR(0)="F^5:5",DIR("A")="Enter DEPOT VOUCHER Number from shipping document" W ! S:$G(VOUCHER)'="" DIR("B")=VOUCHER D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) S PRCPFLAG=1 Q
 I Y["^" S PRCPFLAG=1 Q
 S VOUCHER=X,$P(^PRC(442,PODA,1),"^",13)=X Q
 ;
 ;
ASKREQNO ;  ask requisition number (supply) (field 102.4 in 442)
 ;  prcpflag is returned if incorrect response
 N DTOUT,DUOUT,DIRUT S DIR(0)="F^5:5",DIR("A")="Enter REQUISITION NO. (SUPPLY)" W ! D ^DIR K DIR I $D(DTOUT)!($D(DUOUT))!($D(DIRUT)) S PRCPFLAG=1 Q
 I Y["^" S PRCPFLAG=1 Q
 S REQNO=X,$P(^PRC(442,PODA,18),"^",10)=STATION_"-"_$E(X,1,3)_"-"_$E(X,4,5) Q

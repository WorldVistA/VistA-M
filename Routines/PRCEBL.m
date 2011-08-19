PRCEBL ;WISC/LDB-BULLETIN FOR REMAINING OBLIGATION BALANCE NOTIFICATION ; 07/08/93  11:55 AM
 ;;5.1;IFCAP;**23**;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Called from PRCEAU0 (called by PRCEAU,PRCEDRE/DRE2),PRCEAU1 to alert CP concerning remaining obligation balance
 Q:+$P(BAL,U,6)
 I '$D(PODA) D  Q:$G(PODA)=""
  . Q:$P($G(TRNODE(4)),U,5)=""
  . S ZX=$G(X),DIC="^PRC(442,",DIC(0)="MN",X=PRC("SITE")_"-"_$P($G(TRNODE(4)),U,5) D ^DIC K DIC S X=ZX S:+Y>0 PODA=+Y
 D BUL^PRCH58(PODA)
 N TIME1,LN S TIME1=$P(TIME,"."),TIME1=+$E(TIME1,4,5)_"/"_+$E(TIME1,6,7)_"/"_$E(TIME1,2,3)
 S PRBL(1)="     ATTENTION!!"
 S PRBL(2)=" "
 S PRBL(3)="As of "_TIME1_" on 1358 obligation number: "_PRC("SITE")_"-"_$P($G(TRNODE(4)),U,5)
 S PRBL(4)="the obligated balance is $"_$FN(+BAL,"P,",2)_"."
 S PRBL(5)="Total authorized amount is $"_$FN($P(BAL,U,3),"P,",2)_"."
 S LN=6 I $P(BAL,U,3)'=$P(^PRC(424,AUDA,0),"^",12) D
 . S PRBL(LN)="Amount for this authorization is"_$FN($P(^PRC(424,AUDA,0),"^",12),"P,",2)_"."
 . S LN=LN+1
 S PRBL(LN)="Balance remaining on this authorization is $"
 S PRBL(LN)=PRBL(LN)_$FN($P(^PRC(424,AUDA,0),"^",5)-$S($G(IN)="EDIT":0,1:Y),"P,",2)_"."
 S PRBL(LN+1)="Please review and determine if an adjustment is necessary for future"
 S PRBL(LN+2)="payments, if not, mark the 1358 as complete."
 S XMTEXT="PRBL(",XMSUB="1358 NOTICE TO CONTROL POINT "_$P($P($G(TRNODE(3)),"^",1)," ",1)
 K XMY N X S X=0 F  S X=$O(^PRC(420,PRC("SITE"),1,+$P($G(TRNODE(3))," "),1,X)) Q:'X  I $P($G(^(X,0)),U,2)<3 S XMY(X,1)="I"
 D:$O(XMY(0)) ^XMD K PRBL,XMDUZ,XMSUB,XMTEXT,XMY Q

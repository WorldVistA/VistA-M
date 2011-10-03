RCCPCBJ ;WASH-ISC@ALTOONA,PA/NYB-Background Driver for CCPC ;1/7/97  9:42 AM
 ;;4.5;Accounts Receivable;**34,76,130,153,166,195,217,237**;Mar 20, 1995
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
EN ;Starts the background job for CCPC 5 days before statement day
 N X,X1,X2,X3,ZTRTN,ZTIO,ZTDTH,ZTSK,ZTDESC
 D ACK
 S X1=$$STD^RCCPCFN,X2=-2 D C^%DTC
 ;10-process end time/18-ccpc file built
 I X=DT D  Q
 . S X3=$O(^RCPS(349.2,0)) Q:'X3
 . Q:'$P($P($G(^RCPS(349.2,X3,0)),"^",10),".")
 . Q:'$P($G(^RCPS(349.2,X3,0)),"^",18)
 . D EN^RCCPCML
 ;quit if date created is yesterday's date
 S X1=$$STD^RCCPCFN,X2=-1 D C^%DTC
 I X=DT D  Q
 . S X3=+$O(^RCT(349,0))
 . S X3=$P($P($G(^RCT(349,X3,0)),"^",11),".")
 . S X1=DT,X2=-1 D C^%DTC
 . I X=X3 Q
 . D EN^RCCPCML
 ;
 S X1=$$STD^RCCPCFN,X2=-3 D C^%DTC
 I X'=DT Q
 I DT'<$P($G(^RC(342,1,30)),"^",1)&(DT'>$P($G(^RC(342,1,30)),"^",2)) D ^RCEXINAD
 S ZTIO="",ZTRTN="OPEN^RCCPCBJ",ZTDESC="CCPC PATIENT STATEMENT"
 S ZTDTH=$H D ^%ZTLOAD
 Q
OPEN ;Update Open status bills to Active or Cancellation status
 N DAY,BN,DEBTOR,DA,DIE,DR,P,AMT
 N ZTSAVE,ZTRTN,ZTDESC,ZTASK,%ZIS,ZTDTH
 S DATE=$$STD^RCCPCFN,DAY=+$$STDY^RCCPCFN,DEBTOR=0 F  S DEBTOR=$O(^RCD(340,"AC",DAY,DEBTOR)) Q:'DEBTOR  D
    .S BN=0 F  S BN=$O(^PRCA(430,"AS",DEBTOR,$O(^PRCA(430.3,"AC",112,0)),BN)) Q:'BN  D
       ..S AMT=0 F P=1:1:5 S AMT=$P($G(^PRCA(430,+BN,7)),"^",P)+AMT
       ..I $P($G(^PRCA(430,+BN,0)),"^",2)=$O(^PRCA(430.2,"AC",33,0)),AMT Q
       ..S DIE="^PRCA(430,",DA=+BN,DR="8////^S X="_$S(AMT:$O(^PRCA(430.3,"AC",102,0)),1:$O(^PRCA(430.3,"AC",111,0))) D ^DIE K DA,DIE,DR
       ..Q
    .Q
 ;
 ;  update patient accounts with interest and admin
 N RCLASDAT
 S RCLASDAT=DATE
 I DT>3010101 D FIRSTPTY^RCBECHGS
 D ^RCCPCPS
 D REFUND
 Q
 ;
 ;
REFUND ;Update Open status PREPAYMENT bills to REFUND REVIEW
 S DEBTOR=0,DAY=+$$STDY^RCCPCFN
 F  S DEBTOR=$O(^RCD(340,"AC",DAY,DEBTOR)) Q:'DEBTOR  D
    .S BN=0 F  S BN=$O(^PRCA(430,"AS",DEBTOR,$O(^PRCA(430.3,"AC",112,0)),BN)) Q:'BN  D
       ..I $P($G(^PRCA(430,+BN,0)),"^",2)=$O(^PRCA(430.2,"AC",33,0)) S X=$$EN^PRCARFU(+BN)
       ..Q
    .Q
 Q
 ;
ACK ;CHECK FOR ACKNOWLEDGEMENTS
 N DEB,MSG,NO,RCX,X,X1,X2
 S X1=$$STD^RCCPCFN,X2=DT D ^%DTC I X>3 D
 .D TRANCHK^RCCPCSV1
 Q

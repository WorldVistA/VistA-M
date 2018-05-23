ORY462 ;DRM/MWA/VMP - PRE/POST INSTALL FOR PATCH OR*3.0*462 ; 8/31/17 10:39am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**462**;;Build 6
 ;
 ; External References:
 ; ^XMD    ICR #10070
 ;
 Q
EN ;entry point
 N ORX,DLG0,MSGCNT,ORMSG,DIETDG,FAILREGS
 S DIETDG=$O(^ORD(100.98,"B","DIET ORDERS",0))
 S ORX=0,MSGCNT=4
 F  S ORX=$O(^ORD(101.41,ORX)) Q:'ORX  I $G(^ORD(101.41,ORX,0))'="" S DLG0=^ORD(101.41,ORX,0) D
 .Q:$P(DLG0,U,4)'="Q"
 .N DLG S DLG=0 F  S DLG=$O(^ORD(101.41,ORX,6,"D",DLG)) Q:'DLG  D
 ..I DLG=4,$P(DLG0,U,5)=DIETDG D REGCHK
 D ADDREGS,MAIL
 Q
REGCHK ; check for regular/npo diet with another diet on a diet quick order
 N RPIEN S RPIEN=0,RPIEN=$O(^ORD(101.41,ORX,6,"D",DLG,RPIEN)) I RPIEN,$O(^ORD(101.41,ORX,6,"D",DLG,RPIEN)) D
 .S RPIEN="" F  S RPIEN=$O(^ORD(101.41,ORX,6,"D",DLG,RPIEN)) Q:'RPIEN  D
 ..N DIET S DIET=+$G(^ORD(101.41,ORX,6,RPIEN,1))
 ..I ($P($G(^ORD(101.43,DIET,0)),U)="REGULAR")!($P($G(^ORD(101.43,+DIET,0)),U)="NPO") S FAILREGS(ORX)=""
 Q
ADDREGS ; add any orders found in REGCHK to mail man message
  I '$D(ORMSG(4)) S MSGCNT=5
  S ORMSG(MSGCNT)="",MSGCNT=MSGCNT+1
  S ORMSG(MSGCNT)="The following Diet Quick orders have both a Regular/NPO and another diet",MSGCNT=MSGCNT+1
  S ORMSG(MSGCNT)="They must be manually edited",MSGCNT=MSGCNT+1
  S ORMSG(MSGCNT)="",MSGCNT=MSGCNT+1
  S FAILREGS="" I '$O(FAILREGS(FAILREGS)) S ORMSG(MSGCNT)="None Found"
  S FAILREGS="" F  S FAILREGS=$O(FAILREGS(FAILREGS)) Q:'FAILREGS  D
  .S ORMSG(MSGCNT)=$P($G(^ORD(101.41,FAILREGS,0)),U)_" IEN - "_FAILREGS,MSGCNT=MSGCNT+1
  I
  Q
MAIL ; send mailman message
 N XMSUB,XMDUZ,XMTEXT,XMY,DIFROM
 S ORMSG(1)="OR*3.0*462 install routine has completed"
 S ORMSG(2)="The instances for the following quick orders have been changed"
 S ORMSG(3)=" "
 I '$D(ORMSG(4)) S ORMSG(4)="No changes"
 S XMSUB="OR*3.0*462 install routine has completed"
 S XMDUZ="ORDER ENTRY/RESULTS REPORTING PACKAGE"
 S XMTEXT="ORMSG("
 S XMY(DUZ)=""
 D ^XMD
 Q

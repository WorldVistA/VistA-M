ORY461 ; HPS/MWA - Post install routine for OR*3*461 ; 6/9/17 11:22am
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**461**;;Build 8
 Q  ;only allow routine to be run from entry points
EN ; main entry point
 N I,II,III,IIII,IDG,DIA,INPTS,IEN,MSGCNT,ORMSG
 S MSGCNT=5
 S IDG="",IDG=$O(^ORD(100.98,"B","INPATIENT MEDICATIONS",IDG))
 S DIA="",DIA=$O(^ORD(101.41,"B","PSJ OR PAT OE",DIA))
 ;get all currently admitted patients
 S I="" F  S I=$O(^DPT("ACN",I)) Q:'$L(I)  D
 .S II="" F  S II=$O(^DPT("ACN",I,II)) Q:'$L(II)  D
 ..S INPTS(II_";DPT(")=""
 S I="" F  S I=$O(INPTS(I)) Q:'$L(I)  D
 .S II="" F  S II=$O(^OR(100,"AW",I,II)) Q:'$L(II)  D
 ..S III="" F  S III=$O(^OR(100,"AW",I,II,III)) Q:'$L(III)  D
 ...Q:($E(III,1,3)<316)
 ...S IIII="" F  S IIII=$O(^OR(100,"AW",I,II,III,IIII)) Q:'$L(IIII)  D
 ....S IEN=IIII I "^3^5^6^10^11^"[(U_$P($G(^OR(100,IEN,3)),U,3)_U),$P($G(^OR(100,IEN,0)),U,5)=(DIA_";ORD(101.41,"),$P(^OR(100,IIII,0),U,11)=IDG D FIX
 D MAIL
 Q
FIX ; fix
 ;                      I               II            III        IIII
 ; ^OR(100,"AW",<OBJECT OF ORDER>,<DISPLAY GROUP>,<START DATE>,<ORDER#>)
 N DA,DR,DIE S DIE="^OR(100,",DA=IIII,DR="23///UNIT DOSE MEDICATIONS" D ^DIE
 S ORMSG(MSGCNT)=IIII,MSGCNT=MSGCNT+1
 Q
MAIL ; send mailman message
 N XMSUB,XMDUZ,XMTEXT,XMY,DIFROM
 S ORMSG(1)="OR*3.0*461 Post install routine has completed"
 S ORMSG(2)="The following order(s) have had their display group changed"
 S ORMSG(3)="from INPATIENT MEDICATIONS to UNIT DOSE MEDICATIONS"
 S ORMSG(4)="**INFORMATIONAL ONLY - No action required** :"
 I '$D(ORMSG(5)) S ORMSG(5)="No changes"
 S XMSUB="OR*3.0*461 Post install routine has completed"
 S XMDUZ="ORDER ENTRY/RESULTS REPORTING PACKAGE"
 S XMTEXT="ORMSG("
 S XMY(DUZ)=""
 D ^XMD
 Q

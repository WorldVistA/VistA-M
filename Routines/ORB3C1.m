ORB3C1 ; slc/CLA - Routine to pre-convert OE/RR 2.5 to OE/RR 3 notifications ;7/3/96  15:16 [ 04/03/97  1:41 PM ]
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**9**;Dec 17, 1997
 Q
PREORB ;initiate pre-inits for converting OE/RR 2.5 notification fields to OE/RR 3.0 notification parameters
 ;called by ORCPRE (OE/RR 3 pre-init)
 N ORBC,ORBERR,ORBNOW
 I $L($T(GET^XPAR))>1,($D(^XTV(8989.51,"B","ORBC CONVERSION"))>0) D
 .S ORBC=$$GET^XPAR("SYS","ORBC CONVERSION",1,"Q")
 I +$G(ORBC)>0 D BMES^XPDUTL("Notifications already PRE-converted.") Q
 D BMES^XPDUTL("PRE-conversion of notifications...")
 S ORBNOW=$$NOW^XLFDT
 S ^XTMP("ORBC",0)=$$FMADD^XLFDT(ORBNOW,30,"","","")_U_ORBNOW
 D PRESTUB,PREPKG,PRECONV,PRECLEAN,PRERU,PRERG,PREPF,PREEX
 I $L($T(EN^XPAR))>1,($D(^XTV(8989.51,"B","ORBC CONVERSION"))>0) D
 .D EN^XPAR("SYS","ORBC CONVERSION",1,"1",.ORBERR) ;1:pre-convert done
 D BMES^XPDUTL("PRE-conversion of notifications completed.")
 Q
POSTORB ;initiate post-inits for converting OE/RR 2.5 notification fields to OE/RR 3.0 notification parameters
 D POSTORB^ORB3C2
 Q
PRESTUB ;initiate stubbing of notifications 30-57 and renaming of some existing notifictions
 D BMES^XPDUTL("Stubbing notifications 30-49,51-58.")
 N ORBI,ORBA,ORBIEN,ORBERR
 S ORBA(100.9,"+30,",.01)="CONSULT/REQUEST CANCEL/HOLD",ORBIEN(30)=30
 S ORBA(100.9,"+31,",.01)="NPO DIET MORE THAN 72 HRS",ORBIEN(31)=31
 S ORBA(100.9,"+32,",.01)="SITE-FLAGGED RESULTS",ORBIEN(32)=32
 S ORBA(100.9,"+33,",.01)="ORDERER-FLAGGED RESULTS",ORBIEN(33)=33
 S ORBA(100.9,"+35,",.01)="DISCHARGE",ORBIEN(35)=35
 S ORBA(100.9,"+36,",.01)="TRANSFER FROM PSYCHIATRY",ORBIEN(36)=36
 S ORBA(100.9,"+37,",.01)="ORDER REQUIRES CO-SIGNATURE",ORBIEN(37)=37
 S ORBA(100.9,"+41,",.01)="SITE-FLAGGED ORDER",ORBIEN(41)=41
 S ORBA(100.9,"+42,",.01)="LAB ORDER CANCELED",ORBIEN(42)=42
 S ORBA(100.9,"+43,",.01)="STAT ORDER",ORBIEN(43)=43
 S ORBA(100.9,"+44,",.01)="STAT RESULTS",ORBIEN(44)=44
 S ORBA(100.9,"+45,",.01)="DNR EXPIRING",ORBIEN(45)=45
 S ORBA(100.9,"+46,",.01)="FREE TEXT",ORBIEN(46)=46
 S ORBA(100.9,"+47,",.01)="MEDICATIONS EXPIRING",ORBIEN(47)=47
 S ORBA(100.9,"+48,",.01)="UNVERIFIED MEDICATION ORDER",ORBIEN(48)=48
 S ORBA(100.9,"+51,",.01)="STAT IMAGING REQUEST",ORBIEN(51)=51
 S ORBA(100.9,"+52,",.01)="URGENT IMAGING REQUEST",ORBIEN(52)=52
 S ORBA(100.9,"+53,",.01)="IMAGING RESULTS AMENDED",ORBIEN(53)=53
 S ORBA(100.9,"+54,",.01)="ORDER CHECK",ORBIEN(54)=54
 S ORBA(100.9,"+55,",.01)="FOOD/DRUG INTERACTION",ORBIEN(55)=55
 S ORBA(100.9,"+56,",.01)="ERROR MESSAGE",ORBIEN(56)=56
 S ORBA(100.9,"+57,",.01)="CRITICAL LAB RESULTS (ACTION)",ORBIEN(57)=57
 S ORBA(100.9,"+58,",.01)="ABNORMAL LAB RESULT (INFO)",ORBIEN(58)=58
 D CLEAN^DILF
 D UPDATE^DIE("","ORBA","ORBIEN","ORBERR")
 D BMES^XPDUTL("Notification stubbing completed.")
 D BMES^XPDUTL("Renaming notifications 14,21,22,24,25,26,50.")
 S $P(^ORD(100.9,14,0),U)="ABNORMAL LAB RESULTS (ACTION)"
 S $P(^ORD(100.9,21,0),U)="IMAGING PATIENT EXAMINED"
 S $P(^ORD(100.9,22,0),U)="IMAGING RESULTS"
 S $P(^ORD(100.9,24,0),U)="CRITICAL LAB RESULT (INFO)"
 S $P(^ORD(100.9,25,0),U)="ABNORMAL IMAGING RESULTS"
 S $P(^ORD(100.9,26,0),U)="IMAGING REQUEST CANCEL/HELD"
 S $P(^ORD(100.9,50,0),U)="NEW ORDER"
 ;kill then rebuild "B" x-ref:
 K ^ORD(100.9,"B")
 S DIK="^ORD(100.9,",DIK(1)=".01^B" D ENALL^DIK
 K DIK
 D BMES^XPDUTL("Notification renaming completed.")
 Q
PREPKG ;pre-init to kill bad entries in the package file
 S DA=0,DIK="^DIC(9.4,",DA=$O(^DIC(9.4,"C","ORA",DA)) I $L($G(DA)) D ^DIK
 S DA=0,DIK="^DIC(9.4,",DA=$O(^DIC(9.4,"C","ORB",DA)) I $L($G(DA)) D ^DIK
 K DA,DIK
 Q
PRECONV ;convert OE/RR 2.5 alerts that are deleted in the CPRS conversion into
 ;informational alerts and send them to the appropriate user
 N ORBUSR,ORBDT,ORBNOW,ORBNODE,ORBMSG,ORBN,ORBCNT,ORBAID
 S ORBNOW=$$NOW^XLFDT
 S ORBUSR=0,ORBCNT=0
 D BMES^XPDUTL("Converting existing alerts...")
 F  S ORBUSR=$O(^XTV(8992,ORBUSR)) Q:+$G(ORBUSR)<.5  D
 .S ORBDT=0 F  S ORBDT=$O(^XTV(8992,ORBUSR,"XQA",ORBDT)) Q:ORBDT=""  D
 ..S ORBNODE=^XTV(8992,ORBUSR,"XQA",ORBDT,0)
 ..S ORBAID=$P($P(ORBNODE,U,2),";")
 ..Q:$P(ORBAID,",")'="OR"  ;quit if not an OE/RR alert
 ..S ORBN=$P(ORBAID,",",3)  ;get notification ien
 ..;if notification is an alert to be deleted during conversion:
 ..I (ORBN=3)!(ORBN=6)!(ORBN=12)!(ORBN=14)!(ORBN=24)!(ORBN=50) D
 ...S ORBCNT=ORBCNT+1
 ...S ORBMSG=$P(ORBNODE,U,3)
 ...S XQAMSG="[CONV] "_ORBMSG
 ...S XQAID="OR3CONV"_","_ORBCNT_","_ORBNOW
 ...S XQA(ORBUSR)=""
 ...S XQAFLG="I"
 ...D SETUP^XQALERT
 ...K XQAMSG,XQAID,XQA,XQAFLG
 Q
PRECLEAN ;clean up old alerts and unused entries in Notification file
 ; 3 - Lab Results
 ; 6 - Flagged Orders
 ;10 - Unsigned Progress Notes
 ;12 - Orders Requiring Electronic Signature
 ;13 - Co-signature on Progress Notes
 ;14 - Abnormal Labs
 ;15 - Cytology Results
 ;16 - Anatomical Pathology Results
 ;17 - Autopsy Report
 ;24 - Critical Lab Results
 ;50 - Lab critical/abnormal/new rslt
 ;97 - Test Notification
 ;
 ;clean up old alerts with fup actions unprocessable or unused by CPRS:
 N ORBI,ORX S ORBI=""
 D BMES^XPDUTL("Cleaning up old alerts...")
 F ORBI=3,6,10,12,13,14,15,16,17,24,50,97 D
 .Q:'$D(^ORD(100.9,ORBI))
 .D NOTIPURG^XQALBUTL(ORBI)
 .S ORX="   "_$P(^ORD(100.9,ORBI,0),U)_" cleaned up."
 .D BMES^XPDUTL(ORX)
 ;
 K XPDIDTOT
 ;clean up unused entries in the notification file:
 S ORBI=""
 F ORBI=10,13,15,16,17,97 D
 .Q:'$D(^ORD(100.9,ORBI))
 .S DA=ORBI,DIK="^ORD(100.9," D ^DIK
 .K DA,DIK
KILLC ;kill then rebuild "C" x-ref
 K ^ORD(100.9,"C")
 S DIK="^ORD(100.9,",DIK(1)=".02^C" D ENALL^DIK  ;rebuild the "C" x-ref
 K DA,DIK
 Q
PRERU ;pre-init conversion of OE/RR 2.5 RECIPIENT USERS 
 N ORBN,ORBU,ORI,I
 S ORBN=0,ORI="",I=1
 F  S ORBN=$O(^ORD(100.9,ORBN)) Q:+ORBN<1  D
 .I $G(^ORD(100.9,ORBN,200,0))="" Q
 .S ORI=0 F  S ORI=$O(^ORD(100.9,ORBN,200,ORI)) Q:'ORI  D
 ..S ORBU=$G(^ORD(100.9,ORBN,200,ORI,0)) Q:ORBU=""
 ..Q:'$L($G(^VA(200,ORBU,0)))
 ..S ^XTMP("ORBC","USER PROCESSING FLAG",I)=ORBU_U_ORBN
 ..S ^XTMP("ORBC","USER PROCESSING FLAG",0)=I,I=I+1
 Q
PRERG ;pre-init conversion of OE/RR 2.5 RECIPIENT GROUPS
 N ORBN,ORBT,ORI,I
 S ORBN=0,ORI="",I=1
 F  S ORBN=$O(^ORD(100.9,ORBN)) Q:+ORBN<1  D
 .I $G(^ORD(100.9,ORBN,2,0))="" Q
 .S ORI=0 F  S ORI=$O(^ORD(100.9,ORBN,2,ORI)) Q:'ORI  D
 ..S ORBT=$G(^ORD(100.9,ORBN,2,ORI,0)) Q:ORBT=""
 ..Q:'$L($G(^OR(100.21,ORBT,0)))
 ..S ^XTMP("ORBC","DEFAULT RECIPIENTS",I)=ORBT_U_ORBN
 ..S ^XTMP("ORBC","DEFAULT RECIPIENTS",0)=I,I=I+1
 Q
PREPF ;pre-init conversion of OE/RR 2.5 PROCESSING FLAG
 N ORBN,ORBF,I
 S ORBN=0,I=1
 F  S ORBN=$O(^ORD(100.9,ORBN)) Q:+ORBN<1  D
 .S ORBF=$G(^ORD(100.9,ORBN,3))  Q:ORBF=""
 .S ORBF=$S(ORBF["^":$P(ORBF,U),1:ORBF) Q:ORBF=""
 .S ORBF=$S(ORBF="M":"Mandatory",ORBF="E":"Disabled",ORBF="N":"Disabled",ORBF="D":"Disabled",1:"Disabled")
 .S ^XTMP("ORBC","SITE PROCESSING FLAG",I)=ORBF_U_ORBN
 .S ^XTMP("ORBC","SITE PROCESSING FLAG",0)=I,I=I+1
 Q
PREEX ;pre-init conversion of OE/RR 2.5 EXCLUDE ATTENDING & EXCLUDE PRIMARY
 N ORBN,ORBXA,ORBXP,ORBNTOP,I
 S ORBN=0,I=1
 ;
 ;check Order Param file for value of Notification to Physician field:
 S ORBNTOP=$P($G(^ORD(100.99,1,2)),U,11)
 ;
 F  S ORBN=$O(^ORD(100.9,ORBN)) Q:+ORBN<1  D
 .Q:$G(^ORD(100.9,ORBN,0))=""
 .Q:$G(^ORD(100.9,ORBN,3))=""  ;quit if a stubbed notif
 .S ORBXA=$P(^ORD(100.9,ORBN,0),U,9),ORBXP=$P(^ORD(100.9,ORBN,0),U,10)
 .I '$L(ORBNTOP),(+$G(ORBXA)<1),(+$G(ORBXP)<1) Q
 .I ($L(ORBXA))!($L(ORBXP)) D
 ..S ^XTMP("ORBC","PROVIDER RECIPIENTS",I)=ORBXA_U_ORBXP_U_ORBNTOP_U_ORBN
 ..S ^XTMP("ORBC","PROVIDER RECIPIENTS",0)=I,I=I+1
 Q

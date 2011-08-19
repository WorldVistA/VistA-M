ORY134 ;SLC/DAN ;3/28/02  12:35
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**134**;Dec 17, 1997
 ;
 ;Finds current orders with incorrect fractional dose entries containing two decimal places.
 ;
 N ORMSG,ZTSK
 S ORMSG(1)=""
 S ORMSG(2)="This patch contains a post-init.  This post-init will"
 S ORMSG(3)="run in the background and will identify potential fractional dose problems."
 S ORMSG(4)="It will then send a mail message to the iniator and holders of the PSNMGR key"
 S ORMSG(5)="indicating which orders need to be reviewed."
 S ORMSG(6)=""
 D MES^XPDUTL(.ORMSG)
 S ZTRTN="DQ^ORY134",ZTDESC="Patch OR*3*134 database review",ZTIO="",ZTSAVE("DUZ")="",ZTDTH=$H
 D ^%ZTLOAD
 I $G(ZTSK) D MES^XPDUTL("Post-init queued to background as task number "_ZTSK_".")
 Q
 ;
DQ ;Enter here for queued task
 K ^TMP("ORFIX",$J)
 D FIX,MAIL
 K ^TMP("ORFIX",$J),^TMP("ORTXT",$J)
 Q
 ;
FIX ;This section will identify active orders with fractional dose problems
 N PAT,DATE,IEN,PTID
 S PAT=""
 F  S PAT=$O(^OR(100,"AC",PAT)) Q:PAT=""  D
 .S DATE=0 F  S DATE=$O(^OR(100,"AC",PAT,DATE)) Q:'+DATE  D
 ..S IEN=0 F  S IEN=$O(^OR(100,"AC",PAT,DATE,IEN)) Q:'+IEN  D
 ...Q:$$NMSP^ORCD($P($G(^OR(100,IEN,0)),U,14))'="PS"  ;quit if not pharmacy
 ...S PTID=$$PTID(PAT) Q:PTID=-1  ;get patient ID quit if referral or couldn't determine name
 ...I $$VALUE^ORX8(IEN,"INSTR")["0.." I '$$UPDT S ^TMP("ORFIX",$J,$P($$STATUS^ORQOR2(IEN),U,2),PTID,IEN)=$$DRUG
 Q
 ;
MAIL ;Send results of review in a mail message to initiator
 N I,XMSUB,XMTEXT,XMDUZ,XMY,STA,IEN,PAT
 S XMSUB="Patch OR*3*134 review completed"
 S XMDUZ="Patch OR*3*134 Post-Init"
 S XMY(.5)="" S:$G(DUZ) XMY(DUZ)="" D PSNMGR(.XMY)
 S XMTEXT="^TMP(""ORTXT"",$J,"
 K ^TMP("ORTXT",$J)
 S I=1
 S ^TMP("ORTXT",$J,I)="The database review for patch OR*3*134 has completed.",I=I+1
 S ^TMP("ORTXT",$J,I)="Below is a listing of patients that need to have",I=I+1
 S ^TMP("ORTXT",$J,I)="their prescriptions reviewed and possibly updated.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 S ^TMP("ORTXT",$J,I)="For orders in an active (active, pending, hold, etc) state it is",I=I+1
 S ^TMP("ORTXT",$J,I)="recommended that the order be evaluated and updated according to",I=I+1
 S ^TMP("ORTXT",$J,I)="the following guidelines.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 S ^TMP("ORTXT",$J,I)="If the order has refills remaining or if the order can",I=I+1
 S ^TMP("ORTXT",$J,I)="potentially be renewed, edit the invalid dosage which will",I=I+1
 S ^TMP("ORTXT",$J,I)="create a new order with a valid SIG.  The appropriate number",I=I+1
 S ^TMP("ORTXT",$J,I)="of remaining refills must then be added to the new order.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 S ^TMP("ORTXT",$J,I)="If the order has no refills remaining and the order will not",I=I+1
 S ^TMP("ORTXT",$J,I)="be renewed then the order should be discontinued.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 S ^TMP("ORTXT",$J,I)="Depending on the status of the order the DRUG listed in the report",I=I+1
 S ^TMP("ORTXT",$J,I)="will either be a dispense drug or an orderable item.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 I '$D(^TMP("ORFIX",$J)) S ^TMP("ORTXT",$J,I)="No problems were found.  No manual intervention is required.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 S STA="" F  S STA=$O(^TMP("ORFIX",$J,STA)) Q:STA=""  D
 .S ^TMP("ORTXT",$J,I)="Order Status - "_STA,I=I+1,^TMP("ORTXT",$J,I)="",I=I+1
 .S PAT=0 F  S PAT=$O(^TMP("ORFIX",$J,STA,PAT)) Q:PAT=""  D
 ..S IEN=0 F  S IEN=$O(^TMP("ORFIX",$J,STA,PAT,IEN)) Q:'+IEN  D
 ...S ^TMP("ORTXT",$J,I)=PAT_$$REPEAT^XLFSTR(" ",(40-$L(PAT)))_"DRUG = "_^TMP("ORFIX",$J,STA,PAT,IEN),I=I+1
 .S ^TMP("ORTXT",$J,I)="",I=I+1
 D ^XMD ;send results
 Q
 ;
PTID(IEN) ;Return pt name and 1A4U identifiers or -1 if unable to determine
 N DFN,VADM
 I +IEN=0!(IEN'["DPT") Q -1
 S DFN=+IEN
 D ^VADPT
 I $G(VADM(1))="" Q -1
 Q $E(VADM(1),1)_$E(VADM(2),6,9)_"  "_VADM(1)
 ;
UPDT() ;Function to determine if order has been updated yet.
 N TXT,I,UPDT
 S UPDT=1
 D TEXT^ORQ12(.TXT,IEN_";"_$P($G(^OR(100,IEN,3)),U,7),80) ;get current order text
 F I=1:1:TXT I TXT(I)["0.." S UPDT=0 Q
 Q UPDT
 ;
DRUG() ;Get dispense drug or orderable item
 N VALUE
 S VALUE=$$VALUE^ORX8(IEN,"DRUG",,"E")
 I VALUE="" S VALUE=$$VALUE^ORX8(IEN,"ORDERABLE",,"E")
 Q VALUE
 ;
PSNMGR(XMY) ;Add PSNMGR key holders to XMY array
 ;DBIA 10076 allows direct read of XUSEC
 N USER
 S USER=0 F  S USER=$O(^XUSEC("PSNMGR",USER)) Q:'USER  S XMY(USER)=""
 Q

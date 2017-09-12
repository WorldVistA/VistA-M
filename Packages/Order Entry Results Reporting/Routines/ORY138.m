ORY138 ;SLC/DAN ;3/14/02  15:31
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**138**;Dec 17, 1997
 ;DBIA 2058 allows read of B xref in DIC(9.4
 ;DBIA 2197 allows reading of install file
 ;
 ;Set missing AE xref, fix incorrect package pointer, and fix incorrect display group (TO field).
 ;
 N ORMSG,ZTSK
 S ORMSG(1)=""
 S ORMSG(2)="This patch contains a post-init.  This post-init will"
 S ORMSG(3)="run in the background and will fix any known database errors."
 S ORMSG(4)="It will then send a mail message to the iniator indicating what was changed."
 S ORMSG(5)=""
 D MES^XPDUTL(.ORMSG)
 S ZTRTN="DQ^ORY138",ZTDESC="Patch OR*3*138 database clean up",ZTIO="",ZTSAVE("DUZ")="",ZTDTH=$H
 D ^%ZTLOAD
 I $G(ZTSK) D MES^XPDUTL("Post-init queued to background as task number "_ZTSK_".")
 Q
 ;
DQ ;Enter here for queued task
 N ERR
 K ^TMP("ORFIX",$J)
 D FIXES,FIXPPDG,MAIL
 K ^TMP("ORFIX",$J),^TMP("ORTXT",$J)
 Q
 ;
FIXES ;This section will add missing AE Xrefs from active orders
 N CNT,PAT,DATE,IEN,PTNAME,STOPDT,DA,CURDT,LASTRUN
 S CNT=0
 S PAT=""
 S LASTRUN=$$GET^XPAR("SYS","ORM ORMTIME LAST RUN",1,"I") ;last date/time ORMTIME ran
 S CURDT=$S(LASTRUN'="":LASTRUN,1:$$NOW^XLFDT) ;Set CURDT to last run date/time or current date/time as appropriate
 F  S PAT=$O(^OR(100,"AC",PAT)) Q:PAT=""  D
 .S DATE=0 F  S DATE=$O(^OR(100,"AC",PAT,DATE)) Q:'+DATE  D
 ..S IEN=0 F  S IEN=$O(^OR(100,"AC",PAT,DATE,IEN)) Q:'+IEN  D
 ...Q:$$NMSP^ORCD($P($G(^OR(100,IEN,0)),U,14))'="PS"  ;quit if not pharmacy
 ...I $O(^OR(100,IEN,8,1)) D CHKACT ;If more than one action check to make sure current action is correct
 ...Q:$O(^OR(100,IEN,2,0))  ;No AE for parent orders
 ...S PTNAME=$$PTNM(PAT) Q:PTNAME=-1  ;get patient name quit if referral or couldn't determine name
 ...S STOPDT=+$P($G(^OR(100,IEN,0)),U,9) Q:'+STOPDT!(STOPDT'>CURDT)
 ...Q:$D(^OR(100,"AE",STOPDT,IEN))  ;already has an AE xref
 ...S DA=IEN
 ...D ES^ORDD100A ;Sets AE xref if appropriate
 ...I $D(^OR(100,"AE",STOPDT,IEN)) S ^TMP("ORFIX",$J,PTNAME,IEN,"ES")="",CNT=CNT+1
 S ^TMP("ORFIX",$J,0)=CNT
 Q
 ;
FIXPPDG ;This section will fix incorrect package pointer and display group problems.
 N DATE,IEN,CNT,IPKG,OPKG,IDG,ODG,BADPKG,BADDG,OR0,PTNAME,PCLASS,PKG,TYPE,DG,DIK,DA,EDG,ADMITTED,ENTERED,DIC,DR,ORARRAY
 S DATE=$$INSTDT("OR*3.0*94")
 S DATE=$S(DATE:$$FMADD^XLFDT(DATE,-1,23,59),1:3000815.24) ;If install date not found revert back to 1st possible install date
 S IEN=$$GETIEN(DATE)-1 ;Get first order number for date, subtract one so the first order is reviewed
 I IEN=-1 S ERR="No orders in date range" Q  ;No orders to review
 S CNT=0
 S IPKG=$O(^DIC(9.4,"B","INPATIENT MEDICATIONS",0)) ;Inpatient meds package IEN
 S OPKG=$O(^DIC(9.4,"B","OUTPATIENT PHARMACY",0)) ;Outpatient meds package IEN
 S IDG=$O(^ORD(100.98,"B","UD RX",0)) ;Inpatient meds display group IEN
 S ODG=$O(^ORD(100.98,"B","O RX",0)) ;Outpatient meds display group IEN
 S BADPKG=$O(^DIC(9.4,"B","PHARMACY DATA MANAGEMENT",0)) ;Bad package IEN
 S BADDG=$O(^ORD(100.98,"B","PHARMACY",0)) ;Bad display group IEN
 I IPKG=""!(OPKG="")!(IDG="")!(ODG="")!(BADPKG="")!(BADDG="") S ERR="Package or display group file entries are missing from the local system." Q  ;missing values
 F  S IEN=$O(^OR(100,IEN)) Q:'+IEN  D
 .S OR0=$G(^OR(100,IEN,0)) Q:OR0=""  ;Missing 0 node
 .S PKG=$P(OR0,U,14) ;Current package
 .I $$NMSP^ORCD(PKG)'="PS" Q  ;Originating package should be a pharmacy type
 .S DG=$P(OR0,U,11) ;Current display group (TO field)
 .I PKG=BADPKG!(DG=BADDG) D  S CNT=CNT+1
 ..S DIC=9.4,DR=".01",DA=PKG,DIQ="ORARRAY" D EN^DIQ1 S PKGN=ORARRAY(9.4,DA,.01) K DIC,DR,DA,DIQ,ORARRAY
 ..S DIC=100.98,DR=".01",DA=DG,DIQ="ORARRAY" D EN^DIQ1 S DGN=ORARRAY(100.98,DA,.01) K DIC,DR,DA,DIQ,ORARRAY
 ..S PTNAME=$$PTNM($P(OR0,U,2))
 ..I PTNAME=-1 Q  ;either patient is referral or is missing
 ..S PCLASS=$P(OR0,U,12)
 ..S TYPE=$S($$VALUE^ORX8(IEN,"REFILLS")'="":"OUT",1:"IN") ;Sets type of order to outpatient if there are refills, else inpatient
 ..I TYPE="OUT" D
 ...I PCLASS'="O" S ^TMP("ORFIX",$J,PTNAME,IEN,"PC")="INPATIENT to OUTPATIENT" S $P(^OR(100,IEN,0),U,12)="O"
 ...I PKG'=OPKG S ^TMP("ORFIX",$J,PTNAME,IEN,"PKG")="from "_PKGN_" to OUTPATIENT PHARMACY" S $P(^OR(100,IEN,0),U,14)=OPKG
 ...I DG'=ODG S ^TMP("ORFIX",$J,PTNAME,IEN,"DG")="from "_DGN_" to O RX" D XREF(IEN,DG,ODG) ;Re-index display group field
 ..;
 ..I TYPE="IN" D
 ...S ENTERED=$P(OR0,U,7) ;Date order entered
 ...S ADMITTED=$$ADM(IEN,ENTERED)
 ...I ADMITTED=-1 Q  ;unable to detemine patient status
 ...I PCLASS'="I" S ^TMP("ORFIX",$J,PTNAME,IEN,"PC")="OUTPATIENT to INPATIENT" S $P(^OR(100,IEN,0),U,12)="I"
 ...I PKG'=IPKG S ^TMP("ORFIX",$J,PTNAME,IEN,"PKG")="from "_PKGN_" to INPATIENT MEDICATIONS" S $P(^OR(100,IEN,0),U,14)=IPKG
 ...S EDG=$S(ADMITTED:IDG,1:ODG) ;Expected display group
 ...I DG'=EDG S ^TMP("ORFIX",$J,PTNAME,IEN,"DG")="from "_DGN_" to "_$S(ADMITTED:"UD RX",1:"O RX") D XREF(IEN,DG,EDG) ;Re-index display group
 S $P(^TMP("ORFIX",$J,0),U,2)=CNT
 Q
 ;
GETIEN(STDT) ;Find first IEN associated with given start date
 N DONE,IEN
 S (DONE,IEN)=0
 F  S STDT=$O(^OR(100,"AF",STDT)) Q:'+STDT!(DONE)  D
 .S IEN=0 F  S IEN=$O(^OR(100,"AF",STDT,IEN)) Q:'+IEN  I $O(^(IEN,0))=1 S DONE=1 Q  ;Find first ORDER that is a new order
 Q IEN
 ;
MAIL ;Send results of cleanup in a mail message to initiator
 N I,XMSUB,XMTEXT,XMDUZ,XMY
 S XMSUB="Patch OR*3*138 Clean up completed"
 S XMDUZ="Patch OR*3*138 Post-Init"
 S XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S XMTEXT="^TMP(""ORTXT"",$J,"
 K ^TMP("ORTXT",$J)
 S I=1
 S ^TMP("ORTXT",$J,I)="The database clean-up for patch OR*3*138 has completed.",I=I+1
 S ^TMP("ORTXT",$J,I)="Below is a listing of what was changed and any possible error messages.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 S ^TMP("ORTXT",$J,I)=+$P($G(^TMP("ORFIX",$J,0)),U)_" orders had AE cross references added.",I=I+1
 S ^TMP("ORTXT",$J,I)=+$P($G(^TMP("ORFIX",$J,0)),U,2)_" orders had their package, display group, or patient class changed.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 I $D(ERR) D
 .S ^TMP("ORTXT",$J,I)="An error occurred that stopped the package and display group check.",I=I+1
 .S ^TMP("ORTXT",$J,I)="Please log a NOIS and indicate that you received the following error:",I=I+1
 .S ^TMP("ORTXT",$J,I)=ERR,I=I+1
 .S ^TMP("ORTXT",$J,I)="",I=I+1
 .S ^TMP("ORTXT",$J,I)="If any AE cross references were added you will still see the results below.",I=I+1
 I '$D(ERR) I $G(^TMP("ORFIX",$J,0))="0^0" S ^TMP("ORTXT",$J,I)="No changes were made to your database.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 S PAT=0 F  S PAT=$O(^TMP("ORFIX",$J,PAT)) Q:PAT=""  D
 .S ^TMP("ORTXT",$J,I)=PAT,I=I+1
 .S ORD=0 F  S ORD=$O(^TMP("ORFIX",$J,PAT,ORD)) Q:ORD=""  D
 ..S ^TMP("ORTXT",$J,I)="   ORDER #: "_ORD,I=I+1
 ..F J="ES","DG","PKG","PC" I $D(^TMP("ORFIX",$J,PAT,ORD,J)) D
 ...S ^TMP("ORTXT",$J,I)="      "_$S(J="ES":"Added AE cross reference ",J="PKG":"Changed package ",J="DG":"Changed display group ",1:"Changed patient class from ")
 ...S ^TMP("ORTXT",$J,I)=$G(^TMP("ORTXT",$J,I))_$G(^TMP("ORFIX",$J,PAT,ORD,J))
 ...S I=I+1
 .S ^TMP("ORTXT",$J,I)="",I=I+1
 D ^XMD ;send results
 Q
 ;
INSTDT(PATCH) ;Returns installation date patch first installed at site
 N IEN
 S IEN=$O(^XPD(9.7,"B",PATCH,0)) Q:'+IEN 0 ;Get IEN of first installation
 Q $P($P($G(^XPD(9.7,IEN,1)),U),".")  ;Get date of first install
 ;
ADM(IEN,ENTERED) ;Determine if patient was inpatient when order was entered
 ;returns 1 if inpat, 0 if not inpat, -1 if no DFN or object of order is from referral patient file
 N DFN,VAIN,VAINDT
 S DFN=$P($G(^OR(100,IEN,0)),U,2) ;get object of order
 I +DFN=0!(DFN'["DPT") Q -1  ;No DFN found or not from patient file
 S DFN=+DFN
 S VAINDT=ENTERED
 D INP^VADPT
 Q $S($G(VAIN(1)):1,1:0)  ;If VAIN(1) has a value then patient was an inpatient
 ;
PTNM(IEN) ;Return pt name or -1 if unable to determine
 N DFN,VADM
 I +IEN=0!(IEN'["DPT") Q -1
 S DFN=+IEN
 D ^VADPT
 I $G(VADM(1))="" Q -1
 Q $G(VADM(1))
 ;
XREF(IEN,DG,NDG) ;Update xrefs for TO field
 N DA,DIE,DR
 K ^OR(100,"AW",$P(OR0,U,2),DG,$S($P(OR0,U,8):$P(OR0,U,8),1:9999999),IEN)
 S DIE=100,DA=IEN,DR="23///"_NDG D ^DIE
 Q
 ;
CHKACT ;Compares current action field with actual current action and updates if necessary
 N CURACT,I,ACT
 S CURACT=$P(^OR(100,IEN,3),U,7) Q:'CURACT
 S I="?" F  S I=$O(^OR(100,IEN,8,I),-1) Q:'+I  I $P(^(I,0),U,15)="" S ACT=I Q
 I CURACT'=ACT S $P(^OR(100,IEN,3),U,7)=ACT D SETALL^ORDD100(IEN)
 Q

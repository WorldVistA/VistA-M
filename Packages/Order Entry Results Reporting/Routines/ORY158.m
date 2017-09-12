ORY158 ;SLC/DAN ;11/14/02  08:36
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**158**;Dec 17, 1997
 ;DBIA 2058 allows read of B xref in DIC(9.4
 ;DBIA 2197 allows reading of install file
 ;
POST ;Find child entries with a provider of 0 and update it to the correct provider
 ;
 N ORMSG,ZTSK,ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE
 S ORMSG(1)="This patch contains a post-init which will run in the background and fix"
 S ORMSG(2)="any known database errors.  It will then send a mail message to the"
 S ORMSG(3)="initiator indicating what was changed."
 D BMES^XPDUTL(.ORMSG)
 S ZTRTN="DQ^ORY158",ZTDESC="Patch OR*3*158 database clean up",ZTIO="",ZTSAVE("DUZ")="",ZTDTH=$H
 D ^%ZTLOAD
 I $G(ZTSK) D BMES^XPDUTL("Post-init queued to background as task number "_ZTSK_".")
 Q
 ;
DQ ;Enter here for queued task
 N ERR,CNT
 K ^TMP("ORFIX",$J)
 D UPDATE,MAIL
 K ^TMP("ORFIX",$J)
 Q
 ;
UPDATE ;
 N DATE,IEN,PARENT,PROV,PKG,PKGNUM
 S DATE=$$INSTDT("ORDER ENTRY/RESULTS REPORTING 3.0")
 S DATE=$S(DATE:$$FMADD^XLFDT(DATE,-1,23,59),1:2960630.24) ;If install date not found revert back to 1st possible install date
 S IEN=$$GETIEN(DATE)-1 ;Get first order number for date, subtract one so the first order is reviewed
 I IEN=-1 S ERR="No orders in date range" Q  ;No orders to review
 S CNT=0
 F  S IEN=$O(^OR(100,IEN)) Q:'+IEN  D
 .Q:+$P(^OR(100,IEN,0),U,4)'=0  ;Quit if order is ok (provider '= 0)
 .S PKGNUM=$P(^OR(100,IEN,0),U,14)
 .S PKG=$E($$NMSP^ORCD(PKGNUM),1,2) ;Get first two characters of Package
 .I PKG="LR"&($P(^OR(100,IEN,0),U,2)'["DPT") Q  ;Stop if lab and not from patient file
 .I PKG="LR"!(PKG="PS") D  Q  ;If package lab or pharmacy then check
 ..S PROV=$$CHKPAR
 ..I PROV D
 ...S ^TMP("ORFIX",$J,PKGNUM,IEN)=" - FIXED"
 ...S $P(^OR(100,IEN,0),U,4)=PROV
 ...S CNT=CNT+1
 ...D CHKACT ;Check actions to be sure they have provider entered
 Q
 ;
CHKPAR() ;Check to see if there is a parent order and if so, return provider
 S PARENT=$P(^OR(100,IEN,3),U,9)
 I '+PARENT Q 0  ;No parent order found
 S PROV=$P(^OR(100,PARENT,0),U,4)
 I '+PROV Q 0  ;No provider found in parent order
 Q PROV
 ;
CHKACT ;Check actions for missing provider as well
 N I
 S I=0 F  S I=$O(^OR(100,IEN,8,I)) Q:'+I  D
 .I $P(^OR(100,IEN,8,I,0),U,3)=0 S $P(^(0),U,3)=PROV
 Q
GETIEN(STDT) ;Find first IEN associated with given start date
 N DONE,IEN
 S (DONE,IEN)=0
 F  S STDT=$O(^OR(100,"AF",STDT)) Q:'+STDT!(DONE)  D
 .S IEN=0 F  S IEN=$O(^OR(100,"AF",STDT,IEN)) Q:'+IEN  I $O(^(IEN,0))=1 S DONE=1 Q  ;Find first ORDER that is a new order
 Q IEN
 ;
MAIL ;Send results of cleanup in a mail message to initiator
 N I,XMSUB,XMTEXT,XMDUZ,XMY,PKG,ORD
 S XMSUB="Patch OR*3*158 Clean up completed"
 S XMDUZ="Patch OR*3*158 Post-Init"
 S XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S XMTEXT="^TMP(""ORTXT"",$J,"
 K ^TMP("ORTXT",$J)
 S I=1
 S ^TMP("ORTXT",$J,I)="The database clean-up for patch OR*3*158 has completed.",I=I+1
 S ^TMP("ORTXT",$J,I)="Below is a listing of what was changed and any possible error messages.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 S ^TMP("ORTXT",$J,I)=CNT_" orders had their provider field updated.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 I $D(ERR) D
 .S ^TMP("ORTXT",$J,I)="An error occurred that stopped the post-init.  It was:",I=I+1
 .S ^TMP("ORTXT",$J,I)=ERR,I=I+1
 .S ^TMP("ORTXT",$J,I)="",I=I+1
 I '$D(ERR),'CNT S ^TMP("ORTXT",$J,I)="No changes were made to your database.",I=I+1
 S ^TMP("ORTXT",$J,I)="",I=I+1
 S PKG=0 F  S PKG=$O(^TMP("ORFIX",$J,PKG)) Q:PKG=""  D
 .S ^TMP("ORTXT",$J,I)=$P(^DIC(9.4,PKG,0),U),I=I+1
 .S ORD=0 F  S ORD=$O(^TMP("ORFIX",$J,PKG,ORD)) Q:ORD=""  D
 ..S ^TMP("ORTXT",$J,I)="   ORDER #: "_ORD_" "_^TMP("ORFIX",$J,PKG,ORD),I=I+1
 .S ^TMP("ORTXT",$J,I)="",I=I+1
 D ^XMD ;send results
 K ^TMP("ORTXT",$J)
 Q
 ;
INSTDT(PATCH) ;Returns installation date patch first installed at site
 N IEN
 S IEN=$O(^XPD(9.7,"B",PATCH,0)) Q:'+IEN 0 ;Get IEN of first installation
 Q $P($P($G(^XPD(9.7,IEN,1)),U),".")  ;Get date of first install

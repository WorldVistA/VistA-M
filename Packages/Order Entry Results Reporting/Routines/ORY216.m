ORY216 ;SLC/MKB - Clean-up existing Allergy orders ;3/16/04  14:28
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**216**;Dec 17, 1997
 ;
POST ; -- postinit
 N ORDG,ORX S ORDG=+$O(^ORD(100.98,"B","ALG",0)) Q:ORDG'>0
 S $P(^ORD(100.98,ORDG,0),U,4)="" ;clear Default Dialog
 S ORX("GMRAOR ALLERGY ENTER/EDIT")="" D EN^ORYDLG(216,.ORX)
 D TASK
 Q
 ;
TASK ; -- queue job to complete ART orders
 Q:$G(^XTMP("ORGMRA","PAT"))<0  ;already done
 N ZTDESC,ZTRTN,ZTIO,ZTSAVE,ZTDTH,ZTSK,ORMSG
 S ORMSG(1)="A background job has been queued to complete any currently active"
 S ORMSG(2)="Allergy/Adverse Reaction orders." D MES^XPDUTL(.ORMSG)
 S ZTDESC="Mark ART orders as complete",ZTRTN="EN^ORY216"
 S ZTIO="",ZTDTH=$H,ZTSAVE("DUZ")="" D ^%ZTLOAD K ORMSG
 S ORMSG="Task "_$S($G(ZTSK):"#"_ZTSK,1:"not")_" started."
 D MES^XPDUTL(ORMSG)
 I '$G(ZTSK) D BMES^XPDUTL("Use TASK^ORY216 to queue this job to complete ART orders as soon as possible!")
 Q
 ;
EN ; -- main loop to complete ART orders on:
 ;      ^OR(100,"ACT",ORVP,invORLOG,ORDG,ORIFN)
 ;
 N ORDG,ORNOW,ORVP,ORLOG,ORIFN
 S ORDG=+$O(^ORD(100.98,"B","ALG",0)) Q:ORDG'>0
 S ORNOW=+$E($$NOW^XLFDT,1,12),ORVP=$G(^XTMP("ORGMRA","PAT")) I '$D(^(0)) D
 . S ^XTMP("ORGMRA",0)=$$FMADD^XLFDT(ORNOW,90)_U_ORNOW_"^ART orders completion"
 F  S ORVP=$O(^OR(100,"ACT",ORVP)) Q:ORVP=""  D  Q:$G(ZTSTOP)
 . S ORLOG=0 F  S ORLOG=$O(^OR(100,"ACT",ORVP,ORLOG)) Q:ORLOG'>0  D
 .. S ORIFN=0 F  S ORIFN=+$O(^OR(100,"ACT",ORVP,ORLOG,ORDG,ORIFN)) Q:ORIFN'>0  D
 ... Q:$P($G(^OR(100,ORIFN,3)),U,3)=2  ;already completed
 ... D STATUS^ORCSAVE2(ORIFN,2) S $P(^OR(100,ORIFN,6),U,6)=ORNOW
 . S ^XTMP("ORGMRA","PAT")=ORVP
 . I $D(ZTQUEUED) S:$$S^%ZTLOAD ZTSTOP=1 Q:$G(ZTSTOP)
 I '$G(ZTSTOP) S ^XTMP("ORGMRA","PAT")=-1 D MAIL ;done
 Q
 ;
MAIL ; -- Send completion message to user who initiated conversion
 N XMSUB,XMTEXT,XMDUZ,XMY,XMZ,XMMG,ORTXT,DIFROM
 S XMDUZ="PATCH OR*3*216 ART ORDERS COMPLETION",XMY(.5)="" S:$G(DUZ) XMY(DUZ)=""
 S ORTXT(1)="The task triggered by patch OR*3*216"_$S($G(ZTSK):" (Task #"_ZTSK_")",1:"")_" to complete ART orders"
 S ORTXT(2)="finished at "_$$FMTE^XLFDT($$NOW^XLFDT)_"."
 S XMTEXT="ORTXT(",XMSUB="PATCH OR*3*216 ART ORDERS COMPLETED"
 D ^XMD
 Q

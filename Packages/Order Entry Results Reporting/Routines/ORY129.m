ORY129 ;SLC/MKB - Postinit for patch OR*3*129 ;12/11/01  11:04
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**129**;Dec 17, 1997
 ;
POST ; -- postinit
 N IFN,X S IFN=+$P($G(^OR(100,0)),U,3)
 F  S IFN=$O(^OR(100,IFN)) Q:IFN?1"A".E  I IFN[";" S X=$G(^(IFN,5)) S:$L(X) ^OR(100,+IFN,5)=X K ^OR(100,IFN,5)
 D TASK
 Q
 ;
TASK ; -- task cleanup of AC xref
 N ORMSG,ZTDESC,ZTRTN,ZTIO,ZTDTH,ZTSK
 S ORMSG(1)="Please queue the background job to clean up changed orders in the",ORMSG(2)="Active Orders index on file #100."
 D MES^XPDUTL(.ORMSG) K ORMSG
 S ZTDESC="Cleanup AC xref on Orders file #100",ZTIO=""
 S ZTRTN="EN^ORY129" D ^%ZTLOAD
 S ORMSG="Task "_$S($G(ZTSK):"#"_ZTSK,1:"not")_" queued."
 D MES^XPDUTL(ORMSG) I '$G(ZTSK) D BMES^XPDUTL("Use TASK^ORY129 to run this job later, if needed.")
 Q
 ;
EN ; -- main conversion loop
 N ORIDX,ORPSJ,ORIFN,ORDA,OR0,OR3,OR8
 S ORIDX="^OR(100,""AC"")",ORPSJ=+$O(^DIC(9.4,"C","PSJ",0))
 F  S ORIDX=$Q(@ORIDX) Q:ORIDX'?1"^OR(100,""AC"",".E  D
 . S ORIFN=+$P(ORIDX,",",5),ORDA=+$P(ORIDX,",",6)
 . S OR0=$G(^OR(100,ORIFN,0)),OR3=$G(^(3)),OR8=$G(^(8,ORDA,0))
 . I $P(OR8,U,15)=12 D SETALL^ORDD100(ORIFN) Q  ;reset AC xref
 . I $P(OR0,U,14)=ORPSJ,$P(OR8,U,2)="XX",$P(OR3,U,7)=ORDA D MSG^ORMBLD(ORIFN_";"_ORDA,"NA") ;update order number
 Q

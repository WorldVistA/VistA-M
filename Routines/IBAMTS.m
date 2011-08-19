IBAMTS ;ALB/CPM - APPOINTMENT EVENT DRIVER INTERFACE ;20-JUL-93
 ;;2.0;INTEGRATED BILLING;**52,115,132,153,164,156,171,247,312,341,339**;21-MAR-94;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;
EN ; Main interface entry point.
 ;
 N IBSWINFO S IBSWINFO=$$SWSTAT^IBBAPI()                   ;IB*2.0*312
 I '$G(DUZ) D DUZ^XUP(.5)                                  ;IB*2.0*341 Setting of DUZ covered by IA 4129
 ;
 S IBJOB=5,IBWHER="",IBDUZ=DUZ,IBY=1
 ; Do Transfer Pricing
 I '+IBSWINFO D ^IBATEO                                    ;IB*2.0*312
 ; Check Encounter Related to LTC
 N IBALTC D EN^IBAECO
 I '$$BILST^DGMTUB(DFN) G ENQ ; never Means Test billable
 I '$$CHECK^IBECEAU(0) D ^IBAERR1 G ENQ ; can't set vital parameters
 ;
 ; - process all parent outpatient encounters
 S IBORG=0 F  S IBORG=$O(^TMP("SDEVT",$J,SDHDL,IBORG)) Q:'IBORG  D
 .S IBOE=0 F  S IBOE=$O(^TMP("SDEVT",$J,SDHDL,IBORG,"SDOE",IBOE)) Q:'IBOE  S IBEVT=$G(^(IBOE,0,"AFTER")),IBEV0=$G(^("BEFORE")) D
 ..;
 ..S IBDT=$S(IBEVT:+IBEVT,1:+IBEV0),IBDAT=$P(IBDT,".")
 ..; Do NOT PROCESS on VistA if IBDAT>=Switch Eff Date    ;CCR-930
 ..I +IBSWINFO,(IBDAT+1)>$P(IBSWINFO,"^",2) Q             ;IB*2.0*312
 ..;
 ..S IBAPTY=$S(IBEVT:$P(IBEVT,"^",10),1:$P(IBEV0,"^",10))
 ..S IBBILLED=$$BFO^IBECEAU(DFN,IBDAT),IBY=1
 ..;
 ..; - if C&P encounter, cancel charges for the day and quit
 ..I IBAPTY=1!(IBALTC) D:IBBILLED  Q
 ...S IBCRES=+$O(^IBE(350.3,"B",$S(IBALTC:"BILLED LTC CHARGE",1:"COMP & PENSION VISIT RECORDED"),0))
 ...S:'IBCRES IBCRES=23 S IBWHER=""
 ...D CANCH^IBECEAU4(IBBILLED,IBCRES,0)
 ..;
 ..; - quit if there are any C&P encounters on the visit date
 ..Q:$$CNP^IBECEAU(DFN,IBDAT)
 ..;
 ..; - quit if there are any LTC encounters on the visit date
 ..Q:$$LTCENC^IBAECU(DFN,IBDAT)
 ..;
 ..; - don't process child events
 ..I IBEVT]"" Q:$P(IBEVT,"^",6)
 ..I IBEVT="",IBEV0]"" Q:$P(IBEV0,"^",6)
 ..;
 ..; - get statuses
 ..S IBAST=+$P(IBEVT,"^",12),IBBST=+$P(IBEV0,"^",12)
 ..;
 ..; - do either NEW or UPDATED processing
 ..I IBAST=2,IBBST'=2 D NEW^IBAMTS1 Q
 ..D UPD^IBAMTS2
 ;
ENQ K IBJOB,IBWHER,IBORG,IBOE,IBEVT,IBEV0,IBAST,IBBST,IBDUZ,IBY
 K IBDT,IBDAT,IBAPTY,IBBILLED,IBSERV,IBSITE,IBFAC,IBCRES,IBRTED
 Q
 ;
BULL ; Send bulletin when classified patients are billed stops which
 ; are exempt from the classification process.
 N IBT,IBC,IBPT,IBDUZ,IBX S IBPT=$$PT^IBEFUNC(DFN),IBX=$$CLTY
 S XMSUB="CHARGE FOR STOP CODE EXEMPT FROM CLASSIFICATION"
 S IBT(1)="The following patient, who "_$S(IBX="SC":"has a service connected disability,",IBX="CV":"is Combat Veteran",1:"has claimed exposure to "_IBX_",")
 S IBT(2)="was billed the Means Test outpatient copay for a stop code which is"
 S IBT(3)="exempt from classification:"
 S IBT(4)=" " S IBC=4
 S IBDUZ=DUZ D PAT^IBAERR1
 S Y=IBDAT D DD^%DT
 S IBC=IBC+1,IBT(IBC)="Stop Date: "_Y
 S IBC=IBC+1,IBT(IBC)="Stop Code: "_$P($G(^DIC(40.7,+$P(IBEVT,"^",3),0)),"^")
 S IBC=IBC+1,IBT(IBC)=" "
 S IBC=IBC+1,IBT(IBC)="Please check this patient's medical record to determine if the care provided"
 S IBC=IBC+1,IBT(IBC)="was related to the "_$S(IBX="SC":"SC disability",IBX="CV":"Combat Veteran status",1:"claimed exposure")_", and, if related, cancel the charge."
 D MAIL^IBAERR1
 K X,Y,XMSUB,XMY,XMTEXT,XMDUZ
 Q
 ;
CLTY() ; Return the classification type
 N IBARR,Y D CL^SDCO21(DFN,IBDAT,"",.IBARR) S Y=""
 I $D(IBARR(3)) S Y="SC" G CLTYQ
 I $D(IBARR(7)),+$$CVEDT^IBACV(DFN,IBDAT) S Y="CV" G CLTYQ
 I $D(IBARR(1)) S Y="Agent Orange" G CLTYQ
 I $D(IBARR(2)) S Y="Ionizing Radiation" G CLTYQ
 I $D(IBARR(4)) S Y="Southwest Asia" G CLTYQ
 I $D(IBARR(8)) S Y="Project 112/SHAD" G CLTYQ
 I $D(IBARR(5)) S Y="Military Sexual Trauma" G CLTYQ
 I $D(IBARR(6)) S Y="Head/Neck Cancer" G CLTYQ
CLTYQ Q Y

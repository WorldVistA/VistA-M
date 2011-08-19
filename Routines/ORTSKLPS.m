ORTSKLPS ;SLC/JMH-nightly task to lapse old unsigned orders ;03/11/10  07:52
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**243,280**;Dec 17, 1997;Build 85
 ;
TASK ;
 ;only run between Midnight and 1:59:59 AM
 ;I $E($P($$NOW^XLFDT,".",2),1,2)>1 Q
 ;don't run if run recently (within 4 hours)
 ;I $$FMDIFF^XLFDT($$NOW^XLFDT,$G(^XTMP("OR LAPSE ORDERS","LAST TIME")),2)<14400 Q
 ;set timestamp of last run
 S ^XTMP("OR LAPSE ORDERS",0)=$$FMADD^XLFDT($$NOW^XLFDT,2)_U_$$NOW^XLFDT
 S ^XTMP("OR LAPSE ORDERS","LAST TIME")=$$NOW^XLFDT
 ;loop through unsigned orders
 N ORVP,ORDT,ORN,ORACT,ORINVDT,ORPARAM,ORDIAL,ORDISP
 S ORVP="" F  S ORVP=$O(^OR(100,"AS",ORVP)) Q:'$L(ORVP)  D
 .S ORINVDT=0 F  S ORINVDT=$O(^OR(100,"AS",ORVP,ORINVDT)) Q:'ORINVDT  D
 ..S ORDT=9999999-ORINVDT
 ..S ORN=0 F  S ORN=$O(^OR(100,"AS",ORVP,ORINVDT,ORN)) Q:'ORN  D
 ...;don't lapse if order does not have a status of unreleased (11)
 ...Q:$P($G(^OR(100,ORN,3)),U,3)'=11
 ...;get order action
 ...S ORACT=$O(^OR(100,"AS",ORVP,ORINVDT,ORN,""))
 ...;get order dialog
 ...S ORDIAL=$P($G(^OR(100,ORN,0)),U,5)
 ...I $P(ORDIAL,";",2)='"ORD(101.41," Q
 ...;using order dialog get display group
 ...S ORDISP=$P($G(^ORD(101.41,+ORDIAL,0)),U,5)
 ...I +ORDISP S ORDISP=$P($G(^ORD(100.98,+ORDISP,0)),U)
 ...;get lapse parameter for display group
 ...I $L(ORDISP) S ORPARAM=$$GET^XPAR($$ENT(ORN),"OR LAPSE ORDERS",ORDISP)
 ...;get default lapse parameter if one for display group not set
 ...I '$G(ORPARAM) S ORPARAM=$$GET^XPAR($$ENT(ORN),"OR LAPSE ORDERS DFLT")
 ...;quit if ORPARAM isn't even set
 ...Q:'$L(ORPARAM)
 ...;quit if order is not older than T-(days for lapse)
 ...I $$FMDIFF^XLFDT($$NOW^XLFDT,ORDT,2)<(ORPARAM*24*60*60) Q
 ...;if old then lapse
 ...D LAPSE^ORCSAVE2(ORN_";"_ORACT)
 ;loop through pending events
 N ORPT,OREVT,ORPTR,Y
 S ORPT="" F  S ORPT=$O(^ORE(100.2,"AE",ORPT)) Q:'ORPT  D
 .S OREVT="" F  S OREVT=$O(^ORE(100.2,"AE",ORPT,OREVT)) Q:'OREVT  D
 ..S ORPTR="" F  S ORPTR=$O(^ORE(100.2,"AE",ORPT,OREVT,ORPTR)) Q:'ORPTR  S Y=$$LAPSED^OREVNTX(ORPTR)
 Q
ENT(ORN) ;get the proper entity for an order
 N ORRET,ORHS,ORDIV
 S ORRET="ALL"
 S ORHS=$P(^OR(100,ORN,0),U,10)
 I $G(ORHS)>0 S ORDIV=$P(^SC(+ORHS,0),U,4)
 I $G(ORDIV)>0 S ORRET=ORDIV_";DIC(4,^SYS^PKG"
 Q ORRET

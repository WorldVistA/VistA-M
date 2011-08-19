ORQQCN ; slc/CLA/REV - Functions which return patient consult requests and results ;08:19 AM 20 FEB 2001
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**10,85**;Dec 17, 1997
LIST(ORY,ORPT,ORSDT,OREDT,ORSERV,ORSTATUS) ; return patient's consult requests between start date and stop date for the service and status indicated:
 N I,J,SITE,SEQ,DIFF,ORSRV,ORLOC,GMRCOER
 S J=1,SEQ="",GMRCOER=2
 S:'$L($G(ORSDT)) ORSDT=""
 S:'$L($G(OREDT)) OREDT=""
 S:'$L($G(ORSERV))!(+$G(ORSERV)=0) ORSERV=""
 S:'$L($G(ORSTATUS)) ORSTATUS="" ;ALL STATI
 K ^TMP("GMRCR",$J)
 S ORY=$NA(^TMP("ORQQCN",$J,"CS"))
 D OER^GMRCSLM1(ORPT,ORSERV,ORSDT,OREDT,ORSTATUS,GMRCOER)
 M @ORY=^TMP("GMRCR",$J,"CS")
 K @ORY@("AD")
 K @ORY@(0)
 K ^TMP("GMRCR",$J)
 Q
DETAIL(ORQY,CONSULT) ; return formatted consult request details (plus result note if available):
 N GMRCOER
 S GMRCOER=2
 S ORQY=$NA(^TMP("GMRCR",$J,"DT"))
 D DT^GMRCSLM2(CONSULT)
 Q
 ;

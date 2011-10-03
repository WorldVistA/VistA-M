SDSCLM ;ALB/JAM/RBS - ASCD Encounter LISTMAN ; 3/7/07 12:42pm
 ;;5.3;Scheduling;**495**;Aug 13, 1993;Build 50
 ;;MODIFIED FOR NATIONAL RELEASE from a Class III software product
 ;;known as Service Connected Automated Monitoring (SCAM).
 ;
 Q
EN ; -- main entry point for SDSC REVIEW
 N SDSCEDIT S SDSCEDIT=1
 D EN^VALM("SDSC REVIEW")
 Q
 ;
HDR ; -- header code
 S VALMHDR(1)="The Service Connected status needs to be reviewed for the following encounters."
 S VALMHDR(2)="Selected Date Range: "_$$FMTE^XLFDT(SDSCBDT,"1Z")_" - "_$$FMTE^XLFDT(SDEDT,"1Z")
 S VALMHDR(3)=" "
 Q
 ;
INIT ; -- init variables and list array
 ;
RBLD ;  Rebuild
 N SDSCDIV
 D CLEAN^VALM10
 K ^TMP("SDSCENC",$J),^TMP($J,"SDSCENC")
 S SDSCDIV=$S(SDSCDVSL'[SDSCDVLN:","_SDSCDVSL,1:"")
 S SDCNT=0
 I SDSCTAT'="" D RBLD1
 I SDSCTAT="" D  S SDSCTAT=""
 . F SDSCTAT="N","R","C" D RBLD1
 ;
 ; -- set null message
 I 'SDCNT D
 . D SET^VALM10(1," ")
 . D SET^VALM10(2," >>> No Encounter's to review for Date Range selected.")
 . S ^TMP($J,"SDSCENC",1)=1,^(2)=2
 ;
 S VALMCNT=$S(SDCNT<1:1,1:SDCNT)
 Q
RBLD1 ;
 N SDOEDT,SDOEDAT,STATUS,SDOE,SDECDT,SDPAT,X,DFN,SDERR,VADM,SCVST,SDV0
 S SDOEDT=SDSCTDT,STATUS=$$EXTERNAL^DILFD(409.48,.05,"F",SDSCTAT,"SDERR")
 F  S SDOEDT=$O(^SDSC(409.48,"C",SDSCTAT,SDOEDT)) Q:SDOEDT=""!(SDOEDT\1>SDEDT)  D
 . S SDOE=""
 . F  S SDOE=$O(^SDSC(409.48,"C",SDSCTAT,SDOEDT,SDOE)) Q:SDOE=""  D
 .. I SDSCDIV'="",(","_SDSCDIV_",")'[(","_$P(^SDSC(409.48,SDOE,0),U,12)_",") Q
 .. S SDOEDAT=$G(^SCE(SDOE,0)) Q:SDOEDAT=""
 .. S SDV0=$P(SDOEDAT,U,5),SCVST=$$GET1^DIQ(9000010,SDV0_",",80001,"I")
 .. I SCVST'=SCOPT,SCOPT'=2 Q
 .. S SDCNT=SDCNT+1
 .. S SDECDT=$P(SDOEDAT,U,1),SDPAT=$P(SDOEDAT,U,2)
 .. S SDECDT=$$FMTE^XLFDT(SDECDT,"5Z")
 .. S DFN=SDPAT D DEM^VADPT
 .. S SDPAT=$E(VADM(1),1,25)_" ("_$E($P(VADM(2),U),6,9)_")"
 .. S X=$$SETFLD^VALM1(SDCNT," ","LINENUM")
 .. S X=$$SETFLD^VALM1(SDOE,X,"ENCNO")
 .. S X=$$SETFLD^VALM1(SDECDT,X,"ENCDT")
 .. S X=$$SETFLD^VALM1(SDPAT,X,"PAT")
 .. S X=$$SETFLD^VALM1(STATUS,X,"STAT")
 .. S ^TMP($J,"SDSCENC",SDCNT)=SDOE
 .. D SET^VALM10(SDCNT,X)
 D KVA^VADPT
 Q
 ;
HELP ; -- help code
 N X
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 K VALMHDR,VALMCNT
 K ^TMP("SDSCENC",$J),^TMP($J,"SDSCENC")
 K SDCNT,SDEDT,SDSCBDT,SDSCDVLN,SDSCDVSL,SDSCEDT,SDSCTAT,SDSCTDT
 Q
 ;
EXPND ; -- expand code
 Q

DGFFPLM ; ALB/GAH - FUGITIVE FELON PROGRAM LM INQUIRY ; 10-10-2006
 ;;5.3;Registration;**485,725**;Aug 13, 1993;Build 12
EN ; -- main entry point for DGFFP PATIENT STATUS INQUIRY
 N DFN,VALMCNT
 ;
 D SEL^DGFFPLM1(.DFN)
 Q:DFN'>0
 D EN^VALM("DGFFP PATIENT STATUS INQUIRY")
 Q
 ;
HDR ; -- header code
 N VA,X
 ;
 D PID^VADPT
 S VALMHDR(1)=$E("Patient: "_$P($G(^DPT(DFN,0)),U),1,30)_" ("_VA("PID")_")"
 S VALMHDR(2)=$S($D(^DPT("AXFFP",1,DFN)):"Fugitive Flag Set",1:"")
 S VALMHDR(3)=$$LASTACT(DFN)
 Q
 ;
INIT ; -- init variables and list array
 N VALMBCK
 D BLD
 Q
 ;
BLD ; Build patient fugitive felon program screen
 D CLEAN^VALM10
 K ^TMP("DGFFPLM",$J)
 ;
 D HDR
 D EN^DGFFPLM1(DFN,"DGFFPLM",1,.VALMCNT)
 Q
 ;
HELP ; -- help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ; -- exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP("DGFFPLM",$J)
 Q
 ;
EXPND ; -- expand code
 Q
 ;
LASTACT(DFN) ;
 N DGCLNME,DGDT,ERRCODE,NEWDAT,OLDDAT,RSLT,SDARRAY,SDCOUNT
 ;
 S DGDT=$$NOW^XLFDT
 S SDARRAY(4)=DFN
 S SDARRAY(1)=";"_DGDT
 S SDARRAY("FLDS")=1
 S SDCOUNT=$$SDAPI^SDAMA301(.SDARRAY)  ;Get all appointments for the patient
 I SDCOUNT>0 D     ;Get the last appointment date and client if records found
 . S DGCLN="",DGDT=0
 . F  S DGCLN=$O(^TMP($J,"SDAMA301",DFN,DGCLN)) Q:DGCLN=""  D
 . . S NEWDAT=+$O(^TMP($J,"SDAMA301",DFN,DGCLN,""),-1)
 . . I NEWDAT>DGDT S DGDT=NEWDAT,DGCLNME=DGCLN
 . S RSLT="Last Appointment: "_$$FMTE^XLFDT(DGDT,"1P")_"   Clinic: "_DGCLNME
 I SDCOUNT<0 S ERRCODE=$O(^TMP($J,"SDAMA301","")) I ERRCODE'="" S RSLT="Last Appointment: "_$G(^TMP($J,"SDAMA301",ERRCODE))
 K ^TMP($J,"SDAMA301")
 Q $G(RSLT)
 ;
PAT ; Entry point for DGFFP CHANGE PATIENT PROTOCOL
 ; Input  - None
 ; Output - DFN      Patient IEN
 ;          VALMBCK  R = Refresh screen
 ;
 N DGDFN
 S VALMBCK=""
 D FULL^VALM1
 ;
 ; Get new patient
 D SEL^DGFFPLM1(.DGDFN)
 ;
 I DGDFN>0 D
 . S DFN=DGDFN
 . D BLD^DGFFPLM
 S VALMBCK="R"
 Q

DGENL ;ALB/RMO - Patient Enrollment - List Manager Screen;12 JUN 1997 10:00 am
 ;;5.3;Registration;**121,147**;08/13/93
 ;
EN(DFN) ;Main entry point to invoke the DGEN PATIENT ENROLLMENT protocol
 ; Input  -- DFN      Patient IEN
 ; Output -- None
 D WAIT^DICD
 D EN^VALM("DGEN PATIENT ENROLLMENT")
 Q
 ;
HDR ;Header code
 N DGPREFNM,X,VA,VAERR
 D PID^VADPT
 S VALMHDR(1)=$E("Patient: "_$P($G(^DPT(DFN,0)),U),1,30)_" ("_VA("BID")_")"
 S X=$S('$D(^DPT(DFN,"TYPE")):"PATIENT TYPE UNKNOWN",$D(^DG(391,+^("TYPE"),0)):$P(^(0),U,1),1:"PATIENT TYPE UNKNOWN")
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),60,80)
 I $$PREF^DGENPTA(DFN,.DGPREFNM)
 S VALMHDR(2)="Preferred Facility: "_$G(DGPREFNM)
 S VALMHDR(2)=$$SETSTR^VALM1("Current Enrollment",VALMHDR(2),60,80)
 Q
 ;
INIT ;Init variables and list array
 D BLD
 Q
 ;
BLD ;Build patient enrollment screen
 D CLEAN^VALM10
 K ^TMP("DGENIDX",$J),VALMHDR
 S VALMBG=1,VALMCNT=0
 ;
 ;Build header
 D HDR
 ;
 ;Build list area for current enrollment
 D EN^DGENL1("DGEN",DFN,$$FINDCUR^DGENA(DFN),.VALMCNT)
 D MESSAGE(DFN)
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP("DGENIDX",$J)
 Q
 ;
EXPND ;Expand code
 Q
 ;
MESSAGE(DFN) ;
 ;Description: Sets VALMMSG to a custom message for the screen's message
 ; window that is the status of the last enrollment query
 ;
 N DGQRY,STATUS,NOTIFY
 S DGQRY=$$FINDLAST^DGENQRY(DFN)
 I $$GET^DGENQRY(DGQRY,.DGQRY)
 S STATUS=$$EXTERNAL^DILFD(27.12,.03,"F",DGQRY("STATUS"))
 S NOTIFY=$$EXTERNAL^DILFD(27.12,.08,"F",DGQRY("NOTIFY"))
 S VALMSG="Query: "_STATUS
 S $E(VALMSG,28)="Notify: "_NOTIFY
 Q

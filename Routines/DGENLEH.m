DGENLEH ;ALB/RMO - Patient Enrollment History - List Manager Screen;12 JUN 1997 10:00 am
 ;;5.3;Registration;**121**;08/13/93
 ;
EN(DFN,DGENRIEN) ;Main entry point to invoke the DGEN PATIENT ENROLL HISTORY protocol
 ; Input  -- DFN      Patient IEN
 ;           DGENRIEN Enrollment IEN
 ; Output -- None
 D WAIT^DICD
 D EN^VALM("DGEN PATIENT ENROLL HISTORY")
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
 S VALMHDR(2)=$$SETSTR^VALM1("Prior Enrollment",VALMHDR(2),60,80)
 Q
 ;
INIT ;Init variables and list array
 D BLD
 Q
 ;
BLD ;Build patient enrollment screen
 D CLEAN^VALM10
 K ^TMP("DGENEHIDX",$J)
 ;
 ;Build header
 D HDR
 ;
 ;Build list area for select enrollment history
 D EN^DGENL1("DGENEH",DFN,DGENRIEN,.VALMCNT)
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP("DGENEHIDX",$J)
 Q
 ;
EXPND ;Expand code
 Q
 ;

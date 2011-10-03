DGENLCD ;ALB/CJM - Enrollment Catastophic Disability - List Manager Screen;12 JUN 1997 10:00 am
 ;;5.3;Registration;**121**;08/13/93
 ;
EN(DFN) ;Entry point for the DGENCD CATASTROPHIC DISABILTY List Template
 ; Input  -- DFN      Patient IEN
 ; Output -- None
 ;
 Q:'$G(DFN)
 D WAIT^DICD
 D EN^VALM("DGENCD CATASTROPHIC DISABILITY")
 Q
 ;
INIT ;Init variables and list array
 D CLEAN^VALM10
 S VALMCNT=0
 D EN^DGENLCD1("DGEN CD",DFN,.VALMCNT)
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 Q
 ;
EXPND ;Expand code
 Q
 ;
HDR ;Header code
 N DGPREFNM,X,VA,VAERR
 D PID^VADPT
 S VALMHDR(1)=$E("Patient: "_$P($G(^DPT(DFN,0)),U),1,30)_" ("_VA("BID")_")"
 S X=$S('$D(^DPT(DFN,"TYPE")):"PATIENT TYPE UNKNOWN",$D(^DG(391,+^("TYPE"),0)):$P(^(0),U,1),1:"PATIENT TYPE UNKNOWN")
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),60,80)
 Q

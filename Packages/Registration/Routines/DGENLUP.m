DGENLUP ;ALB/CJM - Eligibilty Upload Audit - List Manager Screen;12 JUN 1997 10:00 am
 ;;5.3;Registration;**147**;08/13/93
 ;
EN(DFN,DGAUDIT) ;Entry point for the DGENCD CATASTROPHIC DISABILTY List Template
 ; Input:
 ;  DFN     - Patient IEN
 ;  DGAUDIT - ien of record in the Enrollment/Eligibilty Upload Audit file
 ; Output -- None
 ;
 Q:'$G(DFN)
 D WAIT^DICD
 D EN^VALM("DGENUP VIEW UPLOAD AUDIT")
 Q
 ;
INIT ;Init variables and list array
 D CLEAN^VALM10
 S VALMCNT=0
 S VALMAR="^DGENA(27.14,"_DGAUDIT_",1)"
 S VALMCNT=$P($G(^DGENA(27.14,DGAUDIT,1,0)),"^",3)
 Q
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 S VALMAR="DGAUDIT"
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
 S VALMHDR(2)="Message ID: "_$P($G(^DGENA(27.14,+$G(DGAUDIT),0)),"^")
 S VALMHDR(3)="Approx DT/TM UPLOAD: "_$P($G(^DGENA(27.14,+$G(DGAUDIT),0)),"^",2)
 Q

DGMTHL ;ALB/CJM,SCG,TMK - Hardship Determinations - List Manager Screen; 1/02/2002
 ;;5.3;Registration;**182,344,435,467,536**;08/13/93;Build 3
 ;
HARDSHIP ;Entry point for hardships
 ; Input  -- None
 ; Output -- None
 N DFN,DGSITE,MTIEN,SGHRD,DGOK,DGDUZ
 ;
 ;Get Patient file (#2) IEN - DFN
 D GETPAT^DGRPTU(,,.DFN,) G ENQ:DFN<0
 N DGMDOD S DGMDOD=""
 I $P($G(^DPT(DFN,.35)),U)'="" S DGMDOD=$P(^DPT(DFN,.35),U)
 I $G(DGMDOD) W !,"Patient died on: ",$$FMTE^XLFDT(DGMDOD,"1D") Q
 ;
 S (MTIEN,SGHRD,DGSITE)="",DGOK=0
 S MTIEN=$$FIND^DGMTH(DFN,DT)
 S:MTIEN SGHRD=$P($G(^DGMT(408.31,MTIEN,2)),U,4)
 I SGHRD'="" D
 . S DGDUZ=$G(DUZ),DGDUZ(2)=$$CONVERT^DGENUPL1(SGHRD,"INSTITUTION")
 . S DGOK="",DGSITE=$$INST^DGENU(.DGDUZ,.DGOK)
 ;
 I SGHRD,$S(DGSITE=+$G(DUZ(2)):0,1:'DGOK) D  Q
 .W !!?10,"A Hardship has been granted for ",$P(^DPT(DFN,0),U),"."
 .W !?10,"Only the site granting the Hardship may edit it."
 .W !?10,"Please, contact ",$P($G(^DIC(4,+$$CONVERT^DGENUPL1(SGHRD,"INSTITUTION"),0)),U)," to edit the record.",!
 .N DIR S DIR(0)="FAO",DIR("A")="Enter <RETURN> to continue." D ^DIR
 ;
 ;Load patient enrollment screen
 D EN(DFN)
ENQ Q
 ;
EN(DFN) ;Entry point for the DGMT HARDSHIP List Template
 ; Input  -- DFN      Patient IEN
 ; Output -- None
 ;
 Q:'$G(DFN)
 N HARDSHIP
 D WAIT^DICD
 D EN^VALM("DGMTH HARDSHIP")
 Q
 ;
INIT ;Init variables and list array
 N MTIEN
 S MTIEN=$$FIND^DGMTH(DFN,DT)
 I $$GET^DGMTH(MTIEN,.HARDSHIP) ;setup hardship array
 D CLEAN^VALM10
 S VALMCNT=0
 D EN^DGMTHL1("DGMTH HARDSHIP",.HARDSHIP,.VALMCNT)
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
 N X,VA,VAERR
 D PID^VADPT
 S VALMHDR(1)=$E("Patient: "_$P($G(^DPT(DFN,0)),U),1,30)_" ("_VA("BID")_")"
 S X=$S('$D(^DPT(DFN,"TYPE")):"PATIENT TYPE UNKNOWN",$D(^DG(391,+^("TYPE"),0)):$P(^(0),U,1),1:"PATIENT TYPE UNKNOWN")
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),60,80)
 Q

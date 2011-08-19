DGDEPE ;ALB/CAW - Extended Display ; 1/28/92
 ;;5.3;Registration;**45**;Aug 13, 1993
 ;
EN ; Selection of dependent
 G ENQ:'$D(DGW)!$G(DGERR)=1
 K DGDEP("DGMTEP",$J)
 S VALMBCK=""
 N DGWIDTH,DGPT,DGSC
 W ! D WAIT^DICD,EN^VALM("DGMT EXPAND PROFILE")
ENQ S VALMBCK="R" Q
 ;
HDR ; Header
 N VA,VAERR
 D PID^VADPT
 S VALMHDR(1)=$E($P("Patient: "_$G(^DPT(DFN,0)),"^",1),1,30)_" ("_VA("BID")_")"
 S X=$S($D(^DPT(DFN,.1)):"Ward: "_^(.1),1:"Outpatient")
 S VALMHDR(1)=$$SETSTR^VALM1(X,VALMHDR(1),81-$L(X),$L(X))
 S X="",VALMHDR(2)=$$SETSTR^VALM1(X,"Dependent #: "_DGW_" "_$P(DGDEP(DGW),U)_"("_$P(DGDEP(DGW),U,2)_")",81-$L(X),$L(X))
 Q
 ;
INIT ;
 N VA,VAERR,DGFSTCOL,DGSECCOL
 D PID^VADPT
 D ONE^DGDEP1(DGW)
 Q
 ;
FNL ;
 D CLEAN^VALM10
 Q

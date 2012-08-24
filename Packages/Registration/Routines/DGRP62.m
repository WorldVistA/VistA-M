DGRP62 ;ALB/PJH,LBD - Patient MSDS History - List Manager Screen;12 JUN 1997 10:00 am ; 6/23/09 3:48pm
 ;;5.3;Registration;**797**;08/13/93;Build 24
 ;
EN(DFN) ;Main entry point to invoke the DGEN PATIENT MSDS VIEW list
 ; Input  -- DFN      Patient IEN
 ;
 D WAIT^DICD
 D EN^VALM("DGEN MSDS PATIENT VIEW")
 Q
 ;
HDR ;Header code
 N DGPREFNM,X,VA,VAERR
 S VALMHDR(1)=$J("",18)_"VISTA MILITARY SERVICE DATA, SCREEN <6.2>"
 D PID^VADPT
 S VALMHDR(2)=$E("Patient: "_$P($G(^DPT(DFN,0)),U),1,30)
 S VALMHDR(2)=VALMHDR(2)_" ("_VA("BID")_")"
 S X="PATIENT TYPE UNKNOWN"
 I $D(^DPT(DFN,"TYPE")),$D(^DG(391,+^("TYPE"),0)) S X=$P(^(0),U,1)
 S VALMHDR(2)=$$SETSTR^VALM1(X,VALMHDR(2),60,80)
 S VALMHDR(3)=$J("",4)_"Service Branch/Component  Service #"
 S VALMHDR(3)=VALMHDR(3)_"        Entered    Separated   Discharge"
 Q
 ;
INIT ;Build patient MSDS screen
 D CLEAN^VALM10
 K ^TMP("DGRP62",$J)
 ;
 N GLBL
 S GLBL=$NA(^TMP("DGRP62",$J))
 D GETMSE(DFN,GLBL,0)
 Q
 ;
GETMSE(DFN,GLBL,NUM) ;Get old format MSE data from node .32
 N DGDATA
 S VALMCNT=0
 S:'$D(DGRP(.32)) DGRP(.32)=$G(^DPT(DFN,.32))
 S:'$D(DGRP(.3291)) DGRP(.3291)=$G(^DPT(DFN,.3291))
 ;Last service episode (SL)
 S DGDATA=$$SETDAT(.DGRP,4)
 D EPISODE^DGRP61(DGDATA,GLBL,NUM)
 ;Next to last service episode (SNL)
 Q:$P(DGRP(.32),U,19)'="Y"
 S DGDATA=$$SETDAT(.DGRP,9)
 D EPISODE^DGRP61(DGDATA,GLBL,NUM)
 ;Prior episode (SNNL)
 Q:$P(DGRP(.32),U,20)'="Y"
 S DGDATA=$$SETDAT(.DGRP,14)
 D EPISODE^DGRP61(DGDATA,GLBL,NUM)
 Q
 ;
SETDAT(DGRP,FLD) ;Set MSE data into DGDATA
 N DGX,DGY
 Q:'$G(FLD) ""
 S DGX=$G(DGRP(.32)) I DGX="" Q ""
 S DGY=$G(DGRP(.3291))
 Q $P(DGX,U,FLD+2)_U_$P(DGX,U,FLD+3)_U_$P(DGX,U,FLD+1)_U_$P(DGY,U,FLD+1/5)_U_$P(DGX,U,FLD+4)_U_$P(DGX,U,FLD)
 ;
 ;
HELP ;Help code
 S X="?" D DISP^XQORM1 W !!
 Q
 ;
EXIT ;Exit code
 D CLEAN^VALM10
 D CLEAR^VALM1
 K ^TMP("DGRP62",$J)
 Q

BPSSCRUD ;BHAM ISC/SS - ECME SCREEN UPDATE DISPLAY ;05-APR-05
 ;;1.0;E CLAIMS MGMT ENGINE;**1**;JUN 2004
 ;; Per VHA Directive 10-93-142, this routine should not be modified.
 Q
 ;
UD ;
 D REDRAW("Updating screen...")
 Q
 ;
 ;
 ;redraw screen
REDRAW(BPTXT) ;
 W !,$S($L($G(BPTXT))>0:$G(BPTXT),1:"Please wait...")
 N BPARR
 D RESTVIEW^BPSSCR01(.BPARR) ;prevent VIES setting stored in TMP from cleanup
 D CLEAN^VALM10
 D SAVEVIEW^BPSSCR01(.BPARR) ;put VIES setting back to TMP
 S VALMCNT=$$INIT^BPSSCR01()
 D HDR^BPSSCR
 S VALMBCK="R"
 Q
 ;

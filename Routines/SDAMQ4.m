SDAMQ4 ;ALB/MJK - AM Background Job/Add/Edit Processing ; 24 Aug 99  9:59 PM
 ;;5.3;Scheduling;**24,132,153,199**;Aug 13, 1993
 ;
EN(SDBEG,SDEND) ; -- count add/edits
 N SDT,SDOE
 S SDT=SDBEG
 F  S SDT=$O(^SCE("B",SDT)) Q:'SDT!(SDT>SDEND)  D
 . S SDOE=0
 . F  S SDOE=$O(^SCE("B",SDT,SDOE)) Q:'SDOE  D CHK(SDOE)
ENQ Q
 ;
CHK(SDOE) ; -- set data in ^tmp if appropriate
 N SDOE0,SDIVNM,SDNAT,X,SDSTOP,SDSTAT
 S SDOE0=$G(^SCE(SDOE,0))
 S SDPAR=+$P(SDOE0,U,6)
 S SDORG=+$P(SDOE0,U,8)
 S SDSTAT=$P(SDOE0,U,12)
 ;
 ; -- do checks
 IF SDPAR G CHKQ                      ; -- quit if has parent
 IF SDORG'=2 G CHKQ                   ; -- quit if no a/e
 IF $$REQ^SDM1A(+SDOE0)'="CO" G CHKQ  ; -- quit if "CO" not required
 IF '$$DIV^SDAMQ(+$P(SDOE0,U,11),.SDIVNM,35) G CHKQ ; -- quit if no division
 ;
 ; -- set ^tmp
 S SDNAT='$$CO^SDAMQ(SDOE) I SDNAT S SDNAT=SDSTAT=14
 S SDSTOP=+$P($G(^DIC(40.7,+$P(SDOE0,U,3),0)),U,2)
 S X=$G(^TMP("SDSTATS",$J,SDIVNM,"AE",SDSTOP))
 S ^TMP("SDSTATS",$J,SDIVNM,"AE",SDSTOP)=(X+SDNAT)_U_($P(X,U,2)+1)
 ;
CHKQ Q
 ;
BULL(SDIVNM,SDLN,SDTOT) ;
 N SDSTOP,SDSTOPN,NAT,GRAND,OTHER,TNAT,TGRAND
 D HDR
 S (OTHER,SDSTOP,TNAT,TGRAND)=0
 F  S SDSTOP=$O(^TMP("SDSTATS",$J,SDIVNM,"AE",SDSTOP)) Q:'SDSTOP  S X=^(SDSTOP) D
 .S NAT=+X,GRAND=+$P(X,U,2)
 .S TNAT=TNAT+NAT,TGRAND=TGRAND+GRAND
 .S SDTOT("DIV","NAT")=SDTOT("DIV","NAT")+NAT
 .S SDTOT("DIV","GRAND")=SDTOT("DIV","GRAND")+GRAND
 .S SDSTOPN=$S($D(^DIC(40.7,+$O(^DIC(40.7,"C",SDSTOP,0)),0)):$P(^(0),U),1:"UNKNOWN")
 .I 'NAT S OTHER=OTHER+GRAND
 .I NAT D LINE^SDAMQ3(SDSTOP_"-"_SDSTOPN,NAT,GRAND)
 D LINE^SDAMQ3("ALL OTHER STOPS",0,OTHER)
 D SET^SDAMQ3("         ---------------               ----------------    -------   -------")
 D LINE^SDAMQ3("Add/Edit Totals",TNAT,TGRAND)
BULLQ Q
 ;
HDR ; -- ae header block
 D SET^SDAMQ3("")
 D SET^SDAMQ3("                                       Add/Edits             Total")
 D SET^SDAMQ3("         Stop Code                     Requiring Action      Stops     Pct.")
 D SET^SDAMQ3("         ---------                     ----------------    -------   -------")
 Q

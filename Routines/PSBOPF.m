PSBOPF ;BIRMINGHAM/TEJ-BCMA PATIENT RECORD FLAG REPORT ;Mar 2004
 ;;3.0;BAR CODE MED ADMIN;**4**;Mar 2004
 ;
 ; Reference/IA
 ; $$GETACT^DGPFAPI/3860
 ;
EN ;
 N PSBHDR
 S PSBGBL="^TMP(""PSBO"",$J,""B"")"
 F  S PSBGBL=$Q(@PSBGBL) Q:PSBGBL=""  Q:$QS(PSBGBL,2)'=$J  Q:$QS(PSBGBL,1)'["PSBO"  D
 .S (PSBDFN,DFN)=$QS(PSBGBL,5)
 I '$G(PSBDFN) W !,("Error: No Patient IEN")  Q
 S PSBAUDF=$P(PSBRPT(.2),U,9)
 S PSBHDR(0)="Patient Record Flag Report"
 S PSBHDR(1)="Log Type: INDIVIDUAL PATIENT"
 S PSBDFN=+$P(PSBRPT(.1),U,2)
 W $$PTHDR(),!
 ; GETACT - Create the flag array
 D PATFLG(PSBDFN)
 I '$D(PSBPTFLG) W !!?10,"<<<< NO ACTIVE PATIENT RECORD FLAG FOR THIS PATIENT >>>>",!! Q
 ; Create the report.
 S PSBHDR(1)="Continuing Patient Record Flag Report",PSBCONT=1
 S PSBHDR(2)="Log Type: INDIVIDUAL PATIENT"
 D FLGRPT
 W !!,$$PTFTR^PSBOHDR()
 Q
 ;
FLGRPT ; Displays $$GETACT^DGPFAPI data.
 ; 
 ; 
 S (PSBIDX,PSBIX,PSBCNT)=0
 F  S PSBIDX=$O(PSBROOT(PSBIDX)) Q:+PSBIDX'>0  D
 .W:PSBIDX>1 !,$TR($J("",IOM)," ","-"),!
 .W !,"Flag Name:               "_$P($G(PSBROOT(PSBIDX,"FLAG")),U,2)
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .W !,"Flag Type:               "_$P($G(PSBROOT(PSBIDX,"FLAGTYPE")),U,2)
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .W !,"Flag Category:           "_$P($G(PSBROOT(PSBIDX,"CATEGORY")),U,2)
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .W !,"Assignment Status:       "_"Active"
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .W !,"Initial Assigned Date:   "_$P($G(PSBROOT(PSBIDX,"ASSIGNDT")),U,2)
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .W !,"Approved by:             "_$P($G(PSBROOT(PSBIDX,"APPRVBY")),U,2)
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .W !,"Next Review Date:        "_$P($G(PSBROOT(PSBIDX,"REVIEWDT")),U,2)
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .W !,"Owner Site:              "_$P($G(PSBROOT(PSBIDX,"OWNER")),U,2)
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .W !,"Originating Site:        "_$P($G(PSBROOT(PSBIDX,"ORIGSITE")),U,2)
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .I '$D(PSBROOT(PSBIDX,"NARR")) D  Q 
 ..I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .W !!,"Assignment Narratives:   "
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .F  S PSBIX=$O(PSBROOT(PSBIDX,"NARR",PSBIX)) Q:'PSBIX  D
 ..W !,$$WRAP^PSBO(5,60,$G(PSBROOT(PSBIDX,"NARR",PSBIX,0)))
 ..I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 .W !!,"*End of Flag Narrative*"
 .I $Y>(IOSL-12) W $$PTFTR^PSBOHDR(),$$PTHDR()
 K PSBROOT
 Q
 ;
PATFLG(PSBDFN) ; Create PATient FLaG data.
 N PSBIDX,PSBIX,PSBCNT
 S PSBIDX=$$GETACT^DGPFAPI(PSBDFN,.PSBPTFLG)
 Q:'$D(PSBPTFLG)
 M PSBROOT=@PSBPTFLG
 Q
 ;
PTHDR() ;
 D PT^PSBOHDR(DFN,.PSBHDR)
 Q ""
 ;

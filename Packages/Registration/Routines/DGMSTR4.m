DGMSTR4 ;ALB/SCK - MST History report ; 7/9/01 4:07pm
 ;;5.3;Registration;**195,379**;Aug 13, 1993
EN ;  Main entry point
 N VAUTN,VAUTNI,VA,Y,ZTSAVE
 ;
 ; Select patients to include
 S VAUTNI=0
 D PATIENT^VAUTOMA
 I '$G(VAUTN),$O(VAUTN(""))="" Q
 ;
 N ZTSAVE
 S ZTSAVE("VAUTN")=""
 D EN^XUTMDEVQ("RPT^DGMSTR4","MST History Report",.ZTSAVE)
 D HOME^%ZIS
 Q
 ;
RPT ; Generate and print report
 N RPTREF,MSTNAME,DFN,DGQUIT,FRSTPAS
 ;
 S RPTREF="^TMP(""MST RPT"","_$J_")"
 K @RPTREF
 D BUILD(.VAUTN,RPTREF)
 Q:$$HEADER
 ;
 ; Print report from contents of ^TMP global
 ; If not data found, then print message on form.
 I '$D(@RPTREF) D  Q
 . W !?2,"No data found for report."
 ;
 S MSTNAME=""
 F  S MSTNAME=$O(@RPTREF@(MSTNAME)) Q:'(MSTNAME]"")  D  Q:$G(DGQUIT)
 . S DFN=$P(MSTNAME,U,2)
 . D PID^VADPT
 . W !?2,$E($P(MSTNAME,U),1,$L($P(MSTNAME,U))),"  ("_VA("PID")_")"
 . S MSTDT=""
 . F  S MSTDT=($O(@RPTREF@(MSTNAME,MSTDT))) Q:'MSTDT  D  Q:$G(DGQUIT)
 .. S DGMST=@RPTREF@(MSTNAME,MSTDT)
 .. W !?2,$$FMTE^XLFDT(-MSTDT)
 .. W ?21,$J($P(DGMST,U,2),2)
 .. W ?30,$$GET1^DIQ(4,(+$P(DGMST,U,7))_",",99)
 .. W ?36,$E($$NAME^DGMSTAPI($P(DGMST,U,4)),1,25)
 .. W ?61,$E($$NAME^DGMSTAPI($P(DGMST,U,5)),1,25)
 . W !
 . I $Y+5>$G(IOSL) D  Q:$G(DGQUIT)
 .. S DGQUIT=$$HEADER
 ;
 D KVA^VADPT
 K @RPTREF
 Q
 ;
BUILD(PTARRY,RPARRY) ;  Build TMP global of patients to include in report form array
 ; of patient names passed in (PTARRY)
 ;
 N DFN,MSTDT,DGMST,MSTIEN
 ;
 S DFN=""
 F  S DFN=$O(^DGMS(29.11,"APDT",DFN)) Q:'DFN  D
 . I 'PTARRY,'$D(PTARRY(DFN)) Q
 . S MSTDT=""
 . F  S MSTDT=$O(^DGMS(29.11,"APDT",DFN,MSTDT),-1) Q:'MSTDT  D
 .. S DGMST=$$GETSTAT^DGMSTAPI(DFN,MSTDT)
 .. Q:+DGMST<1
 .. S @RPARRY@($P(^DPT(DFN,0),U)_U_DFN,-MSTDT)=DGMST
 Q
 ;
HEADER() ;  Print report header
 N SDASH,LINE,STR
 I $G(FRSTPAS),$E(IOST,1,2)="C-" D PAUSE^VALM1 Q:'Y 1
 I '$G(FRSTPAS) D
 . S FRSTPAS=1
 . W @IOF
 E  D
 . W @IOF
 S STR="MST HISTORY REPORT"
 S $P(LINE," ",(IOM/2)-($L(STR)/2))=""
 W !,LINE_STR
 S STR="Print Date: "_$$FMTE^XLFDT($$NOW^XLFDT,"D")
 K LINE S $P(LINE," ",(IOM/2)-($L(STR)/2))=""
 W !,LINE_STR
 ;
 W !!?2,"Status Date",?21,"Status",?30,"Site",?36,"Provider",?61,"Who entered status",!
 S $P(SDASH,"-",IOM+1)=""
 W SDASH,!
 Q 0

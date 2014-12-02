HBHCRP18 ;LR VAMC(IRMS)/MJT - HBHC rpt, file 631, All active (admitted but not D/C) cases by date range, sorted by patient name, includes: name, Last Four, adm date, primary diagnosis @ adm (code & text), & total ;12/21/05 3:31pm
 ;;1.0;HOSPITAL BASED HOME CARE;**6,22,24,25**;NOV 01, 1993;Build 45
 ;
 ; This routine references the following supported ICRs:
 ; 5747    $$CODEC^ICDEX
 ; 5747    $$VSTD^ICDEX
 ;
 ;******************************************************************************
 ;******************************************************************************
 ;                       --- ROUTINE MODIFICATION LOG ---
 ;        
 ;PKG/PATCH    DATE        DEVELOPER    MODIFICATION
 ;-----------  ----------  -----------  ----------------------------------------
 ;HBH*1.0*25   FEB  2012   K GUPTA      Support for ICD-10 Coding System
 ;******************************************************************************
 ;******************************************************************************
 ;
 D START^HBHCUTL
 G:(HBHCBEG1=-1)!(HBHCEND1=-1) EXIT
 S %ZIS="Q",HBHCCC=0 K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCRP18",ZTDESC="HBPC Active Census with ICD Code/Text Report",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 K ^TMP("HBHC",$J)
 S HBHCTOT=0,$P(HBHCY,"-",133)="",$P(HBHCZ,"=",133)="",HBHCHEAD="Active Census with ICD Code/Text"
 S HBHCHDR="W !,""Patient Name"",?40,""Last Four"",?61,""Date"",?82,"""_$$ICDTEXT^HBHCUTL3(HBHCBEG1,HBHCEND1)_" Code"",?102,""Diagnosis Text"""
 S HBHCCOLM=(132-(30+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 D TODAY^HBHCUTL D:IO'=IO(0)!($D(IO("S"))) HDR132^HBHCUTL
 I '$D(IO("S")),(IO=IO(0)) S HBHCCC=HBHCCC+1 W @IOF D HDR132^HBHCUTL
LOOP ; Loop thru ^HBHC(631) "AD" (admission date) cross-ref to build report
 S X1=HBHCBEG1,X2=-1 D C^%DTC S HBHCADDT=X
 F  S HBHCADDT=$O(^HBHC(631,"AD",HBHCADDT)) Q:(HBHCADDT="")!(HBHCADDT>HBHCEND1)  S HBHCDFN="" F  S HBHCDFN=$O(^HBHC(631,"AD",HBHCADDT,HBHCDFN)) Q:HBHCDFN=""  S HBHCNOD0=^HBHC(631,HBHCDFN,0) D:$P(HBHCNOD0,U,15)=1 PROCESS
 W:'$D(^TMP("HBHC",$J)) !!,"No data found for Date Range selected."
 I $D(^TMP("HBHC",$J)) D PRTLOOP W !!,HBHCZ,!,"Active Census Total: ",HBHCTOT,!,HBHCZ
 D END132^HBHCUTL1
EXIT ; Exit module
 D ^%ZISC
 K HBHCADDT,HBHCBEG1,HBHCBEG2,HBHCCC,HBHCCOLM,HBHCDFN,HBHCDPT0,HBHCEND1,HBHCEND2,HBHCHDR,HBHCHEAD,HBHCICDP,HBHCNAME,HBHCNOD0,HBHCPAGE,HBHCTDY,HBHCTMP,HBHCTOT,HBHCY,HBHCZ,X,X1,X2,Y,^TMP("HBHC",$J)
 Q
PROCESS ; Process record & build ^TMP("HBHC",$J) global
 Q:($P(HBHCNOD0,U,40)]"")&($P(HBHCNOD0,U,40)<HBHCEND1)
 N HBHCDXCODE,HBHCDXDESC
 S HBHCDPT0=^DPT($P(HBHCNOD0,U),0),HBHCICDP=$P(HBHCNOD0,U,19)
 I HBHCICDP]"" D  I 1
 . S HBHCDXCODE=$$CODEC^ICDEX(80,HBHCICDP)
 . S HBHCDXDESC=$$VSTD^ICDEX(HBHCICDP)
 S ^TMP("HBHC",$J,$P(HBHCDPT0,U),HBHCADDT)=$E($P(HBHCDPT0,U,9),6,9)_U_$G(HBHCDXCODE)_U_$G(HBHCDXDESC)
 Q
PRTLOOP ; Print loop
 S HBHCNAME="" F  S HBHCNAME=$O(^TMP("HBHC",$J,HBHCNAME)) Q:HBHCNAME=""  S HBHCADDT="" F  S HBHCADDT=$O(^TMP("HBHC",$J,HBHCNAME,HBHCADDT)) Q:HBHCADDT=""  D PRINT
 Q
PRINT ; Print report
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<5) W @IOF D HDR132^HBHCUTL
 S Y=HBHCADDT D DD^%DT
 S HBHCTMP=^TMP("HBHC",$J,HBHCNAME,HBHCADDT)
 W !,HBHCNAME,?40,$P(HBHCTMP,U),?61,Y,?82,$P(HBHCTMP,U,2),?102,$P(HBHCTMP,U,3),!,HBHCY
 S HBHCTOT=HBHCTOT+1
 Q

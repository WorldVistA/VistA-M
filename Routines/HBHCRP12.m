HBHCRP12 ; LR VAMC(IRMS)/MJT-HBHC file 631 rpt, Episode of Care/Length of Stay, by date range, sorted by patient name, includes: pt name, Last Four, admission date, discharge date, & length of stay, plus pt & day totals; ; 12/21/05 3:40pm
 ;;1.0;HOSPITAL BASED HOME CARE;**6,21,22**;NOV 01, 1993;Build 2
 ; Also includes pt & day totals, plus avg LOS for complete episodes only
 D START^HBHCUTL
 G:(HBHCBEG1=-1)!(HBHCEND1=-1) EXIT
 S %ZIS="Q",HBHCCC=0 K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCRP12",ZTDESC="HBPC Episode of Care/Length of Stay Report",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 K ^TMP("HBHC",$J)
 S $P(HBHCY,"-",81)="",HBHCHEAD="Episode of Care/Length of Stay",HBHCHDR="W !?63,""Discharge"",?74,""Length"",!,""Patient Name"",?34,""Last Four"",?50,""Date"",?63,""Date"",?74,""/Stay""",(HBHCCNT,HBHCCNT1,HBHCTOT,HBHCTOT1)=0
 S HBHCCOLM=(80-(30+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 D TODAY^HBHCUTL D:IO'=IO(0)!($D(IO("S"))) HDRRANGE^HBHCUTL
 I '$D(IO("S")),(IO=IO(0)) S HBHCCC=HBHCCC+1 D HDRRANGE^HBHCUTL
LOOP ; Loop thru ^HBHC(631) "AD" (admission date) cross-ref to build report
 S X1=HBHCBEG1,X2=-1 D C^%DTC S HBHCADDT=X
 F  S HBHCADDT=$O(^HBHC(631,"AD",HBHCADDT)) Q:(HBHCADDT="")!(HBHCADDT>HBHCEND1)  S HBHCDFN="" F  S HBHCDFN=$O(^HBHC(631,"AD",HBHCADDT,HBHCDFN)) Q:HBHCDFN=""  S HBHCNOD0=^HBHC(631,HBHCDFN,0) D:$P(HBHCNOD0,U,15)=1 PROCESS
 D PRTLOOP
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<7) W @IOF D HDRRANGE^HBHCUTL
 W !!,HBHCZ,!,"Complete Episodes of Care Only:",!?2,"Total Patients:  ",HBHCCNT1,"    Total Days:  ",$FN(HBHCTOT1,","),"    Average Length of Stay:  ",$S(((HBHCTOT1>0)&(HBHCCNT1>0)):(HBHCTOT1\HBHCCNT1),1:0)
 W !,HBHCZ,!?2,"Total Patients:  ",HBHCCNT,"    Total Days:  ",$FN(HBHCTOT,","),!,HBHCZ
 D ENDRPT^HBHCUTL1
EXIT ; Exit module
 D ^%ZISC
 K HBHCADDT,HBHCBEG1,HBHCBEG2,HBHCCOLM,HBHCCC,HBHCCNT,HBHCCNT1,HBHCDFN,HBHCDPT0,HBHCDSDT,HBHCEND1,HBHCEND2,HBHCHDR,HBHCHEAD,HBHCLOS,HBHCNAME,HBHCNOD0,HBHCPAGE,HBHCTDY,HBHCTMP,HBHCTOT,HBHCTOT1,HBHCY,HBHCZ,X,X1,X2,Y,^TMP("HBHC",$J)
 Q
PROCESS ; Process record & build ^TMP("HBHC",$J) global
 S HBHCDSDT=$P(HBHCNOD0,U,40)
 S HBHCCNT=HBHCCNT+1
 S HBHCDPT0=^DPT($P(HBHCNOD0,U),0),HBHCLOS=""
 I HBHCDSDT]"" S X1=$S((HBHCDSDT>HBHCEND1):HBHCEND1,1:HBHCDSDT),X2=HBHCADDT D ^%DTC S HBHCLOS=X
 ; handles Admission Date being same as date range ending date, OR Adm & D/C dates being equal
 S:HBHCLOS=0 HBHCLOS=1
 ; '> below handles counting as complete episode of care ONLY if Discharge Date is within date range
 S:(HBHCDSDT]"")&(HBHCDSDT'>HBHCEND1) HBHCCNT1=HBHCCNT1+1,HBHCTOT1=HBHCTOT1+HBHCLOS
 S HBHCDSDT=$S(HBHCDSDT="":" Active",(HBHCDSDT>HBHCEND1):" Active",1:$E(HBHCDSDT,4,5)_"-"_$E(HBHCDSDT,6,7)_"-"_$E(HBHCDSDT,2,3),1:" Active")
 ; Add 1 to HBHCLOS to be current/ending day inclusive
 I (HBHCDSDT="")!(HBHCDSDT=" Active") S X1=HBHCEND1,X2=HBHCADDT D ^%DTC S HBHCLOS=(X+1)
 S HBHCTOT=HBHCTOT+HBHCLOS
 S ^TMP("HBHC",$J,$P(HBHCDPT0,U),HBHCADDT)=$E($P(HBHCDPT0,U,9),6,9)_U_HBHCDSDT_U_HBHCLOS
 Q
PRTLOOP ; Print loop
 S HBHCNAME="" F  S HBHCNAME=$O(^TMP("HBHC",$J,HBHCNAME)) Q:HBHCNAME=""  S HBHCADDT="" F  S HBHCADDT=$O(^TMP("HBHC",$J,HBHCNAME,HBHCADDT)) Q:HBHCADDT=""  D PRINT
 Q
PRINT ; Print report
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<5) W @IOF D HDRRANGE^HBHCUTL
 S HBHCTMP=^TMP("HBHC",$J,HBHCNAME,HBHCADDT)
 W !,HBHCNAME,?34,$P(HBHCTMP,U),?50,$E(HBHCADDT,4,5)_"-"_$E(HBHCADDT,6,7)_"-"_$E(HBHCADDT,2,3),?63,$P(HBHCTMP,U,2),?76,$J($P(HBHCTMP,U,3),4),!,HBHCY
 Q

HBHCRP23 ; LR VAMC(IRMS)/MJT-HBHC report on file 631, Patient Days by date range, sorted by patient name, includes: IEN, patient name, Last Four, admission date, D/C date, & pt days w/totals, calls: MFHS^HBHCUTL3 & MFH^HBHCUTL3 ; 12/21/05 3:31pm
 ;;1.0;HOSPITAL BASED HOME CARE;**21,22,24**;NOV 01, 1993;Build 201
 ; Notes:  date range should be inclusion of all days; D/C date is not included in patient day count
 D START^HBHCUTL
 G:(HBHCBEG1=-1)!(HBHCEND1=-1) EXIT
 W ! D MFHS^HBHCUTL3 D:$D(HBHCMFHS) MFH^HBHCUTL3
 G:$D(DIRUT) EXIT
 S %ZIS="Q",HBHCCC=0 K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCRP23",ZTDESC="HBPC Patient Days of Care by Date Range Report",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 K ^TMP("HBHC",$J)
 S $P(HBHCY,"-",81)="",(HBHCCNT,HBHCCNT1,HBHCTOT,HBHCTOT1)=0,HBHCHEAD="Patient Days of Care by Date Range"
 ; HBHCMFHS variable set in MFHS^HBHCUTL3
 S:'$D(HBHCMFHS) HBHCHDR="W !?63,""Discharge"",?73,""Patient"",!,""IEN"",?7,""Patient Name"",?34,""Last Four"",?50,""Date"",?63,""Date"",?73,""Days"""
 S:$D(HBHCMFHS) HBHCHDR="W !?34,""Last"",?54,""Discharge"",?67,""Patient"",!,""IEN"",?7,""Patient Name"",?34,""Four"",?42,""Date"",?54,""Date"",?67,""Days"",?77,""MFH"""
 ; HBHCMFHR variable set in MFH^HBHCUTL3
 S:$D(HBHCMFHR) HBHCHEAD="MFH "_HBHCHEAD
 S HBHCCOLM=(80-(30+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 D TODAY^HBHCUTL D:IO'=IO(0)!($D(IO("S"))) HDRRANGE^HBHCUTL
 I '$D(IO("S")),(IO=IO(0)) S HBHCCC=HBHCCC+1 D HDRRANGE^HBHCUTL
LOOP ; Loop thru ^HBHC(631) "AD" (admission date) cross-ref to build report
 S HBHCADDT=0 F  S HBHCADDT=$O(^HBHC(631,"AD",HBHCADDT)) Q:(HBHCADDT'>0)!(HBHCADDT>HBHCEND1)  S HBHCDFN="" F  S HBHCDFN=$O(^HBHC(631,"AD",HBHCADDT,HBHCDFN)) Q:HBHCDFN=""  S HBHCNOD0=^HBHC(631,HBHCDFN,0) D:$P(HBHCNOD0,U,15)=1 PROCESS
 D PRTLOOP
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<14) W @IOF D HDRRANGE^HBHCUTL
 W !!,HBHCZ,!?14,">>>  Date Range:  ",HBHCBEG2," to ",HBHCEND2,"  <<<"
 W !,HBHCZ,!,"Total Active Patients:  ",$J($FN((HBHCCNT-HBHCCNT1),","),6)
 W !,HBHCZ,!,"Complete Episodes of Care Only:",!?4,"Total Patients:  ",$J($FN(HBHCCNT1,","),6),"     Total Patient Days in Date Range:  ",$J($FN(HBHCTOT1,","),10)
 W !,HBHCZ,!?4,"Total Patients:  ",$J($FN(HBHCCNT,","),6),"     Total Patient Days in Date Range:  ",$J($FN(HBHCTOT,","),10),!,HBHCZ
 D ENDRPT^HBHCUTL1
EXIT ; Exit module
 D ^%ZISC
 K DIR,HBHCADDT,HBHCBEG1,HBHCBEG2,HBHCCOLM,HBHCCC,HBHCCNT,HBHCCNT1,HBHCDATE,HBHCDFN,HBHCDPT0,HBHCDSDT,HBHCEND1,HBHCEND2,HBHCHDR,HBHCHEAD,HBHCLOS,HBHCMFH,HBHCMFHR,HBHCMFHS,HBHCNAME,HBHCNOD0,HBHCPAGE,HBHCTDY,HBHCTMP,HBHCTOT,HBHCTOT1,HBHCY
 K HBHCZ,X,X1,X2,Y,^TMP("HBHC",$J)
 Q
PROCESS ; Process record & build ^TMP("HBHC",$J) global
 ; Quit if Medical Foster Home (MFH) Report, but not MFH patient; HBHCMFHR variable set in MFH^HBHCUTL3
 I $D(HBHCMFHR) Q:'$D(^HBHC(631,"AJ","Y",HBHCDFN))
 I $D(HBHCMFHS) S HBHCMFH="" S:$D(^HBHC(631,"AJ","Y",HBHCDFN)) HBHCMFH="MFH"
 S HBHCDSDT=$P(HBHCNOD0,U,40)
 ; Add 1 to ending date to handle date range being inclusive
 S X1=HBHCEND1,X2=1 D C^%DTC S HBHCDATE=X
 ; '> below handles Discharge Date being same as date range beginning date
 I HBHCDSDT]"" Q:(HBHCDSDT'>HBHCBEG1)  I HBHCEND1>HBHCDSDT S HBHCDATE=HBHCDSDT
 S HBHCDPT0=^DPT($P(HBHCNOD0,U),0),HBHCLOS="",HBHCCNT=HBHCCNT+1
 S HBHCDAT=$S(HBHCADDT>HBHCBEG1:HBHCADDT,1:HBHCBEG1)
 S X1=HBHCDATE,X2=HBHCDAT
 D ^%DTC S HBHCLOS=X
 ; handles Admission Date being same as date range ending date, OR Adm & D/C dates being equal
 S:HBHCLOS=0 HBHCLOS=1
 S HBHCTOT=HBHCTOT+HBHCLOS
 ; '> below handles counting as complete episode of care ONLY if Discharge Date is within date range
 S:(HBHCDSDT]"")&(HBHCDSDT'>HBHCEND1) HBHCCNT1=HBHCCNT1+1,HBHCTOT1=HBHCTOT1+HBHCLOS
 S HBHCDSDT=$S(HBHCDSDT]"":$E(HBHCDSDT,4,5)_"-"_$E(HBHCDSDT,6,7)_"-"_$E(HBHCDSDT,2,3),1:"")
 S:'$D(HBHCMFHS) ^TMP("HBHC",$J,$P(HBHCDPT0,U),HBHCADDT)=$E($P(HBHCDPT0,U,9),6,9)_U_HBHCDSDT_U_HBHCLOS_U_HBHCDFN
 S:$D(HBHCMFHS) ^TMP("HBHC",$J,$P(HBHCDPT0,U),HBHCADDT)=$E($P(HBHCDPT0,U,9),6,9)_U_HBHCDSDT_U_HBHCLOS_U_HBHCDFN_U_HBHCMFH
 Q
PRTLOOP ; Print loop
 S HBHCNAME="" F  S HBHCNAME=$O(^TMP("HBHC",$J,HBHCNAME)) Q:HBHCNAME=""  S HBHCADDT="" F  S HBHCADDT=$O(^TMP("HBHC",$J,HBHCNAME,HBHCADDT)) Q:HBHCADDT=""  D PRINT
 Q
PRINT ; Print report
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<5) W @IOF D HDRRANGE^HBHCUTL
 S HBHCTMP=^TMP("HBHC",$J,HBHCNAME,HBHCADDT)
 I $P(HBHCTMP,U,3)>0 I '$D(HBHCMFHS) W !,$J("`"_$P(HBHCTMP,U,4),5)_"  "_$E(HBHCNAME,1,24),?34,$P(HBHCTMP,U),?50,$E(HBHCADDT,4,5)_"-"_$E(HBHCADDT,6,7)_"-"_$E(HBHCADDT,2,3),?63,$P(HBHCTMP,U,2),?76,$J($P(HBHCTMP,U,3),5),!,HBHCY
 I $P(HBHCTMP,U,3)>0 I $D(HBHCMFHS) W !,$J("`"_$P(HBHCTMP,U,4),5)_"  "_$E(HBHCNAME,1,24),?34,$P(HBHCTMP,U),?42,$E(HBHCADDT,4,5)_"-"_$E(HBHCADDT,6,7)_"-"_$E(HBHCADDT,2,3),?54,$P(HBHCTMP,U,2),?69,$J($P(HBHCTMP,U,3),4),?77,$P(HBHCTMP,U,5),!,HBHCY
 Q

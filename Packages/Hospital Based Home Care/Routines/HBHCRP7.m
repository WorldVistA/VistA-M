HBHCRP7 ; LR VAMC(IRMS)/MJT-HBHC file 631 rpt, user selects: adm or D/C by date range, & sort alphabetic by pt or date of adm or D/C; includes adm/D/C date, pt name, last four, & primary DX @ adm/D/C (code & text); ; 12/21/05 3:43pm
 ;;1.0;HOSPITAL BASED HOME CARE;**5,6,21,22,24**;NOV 01, 1993;Build 201
 S DIR(0)="SB^A:Admissions;D:Discharges;",DIR("A")="Select Admissions or Discharges",DIR("?")="Enter 'A' to include Admissions on the report, 'D' to choose Discharges." D ^DIR
 G:$D(DIRUT) EXIT
 S HBHCTYPS=Y(0),HBHCTYP=$E(Y(0),1,9),HBHCXREF=$S(Y="A":"AD",1:"AC"),HBHCDXPC=$S(Y="A":19,1:47),HBHCCC=0
 ; Prompt user for sort preference: alphabetical by patient or date of admission or D/C
 K DIR S DIR(0)="SB^A:Alphabetical;D:Date of Admission or D/C",DIR("A")="Sort Alphabetically by Patient or by Date",DIR("?")="Sort report alphabetically by patient (A), or by date of admission or D/C (D)." D ^DIR
 G:$D(DIRUT) EXIT
 ; HBHCFLG exists if alphabetic sort selected
 S:Y="A" HBHCFLG=1
 D START^HBHCUTL
 G:(HBHCBEG1=-1)!(HBHCEND1=-1) EXIT
 S %ZIS="Q" K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCRP7",ZTDESC="HBPC "_HBHCTYP_"Alphabetic Date Range Report",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 K ^TMP("HBHC",$J)
 S $P(HBHCY,"-",133)="",$P(HBHCZ,"=",133)=""
 S:'$D(HBHCFLG) HBHCHEAD=HBHCTYPS_" by Date Range, Date Range Sort"
 S:$D(HBHCFLG) HBHCHEAD=HBHCTYPS_" by Date Range, Alphabetic Sort"
 S:'$D(HBHCFLG) HBHCHDR="W HBHCTYP_"" Date"",?19,""Patient Name"",?60,""Last Four"",?82,""ICD9 Code"",?100,""Diagnosis Text"""
 S:$D(HBHCFLG) HBHCHDR="W ""Patient Name"",?38,HBHCTYP_"" Date"",?60,""Last Four"",?82,""ICD9 Code"",?100,""Diagnosis Text"""
 S HBHCCOLM=(132-(30+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 D TODAY^HBHCUTL
LOOP ; Loop thru ^HBHC(631) "AD" (admission date) or "AC" (discharge date) cross-ref to build report
 S X1=HBHCBEG1,X2=-1 D C^%DTC S HBHCDATE=X
 F  S HBHCDATE=$O(^HBHC(631,HBHCXREF,HBHCDATE)) Q:(HBHCDATE="")!(HBHCDATE>HBHCEND1)  S HBHCDFN="" F  S HBHCDFN=$O(^HBHC(631,HBHCXREF,HBHCDATE,HBHCDFN)) Q:HBHCDFN=""  S HBHCNOD0=^HBHC(631,HBHCDFN,0) D:$P(HBHCNOD0,U,15)=1 PROCESS
 D:IO'=IO(0)!($D(IO("S"))) HDR132^HBHCUTL
 I '$D(IO("S")),(IO=IO(0)) S HBHCCC=HBHCCC+1 D HDR132^HBHCUTL
 W:'$D(^TMP("HBHC",$J)) !!,"No "_HBHCTYPS_" found for Date Range selected."
 I $D(^TMP("HBHC",$J)) D PRTLOOP W !!,HBHCZ,!,"Total "_HBHCTYPS_": ",HBHCTOT,!,HBHCZ
 D END132^HBHCUTL1
EXIT ; Exit module
 D ^%ZISC
 K DIR,DIRUT,HBHCBEG1,HBHCBEG2,HBHCCOLM,HBHCCC,HBHCDATE,HBHCDFN,HBHCDPT0,HBHCDT,HBHCDXPC,HBHCEND1,HBHCEND2,HBHCFLG,HBHCHDR,HBHCHEAD,HBHCICD0,HBHCICDP,HBHCNAME,HBHCNOD0,HBHCPAGE,HBHCTDY,HBHCTMP,HBHCTOT,HBHCTYP,HBHCTYPS,HBHCXREF
 K HBHCY,HBHCZ,X,X1,X2,Y,^TMP("HBHC",$J)
 Q
PROCESS ; Process record & create ^TMP("HBHC",$J global
 S HBHCDPT0=^DPT($P(HBHCNOD0,U),0),HBHCICDP=$P(HBHCNOD0,U,HBHCDXPC),HBHCICD0=$S(HBHCICDP]"":$$ICDDX^ICDCODE(HBHCICDP),1:"")
 S:'$D(HBHCFLG) ^TMP("HBHC",$J,HBHCDATE,$P(HBHCDPT0,U))=$E($P(HBHCDPT0,U,9),6,9)_U_$P(HBHCICD0,U,2)_U_$P(HBHCICD0,U,4)
 S:$D(HBHCFLG) ^TMP("HBHC",$J,$P(HBHCDPT0,U),HBHCDATE)=$E($P(HBHCDPT0,U,9),6,9)_U_$P(HBHCICD0,U,2)_U_$P(HBHCICD0,U,4)
 Q
PRTLOOP ; Print loop
 S HBHCTOT=0
 I '$D(HBHCFLG) S HBHCDT="" F  S HBHCDT=$O(^TMP("HBHC",$J,HBHCDT)) Q:HBHCDT=""  S HBHCNAME="" F  S HBHCNAME=$O(^TMP("HBHC",$J,HBHCDT,HBHCNAME)) Q:HBHCNAME=""  D PRT
 I $D(HBHCFLG) S HBHCNAME="" F  S HBHCNAME=$O(^TMP("HBHC",$J,HBHCNAME)) Q:HBHCNAME=""  S HBHCDT="" F  S HBHCDT=$O(^TMP("HBHC",$J,HBHCNAME,HBHCDT)) Q:HBHCDT=""  D PRT
 Q
PRT ; Print report
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<5) W @IOF D HDR132^HBHCUTL
 S HBHCTOT=HBHCTOT+1
 S:'$D(HBHCFLG) HBHCTMP=^TMP("HBHC",$J,HBHCDT,HBHCNAME)
 S:$D(HBHCFLG) HBHCTMP=^TMP("HBHC",$J,HBHCNAME,HBHCDT)
 W:'$D(HBHCFLG) !,$E(HBHCDT,4,5)_"-"_$E(HBHCDT,6,7)_"-"_$E(HBHCDT,2,3),?19,HBHCNAME,?60,$P(HBHCTMP,U),?82,$P(HBHCTMP,U,2),?100,$P(HBHCTMP,U,3),!,HBHCY
 W:$D(HBHCFLG) !,HBHCNAME,?38,$E(HBHCDT,4,5)_"-"_$E(HBHCDT,6,7)_"-"_$E(HBHCDT,2,3),?60,$P(HBHCTMP,U),?82,$P(HBHCTMP,U,2),?100,$P(HBHCTMP,U,3),!,HBHCY
 Q

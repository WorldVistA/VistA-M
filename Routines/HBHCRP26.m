HBHCRP26 ; LR VAMC(IRMS)/MJT-HBHC report on Medical Foster Home file 633.2, sorted by name, includes: MFH Name, Opened Date, Prim Caregiver, Max Pts, Bedbound Max, Closure Date, & Voluntary Closure ; Mar 2007
 ;;1.0;HOSPITAL BASED HOME CARE;**24**;NOV 01, 1993;Build 201
 S %ZIS="Q",HBHCCC=0 K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCRP26",ZTDESC="HBPC Medical Foster Home File Data Report",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 S HBHCPAGE=0,$P(HBHCY,"-",133)="",$P(HBHCZ,"=",133)="",HBHCHEAD="Medical Foster Home (MFH) File Data"
 S HBHCHDR="W !,?35,""Opened"",?87,""Maximum"",?99,""Bedbound"",?111,""Closure"",?123,""Voluntary"",!,""Medical Foster Home (MFH) Name"",?35,""Date"",?48,""Primary Caregiver Name"",?87,""Patients"",?99,""Maximum"",?111,""Date"",?123,""Closure"""
 S HBHCCOLM=(132-(30+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 D TODAY^HBHCUTL D:IO'=IO(0)!($D(IO("S"))) HDR132NR^HBHCUTL
 I '$D(IO("S")),(IO=IO(0)) S HBHCCC=HBHCCC+1 D HDR132NR^HBHCUTL
LOOP ; Loop thru ^HBHC(633.2,"B") MFH Name cross-ref to build report
 S HBHCDFN=0 F  S HBHCDFN=$O(^HBHC(633.2,HBHCDFN)) Q:HBHCDFN'>0  D PROCESS
 I $D(^TMP("HBHC",$J)) D PRTLOOP,PRTTOT
 D END132^HBHCUTL1
EXIT ; Exit module
 D ^%ZISC
 K HBHCCC,HBHCCOLM,HBHCDFN,HBHCHDR,HBHCHEAD,HBHCNAME,HBHCNOD0,HBHCPAGE,HBHCTDY,HBHCTMP,HBHCTOT,HBHCTOT1,HBHCTOT2,HBHCY,HBHCZ,X,Y,^TMP("HBHC",$J)
 Q
PROCESS ; Process record & build ^TMP("HBHC",$J) global
 S HBHCNOD0=^HBHC(633.2,HBHCDFN,0)
 S ^TMP("HBHC",$J,$P(HBHCNOD0,U),HBHCDFN)=$P(HBHCNOD0,U,2)_U_$P(HBHCNOD0,U,3)_U_$P(HBHCNOD0,U,4)_U_$P(HBHCNOD0,U,5)_U_$P(HBHCNOD0,U,6)_U_$P(HBHCNOD0,U,7)
 Q
PRTLOOP ; Print loop
 S (HBHCTOT,HBHCTOT1,HBHCTOT2)=0
 S HBHCNAME="" F  S HBHCNAME=$O(^TMP("HBHC",$J,HBHCNAME)) Q:HBHCNAME=""  S HBHCDFN="" F  S HBHCDFN=$O(^TMP("HBHC",$J,HBHCNAME,HBHCDFN)) Q:HBHCDFN=""  D PRINT
 Q
PRINT ; Print report
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<5) W @IOF D HDR132NR^HBHCUTL
 S HBHCTMP=^TMP("HBHC",$J,HBHCNAME,HBHCDFN),HBHCTOT=HBHCTOT+1,HBHCTOT1=HBHCTOT1+($P(HBHCTMP,U,3)),HBHCTOT2=HBHCTOT2+($P(HBHCTMP,U,4))
 W !,HBHCNAME,?35,$S($P(HBHCTMP,U)]"":$E($P(HBHCTMP,U),4,5)_"-"_$E($P(HBHCTMP,U),6,7)_"-"_$E($P(HBHCTMP,U),2,3),1:""),?48,$P(HBHCTMP,U,2),?87,$P(HBHCTMP,U,3),?99,$P(HBHCTMP,U,4)
 W ?111,$S($P(HBHCTMP,U,5)]"":$E($P(HBHCTMP,U,5),4,5)_"-"_$E($P(HBHCTMP,U,5),6,7)_"-"_$E($P(HBHCTMP,U,5),2,3),1:""),?123,$S(($P(HBHCTMP,U,6)="Y"):"Yes",($P(HBHCTMP,U,6)="N"):"No",1:""),!,HBHCY
 Q
PRTTOT ; Print report totals
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<1) W @IOF D HDR132NR^HBHCUTL
 W !!,HBHCZ,!,"Maximum Patients Total: ",?34,$J(HBHCTOT1,5),!,"Bedbound Maximum Total: ",?34,$J(HBHCTOT2,5),!!,"Medical Foster Home (MFH) Total: ",?34,$J(HBHCTOT,5),!,HBHCZ
 Q

HBHCRP28 ; LR VAMC(IRMS)/MJT-HBHC MFH Rate Paid rpt; user selects: pt or MFH; active only, indiv, or all pts or MFHs; current rate paid only or entire rate paid history, calls ^HBHCUTL5 @ entry points: EN, EXIT, MFH, PT, PRTPT, PRTMFH;Sep 2007
 ;;1.0;HOSPITAL BASED HOME CARE;**24**;NOV 01, 1993;Build 201
 ; Prompt for patient or MFH report 
 D EN^HBHCUTL5
 S %ZIS="Q",HBHCCC=0 K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCRP28",ZTDESC="HBPC MFH Rate Paid Report",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 D TODAY^HBHCUTL
 S HBHCPAGE=0,HBHCHEAD="Medical Foster Home (MFH) Rate Paid",HBHCCOLM=(80-(30+$L(HBHCHEAD))\2) S:HBHCCOLM'>0 HBHCCOLM=1
 S HBHC1=$S(HBHCDIR="O":"Active ONLY",HBHCDIR="I":"Individual",1:"All")
 S HBHC2=$S(HBHC="C":"Current Rate",1:"All Rates")_" Paid"
 S:HBHCXREF="AJ" HBHC3=""
 S:HBHCXREF="AK" HBHC3=$S(HBHCYN="Y":"Include",1:"Omit")_" D/C Pts"
 S HBHCHDRX="W ""Selected Criteria:"",?20,HBHC1_HBHCWHO,?44,HBHC2,?65,HBHC3"
 S:HBHCXREF="AJ" HBHCHDR="W ?33,""Last"",?40,""Rate"",?50,""Start"",!,""Patient Name"",?33,""Four"",?40,""Paid"",?50,""Date"",?61,""Medical Foster Home"""
 S:HBHCXREF="AK" HBHCHDR="W ?55,""Last"",?62,""Rate"",?72,""Start"",!,""Medical Foster Home (MFH) Name"",?33,""Patient Name"",?55,""Four"",?62,""Paid"",?72,""Date"""
 D:IO'=IO(0)!($D(IO("S"))) HDRXPAGE^HBHCUTL I '$D(IO("S")),(IO=IO(0)) S HBHCCC=HBHCCC+1 D HDRXPAGE^HBHCUTL
 D:HBHCXREF="AJ" PT^HBHCUTL5
 D:HBHCXREF="AK" MFH^HBHCUTL5
 I $D(^TMP("HBHC",$J)) S $P(HBHCY,"-",81)="",(HBHCCNT,HBHCTOT)=0 D:HBHCXREF="AJ" PRTPT^HBHCUTL5 D:HBHCXREF="AK" PRTMFH^HBHCUTL5
 I $D(^TMP("HBHC",$J)) W !,HBHCY,!!,HBHCZ,"Lowest Rate:  ",$J(HBHCLOW,7,2),?28,"Highest Rate:  ",$J(HBHCHI,7,2),?57,"Average Rate:  ",$J((HBHCTOT/HBHCCNT),8,2),!,HBHCZ
 D ENDRPT^HBHCUTL1
EXIT ; Exit module
 D EXIT^HBHCUTL5
 Q
PRINTPT ; Print Patient Loop
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<5) W @IOF D HDRXPAGE^HBHCUTL
 W !,HBHCM,?33,$P(HBHCINFO,U,2),?40,$J($P(HBHCINFO,U),7,2),?50,$E(HBHCJ,4,5)_"-"_$E(HBHCJ,6,7)_"-"_$E(HBHCJ,2,3),?61,$E($P(^HBHC(633.2,$P(HBHCINFO,U,3),0),U),1,19)
 D TOT
 Q
PRINTMFH ; Print MFH Loop
 I ($D(ZTRTN)!(HBHCCC=0))&((IOSL-$Y)<5) W @IOF D HDRXPAGE^HBHCUTL
 W !,HBHCL,?33,$E(HBHCM,1,19),?55,$P(HBHCINFO,U,2),?62,$J($P(HBHCINFO,U),7,2),?72,$E(HBHCJ,4,5)_"-"_$E(HBHCJ,6,7)_"-"_$E(HBHCJ,2,3)
 D TOT
 Q
TOT ; Update low value, high value, count, & total
 S:HBHCCNT=0 HBHCLOW=$P(HBHCINFO,U),HBHCHI=$P(HBHCINFO,U)
 S:$P(HBHCINFO,U)<HBHCLOW HBHCLOW=$P(HBHCINFO,U)
 S:$P(HBHCINFO,U)>HBHCHI HBHCHI=$P(HBHCINFO,U)
 S HBHCCNT=HBHCCNT+1
 S HBHCTOT=HBHCTOT+$P(HBHCINFO,U)
 Q

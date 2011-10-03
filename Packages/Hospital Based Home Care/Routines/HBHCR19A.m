HBHCR19A ;LR VAMC(IRMS)/MJT-HBHC file 632 rpt, DX info by date range, sorted by DX category, then pt name, includes: name, last four, DX (code & text), w/category subtotals & grand total, calls HBHCR19B & DX^HBHCUTL3;  ; 12/21/05 3:39pm
 ;;1.0;HOSPITAL BASED HOME CARE;**8,14,22**;NOV 01, 1993;Build 2
 D START^HBHCUTL
 G:(HBHCBEG1=-1)!(HBHCEND1=-1) EXIT
 K ^TMP($J)
PROMPT1 ; Prompt user for whether to include all ICD9 Diagnosis Codes
 K DD,D0 W !!,"Do you wish to include ALL ICD Diagnosis Codes on the report" S %=2 D YN^DICN
 G:(%=-1) EXIT
 I %=1 S HBHCFLAG=1 G START2
 I %=0 W !!,"A 'Yes' response will include ALL ICD Diagnosis Codes.  A 'No' response will",!,"prompt for an individual ICD Diagnosis Code." G PROMPT1
PROMPT2 ; Prompt user for individual ICD9 Diagnosis Code
 W ! K DIR S DIR(0)="PO^80:AEMQ" D ^DIR
 G:($D(DTOUT))!($D(DUOUT)) EXIT
 G:(Y=-1) START1
 S HBHCTMP=Y
PROMPT3 ; Prompt user for whether ICD9 category is to be considered a range (e.g.  Diabetes ICD9 codes range from 250 to 250.93 (as of 8/97))
 W !!,"Do you wish to include ALL codes within category "_$P($P(HBHCTMP,U,2),".") S %=1 D YN^DICN
 G:(%=-1) START1
 I %=0 W !!,"A 'Yes' response will include ALL ICD Diagnosis Codes withing the category.",!,"A 'No' response selects the specific ICD9 Diagnosis Code." G PROMPT3
 S HBHCCAT=$P($P(HBHCTMP,U,2),".")
 S:%=2 ^TMP($J,HBHCCAT,$P(HBHCTMP,U,2))="",^TMP($J,"B",$P(^ICD9($P(HBHCTMP,U),0),U))=""
 ; Setup ^TMP($J array with range of Dx
 S:%=1 HBHCCATE=(HBHCCAT)_".99",HBHCCATB=$S($E(HBHCCAT)=0:"0"_(HBHCCAT-1)_".99",$E(HBHCCAT)'?1N:$E(HBHCCAT)_($E(HBHCCAT,2,99)-1)_".99",1:(HBHCCAT-1)_".99")
 I %=1 F  S HBHCCATB=$O(^ICD9("BA",HBHCCATB)) Q:(HBHCCATB="")!(($E(HBHCCATB,2,99))>($E(HBHCCATE,2,99)))  S HBHCICDP="" F  S HBHCICDP=$O(^ICD9("BA",HBHCCATB,HBHCICDP)) Q:HBHCICDP=""  D SETTMP
 G PROMPT2
START1 ; Initialization 1
 G:'$D(^TMP($J)) EXIT
START2 ; Initialization 2
 S %ZIS="Q",HBHCCC=0 K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT
 I $D(IO("Q")) S ZTRTN="DQ^HBHCR19A",ZTDESC="HBPC ICD9 Code/Text Report",ZTSAVE("HBHC*")="",ZTSAVE("^TMP($J,")="" D ^%ZTLOAD G EXIT
DQ ; De-queue
 U IO
 D INITIAL^HBHCR19B,TODAY^HBHCUTL D:IO'=IO(0)!($D(IO("S"))) HDRRANGE^HBHCUTL
 I '$D(IO("S")),(IO=IO(0)) S HBHCCC=HBHCCC+1 W @IOF D HDRRANGE^HBHCUTL
LOOP ; Loop thru ^HBHC(632,"C" (appointment date) cross-ref to build report
 S X1=HBHCBEG1,X2=-1 D C^%DTC S HBHCAPDT=X_.9999
 F  S HBHCAPDT=$O(^HBHC(632,"C",HBHCAPDT)) Q:(HBHCAPDT="")!($P(HBHCAPDT,".")>HBHCEND1)  S HBHCDFN="" F  S HBHCDFN=$O(^HBHC(632,"C",HBHCAPDT,HBHCDFN)) Q:HBHCDFN=""  S HBHCNOD0=^HBHC(632,HBHCDFN,0) D:$P(HBHCNOD0,U,7)="" PROCESS
 W:'$D(^TMP("HBHC",$J)) !!,"No data found for Date Range selected."
 I $D(^TMP("HBHC",$J)) D PRTLOOP^HBHCR19B W !!,HBHCZ,!,"ICD9 Diagnosis Categories Total:  ",HBHCTOT,!,HBHCZ
 D ENDRPT^HBHCUTL1
EXIT ; Exit module
 D EXIT^HBHCR19B
 Q
SETTMP ; Set ^TMP($J
 S ^TMP($J,HBHCCAT,HBHCCATB)="",^TMP($J,"B",$P(^ICD9(HBHCICDP,0),U))=""
 Q
PROCESS ; Process record & build ^TMP("HBHC",$J) global
 S HBHCDPT0=^DPT($P(HBHCNOD0,U),0)
DX ; Process Diagnosis (DX), HBHCDFN must be defined prior to call, returns code plus text in local array HBHCDX
 D DX^HBHCUTL3
 S HBHCI=0 F  S HBHCI=$O(HBHCDX(HBHCI)) Q:HBHCI'>0  S HBHCDX="HBHCDX("_HBHCI_")" D:$D(HBHCFLAG) SET I '$D(HBHCFLAG) D:$D(^TMP($J,"B",$P(@HBHCDX,HBHCSP2))) SET
 Q
SET ; Set ^TMP node
 ; HBH*1*22 shortens SSN to Last 4 only for display; following full SSN left intact since used as subscript
 S ^TMP("HBHC",$J,$P(@HBHCDX,"."),$E($P(HBHCDPT0,U),1,24),$E($P(HBHCDPT0,U,9),1,3)_"-"_$E($P(HBHCDPT0,U,9),4,5)_"-"_$E($P(HBHCDPT0,U,9),6,9),@HBHCDX)=""
 Q

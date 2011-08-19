HBHCTXT ; LR VAMC(IRMS)/MJT-HBHC MFH Rate Paid delimited text file; user selects: pt or MFH; active only, indiv, or all pts or MFHs; current rate paid only or entire rate paid history, entry: TXT called by ^HBHCUTL5; calls ^HBHCUTL5;Dec 2007
 ;;1.0;HOSPITAL BASED HOME CARE;**24**;NOV 01, 1993;Build 201
 ; note: HBHCCNT only defined to allow PT & MFH entry point calls in ^HBHCUTL5
 S (HBHCTXT,HBHCCNT)="",HBHCDLMT=U
 ; Prompt for patient or Medical Foster Home (MFH) report
 D EN^HBHCUTL5
 S %ZIS="Q",HBHCCC=0 K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP EXIT^HBHCUTL5
 I $D(IO("Q")) S ZTRTN="DQ^HBHCTXT",ZTDESC="HBPC MFH Delimited File Output",ZTSAVE("HBHC*")="" D ^%ZTLOAD G EXIT^HBHCUTL5
DQ ; De-queue
 U IO
 ; Write column headers
 W "Patient Name"_HBHCDLMT_"Last Four"_HBHCDLMT_"Rate Paid"_HBHCDLMT_"Start Date" W:HBHCXREF="AK" HBHCDLMT_"Medical Foster Home (MFH) Name"
 D:HBHCXREF="AJ" PT^HBHCUTL5
 D:HBHCXREF="AK" MFH^HBHCUTL5
 I $D(^TMP("HBHC",$J)) D:HBHCXREF="AJ" PRTPT^HBHCUTL5 D:HBHCXREF="AK" PRTMFH^HBHCUTL5
 D EXIT^HBHCUTL5
 Q
TXT ; Output to delimited text file format
 W !,HBHCM_HBHCDLMT_$P(HBHCINFO,U,2)_HBHCDLMT_$P(HBHCINFO,U)_HBHCDLMT_$E(HBHCJ,4,5)_"-"_$E(HBHCJ,6,7)_"-"_$S($E(HBHCJ)=3:20,1:19)_$E(HBHCJ,2,3) W:HBHCXREF="AK" HBHCDLMT_HBHCL
 Q

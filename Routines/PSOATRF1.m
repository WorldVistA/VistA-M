PSOATRF1 ;BIR/MHA - Automate Internet Refill Cont ;07/24/07
 ;;7.0;OUTPATIENT PHARMACY;**264**;DEC 1997;Build 19
 ;Reference ^PSDRUG supported by DBIA 221
 ;
SMAIL ;
 S ZZ="PSOATRF"
 S DV="" F  S DV=$O(^XTMP(ZZ,$J,DV)) Q:DV=""  S DIVN=$P(^PS(59,DV,0),U) D BMAIL
 K ^TMP(ZZ,$J)
 Q
 ;
BMAIL ;
 K ^TMP(ZZ,$J)
 S XMSUB=DIVN_" Internet Refills Not Processed List, ",XMDUZ=.5,XMDUN="Pharmacy Manager"
 S LC=1,^TMP(ZZ,$J,LC)="Internet Refills Not Processed Report for the "_DIVN_" Division.",LC=LC+1
 S ^TMP(ZZ,$J,LC)="",LC=LC+1
 S ^TMP(ZZ,$J,LC)="The following refill requests were not processed:  ",LC=LC+1
 S ^TMP(ZZ,$J,LC)="",LC=LC+1
 S DFN="" F  S DFN=$O(^XTMP(ZZ,$J,DV,DFN)) Q:DFN=""  D
 .D PID^VADPT
 .S ^TMP(ZZ,$J,LC)="Patient: "_$P(^DPT(DFN,0),U)_"   SSN: "_$G(VA("BID")),LC=LC+1
 .S ^TMP(ZZ,$J,LC)="",LC=LC+1
 .S RX="" F  S RX=$O(^XTMP(ZZ,$J,DV,DFN,RX)) Q:RX=""  D
 ..I '$D(^PSRX(RX,0)) S ^TMP(ZZ,$J,LC)="There is no data for IEN #: "_RX,LC=LC+1 Q
 ..S RX0=^PSRX(RX,0)
 ..S ^TMP(ZZ,$J,LC)="  Rx #: "_$P(RX0,U)_"  (REF #"_(1+$$LSTRFL^PSOBPSU1(RX))_")  Qty: "_$P(RX0,U,7),LC=LC+1
 ..S ^TMP(ZZ,$J,LC)="  Drug: "_$S($P(^PSDRUG($P(RX0,U,6),0),U)]"":$P(^PSDRUG($P(RX0,U,6),0),U),1:"UNKNOWN"),LC=LC+1
 ..S ^TMP(ZZ,$J,LC)="  Reason: "_^XTMP(ZZ,$J,DV,DFN,RX),LC=LC+1
 ..S ^TMP(ZZ,$J,LC)="  ",LC=LC+1 S ^TMP(ZZ,$J,LC)="  ",LC=LC+1
 D GRP^PSOATRF
 S:'$O(XMY(0)) XMY(DUZ)=""
 S XMTEXT="^TMP(""PSOATRF"",$J," N DIFROM D ^XMD K XMDUZ,XMTEXT,XMSUB
 Q
 ;

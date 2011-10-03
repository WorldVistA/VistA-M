DVBAB89 ;GT-CAPRI FULL ;05/10/02
 ;;2.7;AMIE;**42**;Apr 10, 1995
 ;
 ;
START(MSG,DFN) ;CALLED BY REMOTE PROCEDURE DVBAB SURGERY CASE
 ;Parameters
 ;=============
 ; MSG : Output - data global ^TMP("SURGERY")
 ; DFN : Patient Identification Number
 ;
 K ^TMP("DVBSURGERY",$J)
 N COUNT,VAR S VAR="",COUNT=0
 I '$D(^DPT(DFN,0)) S ^TMP("DVBSURGERY",$J,COUNT)="Not a valid patient" Q
 I $D(^SRF("B",DFN)) D
 . F  S VAR=$O(^SRF("B",DFN,VAR)) Q:VAR=""  D
 . . S DVBSROP=$P(^SRF(VAR,"OP"),"^",1)
 . . D ^DVBASRP1
 . . S ^TMP("DVBSURGERY",$J,COUNT)=VAR_"^"_$P(^SRF(VAR,0),"^",9)_"^"_DVBSROP_$C(13)
 . . S COUNT=COUNT+1
 S MSG=$NA(^TMP("DVBSURGERY",$J))
 Q
 ;
XDA(MSG,DFN) ;CALLED BY REMOTE PROCEDURE DVBAB ORIGINAL PROCESSING DATE
 K ^TMP("REPRINT",$J)
 N VAR,COUNT
 I '$D(DFN) S ^TMP("REPRINT",$J,COUNT)="0^Undefined Patient IEN" Q
 S DIC=2,DIC(0)="NZX",X=DFN D ^DIC I Y<0 D
 . S ^TMP("REPRINT",$J,COUNT)="0^Invalid Patient Name." Q
 S VAR="",COUNT=0
 I $D(^DVB(396,"B",DFN)) D
 . F  S VAR=$O(^DVB(396,"B",DFN,VAR)) Q:VAR=""  D
 . . I $D(^DVB(396,VAR,4)),$P(^DVB(396,VAR,4),U,4)]"",$D(^DVB(396,VAR,2)),$P(^DVB(396,VAR,2),U,10)'="L",$D(^DPT($P(^DVB(396,VAR,0),U,1),0)) D
 . . . S ^TMP("REPRINT",$J,COUNT)=VAR_"^"_$P(^DVB(396,VAR,4),"^",2)_$C(13)
 . . . S COUNT=COUNT+1
 S MSG=$NA(^TMP("REPRINT",$J))
 Q

IBOUNP2 ;ALB/CJM - OUTPATIENT INSURANCE REPORT ;JAN 25,1992
 ;;2.0;INTEGRATED BILLING;**249**;21-MAR-94
 ;;Per VHA Directive 10-93-142, this routine should not be modified.
 ;
 ; IBOTIME appointment time
 ; IBODIV  division
 ; IBOCLNC clinic
 ; IBOCTG category vet is in (no=noinsurance,expired,unknow)
 ; IBOEND2  end of the date range + 30 days
 ; IBOINS =1 in there is insurance data
 ; IBORPTD =1 if appt should appear on report
 ;
LOOPPT ; loops through patients returned from API
 N IBOCLNC,IBOTIME,IBOEND2,IBOCTG,IBOINS,IBORPTD,IBONAME S DFN=""
 S X1=IBOEND,X2=30 D C^%DTC S IBOEND2=X
 F  S DFN=$O(^TMP($J,"SDAMA301",DFN)) Q:'DFN  I $$VET(DFN) S IBOTIME=$O(^TMP($J,"SDAMA301",DFN,0)),IBSDDAT=^TMP($J,"SDAMA301",DFN,IBOTIME) D INFO,INDEX:IBORPTD
 Q
 ;
INFO ; looks up info, assumes IBSDDAT
 S IBONAME=$P($P(IBSDDAT,"^",4),";",2)
 S IBOCLNC=+$P(IBSDDAT,"^",2)
 S IBOCLN=$P($P(IBSDDAT,"^",2),";",2) I IBOCLN="" S IBOCLN="NOT KNOWN"
 S IBODIV=$P($G(^SC(IBOCLNC,0)),"^",15) S:IBODIV IBODIV=$P($G(^DG(40.8,IBODIV,0)),"^",1) S:IBODIV="" IBODIV="UNKNOWN"
 S IBORPTD=0 D UNK:IBOUK,EXP:'IBORPTD&IBOEXP,UNI:'IBORPTD&IBOUI
 Q
 ;
VET(DFN) ; checks if patient is a vet
 D ELIG^VADPT
 Q $S(VAERR:0,VAEL(4):1,1:0)
 ;
INDEX ; indexes appointment
 S ^TMP("IBOUNP",$J,IBOCTG,IBODIV,IBOCLN,IBONAME,DFN)=IBOTIME
 Q
UNK ; goes in 'unknown' category if the field COVERED BY HEALTH INSURANCE
 ; was not answered, was answered unknown, and there is no insurance data
 S IBORPTD=0 N T S T=$P($G(^DPT(DFN,.31)),"^",11) I T="U"!(T="") D CKINS I 'IBOINS S IBOCTG="UNKNOWN",IBORPTD=1 Q
 Q
EXP ; goes in expired category only if there is insurance and
 ; all of it expired before end of specified period + 30 days
 S IBORPTD=0 N T,E D CKINS Q:'IBOINS
 S IBORPTD=1,IBOCTG="EXPIRED" F T=0:0 S T=$O(^DPT(DFN,.312,T)) Q:T'>0  S E=$P($G(^(T,0)),"^",4) I E=""!(E>IBOEND2) S IBORPTD=0 Q
 Q
UNI ; goes in unisured category if there is no insurance data and 
 ; the field COVERED BY HEALTH INSURANCE was answered YES or NO
 S IBORPTD=0 N T S T=$P($G(^DPT(DFN,.31)),"^",11) I T="N"!(T="Y") D CKINS I 'IBOINS S IBOCTG="NO",IBORPTD=1
 Q
CKINS ; checks if any insurance in insurance multiple of patient record
 S IBOINS=0 I $O(^DPT(DFN,.312,0)) S IBOINS=1
 Q

IBOUNP5 ;ALB/CJM - INPATIENT INSURANCE REPORT ;JAN 25,1992
 ;;Version 2.0 ; INTEGRATED BILLING ;; 21-MAR-94
 ; TIME appointment or admission time time
 ; CTG category vet is in (no,expired,unknow)
 ; INS =1 in there is insurance data
 ; RPTD =1 if appt should appear on report
 ; IBOPICK ="D" if the user chose to enter a date range, otherwise ="C"
 ;              for the current date
 ; END2 30 days into the future, starting either from the curren date
 ;       or END, depending on IBOPICK
LOOP ; loops through inpatients
 N DIV,DFN,PAT,TIME,CTG,INS,QUIT,RPTD,END2
 I IBOPICK="C" D LOOP1
 I IBOPICK="D" D LOOP2
 Q
LOOP1 ; finds current admissions for selected divisions
 N TDY,WRD,WRDN,ADM,DTH,R S WRD=0
 D NOW^%DTC S (TDY,X1)=X,X2=30 D C^%DTC S END2=X
 F  S WRD=$O(^DIC(42,WRD)) Q:WRD'>0  S R=$G(^(WRD,0)),DIV=$P(R,"^",11),WRDN=$P(R,"^",1) D DIV I 'QUIT&(WRDN]"") D
 . S DFN=0 F  S DFN=$O(^DPT("CN",WRDN,DFN)) Q:DFN'>0  S ADM=^(DFN) I ADM]"",$P($G(^DGPM(+ADM,0)),"^",2)=1 S TIME=+^(0),DTH=+$G(^DPT(DFN,.35)) D:'DTH!((DTH\1)=TDY) PROC
 Q
LOOP2 ; finds admissions during selected date range for selected divisions
 N WRD0,WRDN
 N T S X1=IBOEND,X2=30 D C^%DTC S END2=X
 S T=(IBOBEG-.0001)
 F  S T=$O(^DGPM("AMV1",T)) Q:'T!(T>(IBOEND+.99))  D
 .S DFN=0 F  S DFN=$O(^DGPM("AMV1",T,DFN)) Q:'DFN  S DIV="",DIV=$O(^DGPM("AMV1",T,DFN,DIV)) Q:DIV'>0  S WRD0=$G(^DIC(42,+$P($G(^DGPM(DIV,0)),U,6),0)),DIV=+$P(WRD0,U,11),WRDN=$P(WRD0,"^"),TIME=T,QUIT=0 D:DIV PROC
 Q
PROC ;
 D DIV:IBOPICK'="C",DONE:'QUIT,VET:'QUIT S RPTD=0 D:'QUIT UNK:IBOUK,EXP:'RPTD&IBOEXP,UNI:'RPTD&IBOUI,INDEX:RPTD
 Q
VET ; checks if patient is a vet
 S QUIT=1 D ELIG^VADPT Q:VAERR  S:VAEL(4) QUIT=0
 Q
DONE ; checks if patient already on report
 S:$D(^TMP($J,"PATIENTS",DFN)) QUIT=1
 Q
INDEX ; indexes appointment,also indexs vet so he won't be reported twice
 N NAME,D
 S D=""
 I DIV S D=$P($G(^DG(40.8,DIV,0)),"^",1)
 I D="" S D="NOT KNOWN"
 I WRDN="" S WRDN="NOT KNOWN"
 S NAME=$P($G(^DPT(DFN,0)),"^",1) Q:NAME'[""
 S ^TMP($J,CTG,D,$S(IBOBYWRD:WRDN,1:"ALL WARDS"),NAME,DFN)=TIME_"^"_WRDN
 S ^TMP($J,"PATIENTS",DFN)=""
 Q
UNK ; goes in 'unknown' category if the field COVERED BY HEALTH INSURANCE
 ; was not answered, was answered unknown, and there is no insurance data
 S RPTD=0 N T S T=$P($G(^DPT(DFN,.31)),"^",11) I T="U"!(T="") D CKINS I 'INS S CTG="UNKNOWN",RPTD=1 Q
 Q
EXP ; goes in expired category only if there is insurance and
 ; all of it expired before end of specified period + 30 days
 S RPTD=0 N T,E D CKINS I 'INS Q
 S RPTD=1,CTG="EXPIRED" F T=0:0 S T=$O(^DPT(DFN,.312,T)) Q:T'>0  S E=$P($G(^(T,0)),"^",4) I E=""!(E>END2) S RPTD=0 Q
 Q
UNI ; goes in unisured category if there is no insurance data and 
 ; the field COVERED BY HEALTH INSURANCE was answered YES or NO
 S RPTD=0 N T S T=$P($G(^DPT(DFN,.31)),"^",11) I T="N"!(T="Y") D CKINS I 'INS S CTG="NO",RPTD=1
 Q
CKINS ; checks if any insurance in insurance multiple of patient record
 S INS=0 I $O(^DPT(DFN,.312,0)) S INS=1
 Q
DIV ; checks if the division is on the list VAUTD()
 S QUIT=0 I VAUTD=1 Q
 I 'DIV S QUIT=1 Q
 I '$D(VAUTD(+DIV)) S QUIT=1
 Q

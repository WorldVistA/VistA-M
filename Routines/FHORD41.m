FHORD41 ; HISC/REL/NCA - Isolation List ;4/27/93  08:07 
 ;;5.5;DIETETICS;;Jan 28, 2005
 W @IOF,!!?19,"I S O L A T I O N / P R E C A U T I O N S",!!
 W ! K IOP,%ZIS S %ZIS("A")="Select LIST Printer: ",%ZIS="MQ" D ^%ZIS K %ZIS,IOP G:POP KIL
 I $D(IO("Q")) S FHPGM="F1^FHORD41",FHLST="" D EN2^FH G KIL
 U IO D F1 D ^%ZISC K %ZIS,IOP G KIL
KIL K ^TMP($J) G KILL^XUSCLEAN
F1 ; List Isolations
 D NOW^%DTC S NOW=%,DT=NOW\1 K ^TMP($J)
 F FHDFN=0:0 S FHDFN=$O(^FHPT("AIS",FHDFN)) Q:FHDFN<1  F ADM=0:0 S ADM=$O(^FHPT("AIS",FHDFN,ADM)) Q:ADM<1  D F2
 S PG=0 D HDR S WRDN=""
 F L1=0:0 S WRDN=$O(^TMP($J,WRDN)) Q:WRDN=""  S RM="" F L2=0:0 S RM=$O(^TMP($J,WRDN,RM)) Q:RM=""  F FHDFN=0:0 S FHDFN=$O(^TMP($J,WRDN,RM,FHDFN)) Q:FHDFN<1  S Y0=$G(^TMP($J,WRDN,RM,FHDFN)) D F3
 ;Add outpatient ISOLATION/PRECAUTIONS
 W !!,"O U T P A T I E N T S",!,"======================"
 W !!,"PATIENT",?34,"PLATE  DELIVERY"
 F FHDFN=0:0 S FHDFN=$O(^FHPT("IP",FHDFN)) Q:FHDFN'>0  D
 .S FHIP=$P($G(^FHPT(FHDFN,0)),U,5) I FHIP="" Q
 .D PATNAME^FHOMUTL
 .S FHIPZN=$G(^FH(119.4,FHIP,0)),FHPC=$P(FHIPZN,U,2),FHDL=$P(FHIPZN,U,3)
 .W !!,FHPTNM,?34
 .W $S(FHPC="P":"Paper",1:"China"),"  ",$S(FHDL="N":"Nurse",1:"Food Svc")
 W ! Q
F2 D PATNAME^FHOMUTL I DFN="" Q
 I '$D(^DPT(DFN,.1)) K ^FHPT("AIS",FHDFN,ADM) Q
 S X=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",8) I $G(^FHPT("AW",+X,FHDFN))'=ADM K ^FHPT("AIS",FHDFN,ADM) Q
 S WRDN=$P($G(^FH(119.6,+X,0)),"^",1),RM=$G(^DPT(DFN,.101)) S:RM="" RM=" "
 S PRE=$P($G(^FHPT(FHDFN,"A",ADM,0)),"^",10) Q:'PRE
 D CUR^FHORD7 S X=$P(X,"^",8) I X'="" S Y=Y_" ("_X_")"
 S ^TMP($J,WRDN,RM,FHDFN)=PRE_"^"_Y Q
F3 D PATNAME^FHOMUTL I DFN="" Q
 S PRE=$P(Y0,"^",1),Y0=$P(Y0,"^",2),X0=^DPT(DFN,0),X1=$G(^FH(119.4,+PRE,0)),X2=$P(X1,"^",3),X1=$P(X1,"^",2) D PID^FHDPA D:$Y>57 HDR
 W !!,$E(WRDN,1,15),?17,$E(RM,1,10),?29,$E($P(X0,"^",1),1,23),?54,BID,?62,$S(X1="P":"Paper",1:"China"),"  ",$S(X2="N":" Nurse",1:"Food Svc")
 W:Y0'="" !?3,"Diet: ",Y0 Q
HDR W:'($E(IOST,1,2)'="C-"&'PG) @IOF S PG=PG+1 W !?18,"I S O L A T I O N / P R E C A U T I O N S",?71,"Page ",PG
 S DTP=NOW D DTP^FH W !!?31,DTP
 W !!,"I N P A T I E N T S",!,"===================="
 W !!,"WARD",?17,"ROOM",?29,"PATIENT",?55,"ID#",?62,"PLATE  DELIVERY" Q

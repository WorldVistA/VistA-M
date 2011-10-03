SDCWL3 ;ALB/MLI - CLINIC WORKLOAD REPORT CONTINUATION ; 25 MAY 88
 ;;5.3;Scheduling;**540**;Aug 13, 1993;Build 2
SET Q:'$D(^SC(I,"S"))!'$D(^(0))!($O(^("S",SDBD))="")!($O(^(SDBD))>SDED)  S SDST=^SC(I,0),SDN=$P(SDST,U),SDSC=$P(SDST,U,7),SDDIV=$S(+$P(SDST,U,15):$P(SDST,U,15),1:$O(^DG(40.8,0))) I SDSC']"" S ^TMP($J,"ERR",1,SDN)="" Q
 I 'VAUTD,'$D(VAUTD(SDDIV)) Q
 S SDSC=$S($D(^DIC(40.7,SDSC,0)):$P(^(0),U,2),1:0) I 'SDSC S ^TMP($J,"ERR",2,SDN)="" Q
 I SDSC=900 S ^TMP($J,"ERR",3,SDN)="" Q
 S SDCR=$S($D(^DIC(40.7,+$P(^SC(I,0),"^",18),0)):$P(^(0),"^",2),1:0) I SDCR>899,(SDCR<908) S ^TMP($J,"ERR",4,SDN)=""
 I SDS="S" S (SDF1,SDF2)=0 S:SDALL!$D(SDCL(SDSC)) ^TMP($J,"SC",SDSC,SDN,0)="",SDF1=1 I SDCR,SDCR'=SDSC I (SDALL!$D(SDCL(SDCR))) S SDF2=1,^TMP($J,"SC",SDCR,SDN,1)=""
 S:SDS="C" SDF1=1 I SDS="S",'SDF1,'SDF2 Q
 ;SD*5.3*540 - added Q:'DFN in 2nd FOR loop
 F J=SDBD:0 S J=$O(^SC(I,"S",J)) Q:'J!(J>SDED)  F K=0:0 S K=$O(^SC(I,"S",J,1,K)) Q:'K  I $D(^(K,0)) S DFN=$P(^(0),U) Q:'DFN  S SDOB=$S('$D(^("OB")):0,^("OB")]"":1,1:0) I $D(^DPT(DFN,0)),$D(^("S",J,0)) D PRO^SDCWL2
 S SDOB=0 F J=SDBD:0 S J=$O(^DPT("ASDCN",I,J)) Q:'J!(J>SDED)  F K=0:0 S K=$O(^DPT("ASDCN",I,J,K)) Q:'K  I $D(^DPT(K,"S",J,0)),$S($P(^(0),U,2)["C":1,+^(0)'=I:1,1:0) S DFN=K,SDAS="C" D
 .S Y=0 F  S Y=$O(^SC(I,"S",J,1,Y)) Q:'Y  I $D(^(Y,0)),DFN=+^(0) Q
 .D:'Y PRO1^SDCWL2
 Q
ERR W @IOF S SDPG=SDPG+1,SDFL=0 W !?37,"***ERRORS***",?70,"PAGE: ",$J(SDPG,4) I $D(^TMP($J,"ERR",1)) W !!,"No stop code assigned to the following clinics:" S I=0 F I1=0:0 S I=$O(^TMP($J,"ERR",1,I)) Q:I=""  W !?3,I S SDFL=1
 I $D(^TMP($J,"ERR",2)) W !!,"Invalid pointer to stop code file for the following clinics:" S I=0 F I1=0:0 S I=$O(^TMP($J,"ERR",2,I)) Q:I=""  W !?3,I S SDFL=1
 I SDFL W !!,"***APPTS MADE TO CLINICS ABOVE WERE NOT INCLUDED IN WORKLOAD COMPUTATIONS***"
 S SDFL=0 I $D(^TMP($J,"ERR",3)) W !!,"Stop code between 900 and 907 assigned to the following clinics:" S I=0 F I1=0:0 S I=$O(^TMP($J,"ERR",3,I)) Q:I=""  W !?3,I S SDFL=1
 I $D(^TMP($J,"ERR",4)) W !!,"Credit stop code between 900 and 907 assigned to the following clinics:" S I=0 F I1=0:0 S I=$O(^TMP($J,"ERR",4,I)) Q:I=""  W !?3,I S SDFL=1
 I SDFL W !,"***THESE STOP CODES MUST BE CHANGED TO ACTIVE STOP CODES***",!,"***THEY WERE INCLUDED IN WORKLOAD***"
 Q
LEG I SD1 F S=$Y:1:(IOSL-10) W !
 I SD1 W ! F S=3:1:6 W !?11,$P($T(LEG+S),";;",2)
 S SD1=1 Q
 ;;TOTAL PATIENTS SEEN = SCHED + UNSCHED + INPAT + OVERBOOKS + ADD/EDITS
 ;;
 ;;CANCELLED APPTS AND NO-SHOWS ARE NOT INCLUDED IN THE ABOVE TOTALS AND
 ;;              ARE GIVEN FOR STATISTICAL PURPOSES ONLY.
NONE W @IOF,"***CLINIC WORKLOAD REPORTS HAVE RUN -- NO MATCHES FOUND***",!!!,"DATE RANGE: ",SDB,"-",SDE,!,"  DATE RUN: ",SDNOW,!,"SORTED BY ",$S(SDS="C":"CLINIC",1:"STOP CODE"),"(S): ",$S(SDALL!VAUTC:"ALL",1:"") Q:(SDALL!VAUTC)
 I SDS="S" F I=0:0 S I=$O(SDCL(I)) Q:'I  W I,", "
 I SDS="C" F I=0:0 S I=$O(VAUTC(I)) Q:'I  W VAUTC(I),", "
 W !,"FOR DIVISION(S): " W:VAUTD "ALL" I 'VAUTD F I=0:0 S I=$O(VAUTD(I)) Q:'I  W VAUTD(I),", "
 Q

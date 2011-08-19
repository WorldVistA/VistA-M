SDCWL1 ;ALB/MLI - CLINIC WORKLOAD REPORT PRINTOUT ; 27 APRIL 88
 ;;5.3;Scheduling;**140**;Aug 13, 1993
 G:SDS="C" CLIN
 F I=2:0 D SCT S I=$O(^TMP($J,"SC",I)) Q:'I  D ISC S J=0 F J1=0:0 D T:J'="{",AT:J="{" S J=$O(^TMP($J,"SC",I,J)) Q:J=""  D:J="{" ADD I J'="{" F K=-1:0 S K=$O(^TMP($J,"SC",I,J,K)) Q:K=""  I $D(^TMP($J,"SC",1,I)),^(I) D HD1,I,SORT
 Q
CLIN S J=0 F J1=0:0 D T S J=$O(^TMP($J,1,J)) Q:J=""  I $D(^TMP($J,"CL",1,J)),^(J) D HD1,I,SORT
 Q
SORT W !,J W:SDS="S"&K ?24,"***",I," IS THE CREDIT STOP CODE FOR THIS CLINIC***" F R=0:0 S R=$O(^TMP($J,1,J,R)) Q:'R  D NM:SDNAM,PRINT
 Q
NM S M=0 F M1=0:0 S M=$O(^TMP($J,1,J,R,"NM",M)) Q:M=""  S N=0 F N1=0:0 S N=$O(^TMP($J,1,J,R,"NM",M,N)) Q:N=""  S P=0 F P1=0:0 S P=$O(^TMP($J,1,J,R,"NM",M,N,P)) Q:P=""  S Q=0 F Q1=0:0 S Q=$O(^TMP($J,1,J,R,"NM",M,N,P,Q)) Q:Q=""  D PN
 Q
PN D:$Y>(IOSL-15) HD1
 W !?12,$S(SDHR'=R:$S(SDF="D":$TR($$FMTE^XLFDT(R,"5DF")," ","0"),1:$E(R,4,5)_"-"_$E(R,2,3)),1:"") S SDHR=R W ?24,$E(M,1,17),?43,$E(N,1,3),"-",$E(N,4,5),"-",$E(N,6,9)
 W ?56,$S(Q["C":"CANCELLED",Q="NT":"ACTION REQ'D",Q["N":"NO-SHOW",Q["I":"INPATIENT",Q="OB":"OVERBOOK",Q="U":"UNSCHEDULED",Q="S":"SCHEDULED",1:" "),?69,"TIME: ",P
 Q
PRINT I $Y>(IOSL-12)&$S('SDNAM&(R>-1):1,'SDNAM:0,SDNAM&(M>-1):1,1:0) D HD1
 W ! W:'SDNAM ?14,$S(SDF="D":$TR($$FMTE^XLFDT(R,"5DF")," ","0"),1:$E(R,4,5)_"-"_$E(R,2,3)) I SDNAM K Y S $P(Y,"_",57)="" W ?24,Y,!
 W ?30,$J(^TMP($J,1,J,R,"SD"),4),?36,$J(^("UN"),4),?42,$J(^("IN"),4),?48,$J(^("OB"),4),?55,"N/A",?60,$J(^("NS"),4),?66,$J(^("CA"),4),?76,$J(^("SD")+^("UN")+^("IN")+^("OB"),4) W:SDNAM !
 S SDSCH=SDSCH+^TMP($J,1,J,R,"SD"),SDUN=SDUN+^("UN"),SDIN=SDIN+^("IN"),SDOB=SDOB+^("OB"),SDNS=SDNS+^("NS"),SDCA=SDCA+^("CA")
 S:SDS="S" SDSCS=SDSCS+^("SD"),SDSCU=SDSCU+^("UN"),SDSCI=SDSCI+^("IN"),SDSCO=SDSCO+^TMP($J,1,J,R,"OB"),SDSCN=SDSCN+^("NS"),SDSCC=SDSCC+^("CA") Q  ;NAKED REFERENCE - ^TMP($J,1,Clinic,Date,Appt.Type)
HD1 D LEG^SDCWL3 S SDPG=SDPG+1
 W @IOF,!?29,"CLINIC WORKLOAD REPORT",?71,"PAGE: ",$J(SDPG,3),!?27,$S(SDF="D":"DETAILED BY DAY",1:"SUMMARY BY MONTH")," BY ",$S(SDS="C":"CLINIC",1:"STOP CODE"),!?21,"PERIOD COVERING:  ",SDB1,"-",SDE1,!?25,"DATE RUN ON:  ",SDNOW
 W !!?72,"TOTAL",!?29,"SCHED",?35,"UNSCH",?41,"INPAT",?47,"OVER-",?53,"ADD/",?59,"NO-",?65,"CANCEL",?72,"PATIENTS"
 W !,"CLINIC NAME",?14,"DATE",?29,"APPTS",?35,"APPTS",?41,"APPTS",?47,"BOOKS",?53,"EDITS",?59,"SHOWS",?65,"APPTS",?72,"SEEN",!! W:SDS="S" "STOP CODE:",?14,I Q
I S (SDT,SDSCH,SDUN,SDIN,SDOB,SDNS,SDCA)=0 Q
ISC S (SDAED,SDSCS,SDSCU,SDSCI,SDSCO,SDSCN,SDSCC)=0 Q
T Q:$S('$D(^TMP($J,"CL",1,J)):1,'^(J):1,1:0)
 K Y S $P(Y,"_",67)="" W !!?14,Y,!?14,"Clinic Total",?30,$J(SDSCH,4),?36,$J(SDUN,4),?42,$J(SDIN,4),?48,$J(SDOB,4),?55,"N/A",?60,$J(SDNS,4),?66,$J(SDCA,4) S SDTOT=SDSCH+SDUN+SDIN+SDOB W ?76,$J(SDTOT,4) Q
SCT Q:$S(I=2:1,'$D(^TMP($J,"SC",1,I)):1,'^(I):1,1:0)  S SDTOT=SDSCS+SDSCU+SDSCI+SDSCO+$S('SDADD:0,1:SDAED)
 K Y S $P(Y,"_",81)="" W !!,Y,!,"Stop Code ",I," Total",?30,$J(SDSCS,4),?36,$J(SDSCU,4),?42,$J(SDSCI,4),?48,$J(SDSCO,4),?54,$J($S('SDADD:"N/A",1:SDAED),4),?60,$J(SDSCN,4),?66,$J(SDSCC,4),?76,$J(SDTOT,4) Q
ADD D HD1 W !,"ADD/EDIT" S K=3 F K1=0:0 S SDHK=0,K=$O(^TMP($J,"SC",I,J,K)) Q:K=""  D ADD1:SDNAM,PRADD
 Q
ADD1 S L=0 F L1=0:0 S L=$O(^TMP($J,"SC",I,J,K,L)) Q:L=""  S M=0 F M1=0:0 S M=$O(^TMP($J,"SC",I,J,K,L,M)) Q:M=""  F N=0:0 S N=$O(^TMP($J,"SC",I,J,K,L,M,N)) Q:'N  F P=0:0 S P=$O(^TMP($J,"SC",I,J,K,L,M,N,P)) Q:'P  D PA
 Q
PA W !?14,$S(SDHK'=K:$S(SDF="D":$E(K,4,5)_"-"_$E(K,6,7)_"-"_$E(K,2,3),1:$E(K,4,5)_"-"_$E(K,2,3)),1:"") S SDHK=K W ?24,$E(L,1,17),?43,$E(M,1,3),"-",$E(M,4,5)
 W "-",$E(M,6,9),?56,"ADD/EDIT",?69,"TIME: " S Y=N X ^DD("DD") W $P(Y,"@",2) Q
AT K Y S $P(Y,"_",67)="" W !?14,Y,!?14,"Add/Edit Total",?31,"N/A",?37,"N/A",?43,"N/A",?49,"N/A",?54,$J(SDAED,4),?61,"N/A",?67,"N/A",?76,$J(SDAED,4) Q
PRADD D:($Y>(IOSL-8))&($O(^TMP($J,"SC",I,"{",K))'="") HD1 W ! W:'SDNAM ?14,$S(SDF="D":$E(K,4,5)_"-"_$E(K,6,7)_"-"_$E(K,2,3),1:$E(K,4,5)_"-"_$E(K,2,3)) I SDNAM K Y S $P(Y,"_",57)="" W ?24,Y,!
 S SDNUM=^TMP($J,"SC",I,"{",K) W ?31,"N/A",?37,"N/A",?43,"N/A",?49,"N/A",?54,$J(SDNUM,4),?61,"N/A",?67,"N/A",?76,$J(SDNUM,4) S SDAED=SDAED+SDNUM Q

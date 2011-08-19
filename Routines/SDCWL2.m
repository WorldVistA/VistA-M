SDCWL2 ;ALB/MLI - CONTINUATION OF CLINIC WORKLOAD REPORTS ; 07 Mar 99  6:41 PM
 ;;5.3;Scheduling;**140,132,171,184,529**;Aug 13, 1993;Build 3
PRO S SDAS=$S($P(^SC(I,"S",J,1,K,0),U,9)="C":"C",1:$P(^DPT(DFN,"S",J,0),U,2)) S SDP=$P(^DPT(DFN,"S",J,0),U,7)
PRO1 S SDP=$P(^DPT(DFN,"S",J,0),U,7) S:SDS="C" ^(SDN)=$S($D(^TMP($J,"CL",'$D(SDFL),SDN)):^(SDN),1:0)
 I SDS="S" S:SDF1 ^(SDSC)=$S($D(^TMP($J,"SC",'$D(SDFL),SDSC)):^(SDSC),1:0) I SDF2 S ^(SDCR)=$S($D(^TMP($J,"SC",'$D(SDFL),SDCR)):^(SDCR),1:0)
 S $P(^TMP($J,"CL",'$D(SDFL),SDN),"^")=1 I SDS="S" S:SDF1 $P(^TMP($J,"SC",'$D(SDFL),SDSC),"^")=1 I SDF2 S $P(^TMP($J,"SC",'$D(SDFL),SDCR),"^")=1
 I SDAS'["C",SDAS'="N",SDAS'="NA" S:SDS="C" $P(^(SDN),U,2)=$P(^TMP($J,"CL",'$D(SDFL),SDN),U,2)+1 I SDS="S" S:SDF1 $P(^(SDSC),U,2)=$P(^TMP($J,"SC",'$D(SDFL),SDSC),U,2)+1 I SDF2 S $P(^(SDCR),U,2)=$P(^TMP($J,"SC",'$D(SDFL),SDCR),U,2)+1
 I $D(SDFL) S:SDS="C" ^(SDN)=$S($D(^TMP($J,"CL",1,SDN)):^(SDN),1:0) I SDS="S" S:SDF1 ^(SDSC)=$S($D(^TMP($J,"SC",1,SDSC)):^(SDSC),1:0) S:SDF2 ^(SDCR)=$S($D(^TMP($J,"SC",1,SDCR)):^(SDCR),1:0)
 Q:$D(SDFL)!(SDRT="B")  S SDAPT=$S(SDF="D":J\1,1:J\100) S:'$D(^TMP($J,1,SDN,SDAPT)) (^(SDAPT,"CA"),^("NS"),^("IN"),^("OB"),^("UN"),^("SD"))=0
 S TIME=$E($P(J,".",2)_"0000",1,4),TIME=$E(TIME,1,2)_":"_$E(TIME,3,4)
 S:SDNAM SDPN=$E($P(^DPT(DFN,0),U),1,20),SDSSN=$S($P(^(0),U,9)]"":$P(^(0),U,9),1:0),^TMP($J,1,SDN,SDAPT,"NM",SDPN,SDSSN,TIME,$S(SDAS]"":SDAS,SDOB:"OB",SDP=1:"S",SDP=3:"S",SDP=4:"U",1:" "))=""  ;added SDP=1 SD*529
 K TIME I SDAS["C" S ^("CA")=^TMP($J,1,SDN,SDAPT,"CA")+1 Q
 I SDAS="N"!(SDAS="NA") S ^("NS")=^TMP($J,1,SDN,SDAPT,"NS")+1 Q
 I SDAS["I" S ^("IN")=^TMP($J,1,SDN,SDAPT,"IN")+1 Q
 I SDOB S ^("OB")=^TMP($J,1,SDN,SDAPT,"OB")+1 Q
 I SDP=4 S ^("UN")=^TMP($J,1,SDN,SDAPT,"UN")+1 Q
 S ^("SD")=^TMP($J,1,SDN,SDAPT,"SD")+1 Q
PREV S SDBD=SDBD+.1,SDED=SDED-.9,SDBO=$TR($$FMTE^XLFDT(SDBD,"2FD")," ","0"),SDEO=$TR($$FMTE^XLFDT(SDED,"2FD")," ","0"),I=0,SDSUB=$S(SDS="C":"CL",1:"SC") D COMPHEAD
 F I1=0:0 S I=$O(^TMP($J,SDSUB,1,I)) Q:I=""  S SDCUR=+$P(^(I),"^",2),SDOLD=+$S($D(^TMP($J,SDSUB,0,I)):$P(^(I),"^",2),1:0) D:($Y>(IOSL-8)) EOP,COMPHEAD D COMPARE
 D EOP Q
COMPHEAD S SDPG=SDPG+1 W @IOF,!?29,"CLINIC WORKLOAD REPORT",?71,"PAGE: ",$J(SDPG,3),!?22,"COMPARISON OF VISITS TO PREVIOUS YEAR",!?20,"FOR PERIOD COVERING:  ",SDB1,"-",SDE1,!?26,"REPORT RUN ON:  ",SDNOW,!! K Y S $P(Y,"_",81)="" W Y D BLANK
 W !,"|",?25,"|",?29,"# OF VISITS",?43,"|",?47,"# OF VISITS",?61,"|",?64,"NET",?70,"|",?74,"%",?79,"|",!,"|",?7,$S(SDS="C":"Clinic",1:"Stop Code")," Name",?25,"|",SDB,"-",SDE,"|",SDBO,"-",SDEO,"| CHANGE | CHANGE |" D EOP,EOP,BLANK Q
COMPARE W !,"|",$S(SDS="C":$E(I,1,24),1:$J(I,15)),?25,"|",?31,$J(SDCUR,7),?43,"|",?49,$J(SDOLD,7),?61,"|" S X=SDCUR-SDOLD W $J($S(X>0:"+"_X,2:X),7,2),?70,"|",$S(SDOLD=0:"    N/A",1:$J(X*100/SDOLD,7,2))," |" Q
EOP W !,"|" K Y S $P(Y,"_",25)="" W Y,"|",$E(Y,1,17),"|",$E(Y,1,17),"|",$E(Y,1,8),"|",$E(Y,1,8),"|" Q
BLANK W !,"|",?25,"|",?43,"|",?61,"|",?70,"|",?79,"|" Q
ADDON I 'SDALL&'$D(SDCL(SDSC)) Q
 S J=SDOE,I=+SDOE0
 S DIV=$S($P(SDOE0,"^",11)]"":$P(SDOE0,"^",11),1:$O(^DG(40.8,0))),DFN=+$P(SDOE0,U,2) Q:'VAUTD&'$D(VAUTD(DIV))
 S $P(^TMP($J,"SC",'$D(SDFL),SDSC),"^")=1,$P(^(SDSC),"^",2)=$P(^(SDSC),"^",2)+1 Q:(SDRT="B")  S ^("{")=$S($D(^(SDSC,"{")):^("{")+1,1:1),SDAPT=$S(SDF="D":I\1,1:I\100)
 Q:$D(SDFL)  S ^(SDAPT)=$S($D(^TMP($J,"SC",SDSC,"{",SDAPT)):^(SDAPT)+1,1:1)
 Q:'SDNAM  S SDNM=$P(^DPT(DFN,0),U),SDSSN=$S($P(^(0),U,9)]"":$P(^(0),U,9),1:0),^TMP($J,"SC",SDSC,"{",SDAPT,SDNM,SDSSN,I,J)="" Q

ONCSRVRP ;Hines OIFO/RVD - REGISTRY SERVER REPORT ;06/26/13
 ;;2.2;ONCOLOGY;**1**;Jul 31, 2013;Build 8
 ;
TK ;Tasked [RS Registry Summary Reports - Today] report 
 S YR="T"
 N G,W,ONCAC,ONCANA,ONCNON,ONCMI,ONCIN,ONCWA,ONCXD0,ONCDIV,X0,X1,X2
 N ONCPA,ONCCO,START,END,XMY,XMTEXT,RPTDATE
 K ^TMP($J)
 S Y=DT D DD^%DT S RPTDATE=Y
 S G=0,XD0=0 F  S XD0=$O(^ONCO(165.5,"AG",G,XD0)) Q:XD0'>0  D
 .S ONCDIV=$P(^DIC(4,$$DIV^ONCFUNC(XD0),0),U,1)
 .I $P($G(^ONCO(165.5,XD0,7)),"^",2)'="A" D
 ..S:'$D(G(ONCDIV,G)) G(ONCDIV,G)=0
 ..S G(ONCDIV,G)=G(ONCDIV,G)+1
 S G=1,XD0=0 F  S XD0=$O(^ONCO(165.5,"AG",G,XD0)) Q:XD0'>0  D
 .S ONCDIV=$P(^DIC(4,$$DIV^ONCFUNC(XD0),0),U,1)
 .I $P($G(^ONCO(165.5,XD0,7)),"^",2)'="A" D
 ..S:'$D(G(ONCDIV,G)) G(ONCDIV,G)=0
 ..S G(ONCDIV,G)=G(ONCDIV,G)+1
 S W=0,X0=0 F  S X0=$O(^ONCO(160,"ADX",X0)) Q:'X0  S X1=0 F  S X1=$O(^ONCO(160,"ADX",X0,X1)) Q:'X1  S X2=0 D
 .F  S X2=$O(^ONCO(160,"ADX",X0,X1,X2)) Q:'X2  D
 ..S ONCDIV=$P(^DIC(4,$$SUSDIV^ONCFUNC(X1,X2),0),U,1)
 ..S:'$D(W(ONCDIV)) W(ONCDIV)=0
 ..S W(ONCDIV)=W(ONCDIV)+1
 F I=0,1,2,3,"A" S X0=0 F  S X0=$O(^ONCO(165.5,"AS",I,X0)) Q:X0'>0  D
 .S ONCDIV=$P(^DIC(4,$$DIV^ONCFUNC(X0),0),U,1)
 .S:'$D(W(ONCDIV,I)) W(ONCDIV,I)=0
 .S W(ONCDIV,I)=W(ONCDIV,I)+1
 S ONCDIV="",I=0 F  S ONCDIV=$O(G(ONCDIV)) Q:ONCDIV=""  S ONCANA=$G(G(ONCDIV,1)),ONCNON=$G(G(ONCDIV,0)) D
 .S I=I+1
 .S:ONCANA="" ONCANA=0 S:ONCNON="" ONCNON=0
 .S ^TMP($J,"ONCPRT",I)="REGISTRY SUMMARY REPORT (Today) for: "_ONCDIV_"   Run Date: "_RPTDATE
 .S ONCAC=$G(W(ONCDIV,"A")),ONCIN=$G(W(ONCDIV,0)),ONCMI=$G(W(ONCDIV,1)),ONCPA=$G(W(ONCDIV,2))
 .S ONCCO=$G(W(ONCDIV,3)),ONCWA=$G(W(ONCDIV))
 .S:ONCWA="" ONCWA=0 S:ONCCO="" ONCCO=0 S:ONCPA="" ONCPA=0 S:ONCMI="" ONCMI=0 S:ONCIN="" ONCIN=0
 .S:ONCAC="" ONCAC=0
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)="    Analytical: "_$J(ONCANA,5)
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)="Non-Analytical: "_$J(ONCNON,5)
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)="Accession Only: "_$J(ONCAC,5)
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)="               ------",I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)="Total:          "_$J(ONCANA+ONCNON+ONCAC,5)
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)="WORKLOAD STATITICS"
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)="Suspense: "_ONCWA
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)="Incomplete: "_ONCIN_"   Minimal: "_ONCMI_"   Partial: "_ONCPA_"   Complete: "_ONCCO
 .S ^TMP($J,"ONCPRT",I)=^TMP($J,"ONCPRT",I)_"  Acc Only: "_ONCAC
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)="--------------"
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)="",I=I+1
 .S ^TMP($J,"ONCPRT",I)="Total: "_$J(ONCIN+ONCMI+ONCPA+ONCCO+ONCAC,5)
 .S I=I+1
 .S ^TMP($J,"ONCPRT",I)=""
 D MAIL
 Q
 ;
 W !!?30,"Analytical: ",$J(G(1),5)
 W !?26,"Non-Analytical: ",$J(G(0),5)
 W !?26,"Accession Only: ",$J(W("A"),5)
 W !?42,"-----"
 W !?35,"Total: ",$J(G(0)+G(1)+W("A"),5),!!
 W !,?30,"WORKLOAD STATISTICS",!!
 W "Suspense: ",W,!!,"Incomplete: ",W(0),?19,"Minimal: ",W(1),?34,"Partial: ",W(2),?49,"Complete: ",W(3),?65,"Acc Only: ",W("A"),!
 W "---------------",!,"Total: ",W(0)+W(1)+W(2)+W(3)+W("A")
 Q
 ;
MAIL ;email report to Oncology
 S XMDUZ=.5
 D REC^ONCSRV  ;get recipients
 S XMSUB="Oncology Registry Summary Report (Today)"
 S XMTEXT="^TMP($J,""ONCPRT"","
 D ^XMD
 K XMTEXT,XMY,XMSUB
 Q
 ;
DIVID ;DIVISION (160.1,6) identifier
 Q
 ;
EX ;EXIT
 ;K ^TMP($J)
 Q
 ;
CLEANUP ;Cleanup
 K %ZIS,ACO
 Q

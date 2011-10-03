PRCSREC3 ;WISC/KMB/DL-820 RECONCILIATION FOR ENTIRE SITE ;1/30/98 1445
V ;;5.1;IFCAP;;Oct 20, 2000
 ;Per VHA Directive 10-93-142, this routine should not be modified.
NEW1 ;
 N I,J,K,PRC,PRCSZ,Z,FLIP,SITE,%
 D:'$D(DT) DT^DICRW S PRC("FY")=$E(100+$E(DT,2,3)+$E(DT,4),2,3)
 S PRC("QTR")=$E(DT,4,5),PRC("QTR")=$P("2^2^2^3^3^3^4^4^4^1^1^1","^",PRC("QTR"))
 W !,?32,"THIS IS A LONG REPORT",!,?10,"Please check the paper in your printer before selecting a device",!
 W !,"Please wait while I loop through your control points."
 S I=0,J=0 F  S J=$O(^PRC(420,"B",J)) Q:'J  S I=I+1,SITE(I)=J
 F K=1:1:I D
 .S FLIP=0 F  S FLIP=$O(^PRC(420,SITE(K),1,FLIP)) Q:'FLIP  S FLIP1=$P($G(^PRC(420,SITE(K),1,FLIP,0)),"^") S:FLIP1="" FLIP1=FLIP S ^TMP($J,K,FLIP)=SITE(K)_"-"_FLIP1 W "."
PROCESS ;
 N STARTIME,Y D NOW^%DTC S (STARTIME,Y)=% D DD^%DT W !,"Beginning processing time: ",Y
 W !!,"Please select a device for printing this report",!!
 S IOP="Q",%ZIS="QM" D ^%ZIS Q:POP
 I $D(IO("Q")) S ZTSAVE("I")="",ZTSAVE("^TMP($J,")="",ZTSAVE("PRC*")="",ZTRTN="PROCESS1^PRCSREC3" D ^%ZTLOAD D ^%ZISC D FINAL Q
 D PROCESS1 D ^%ZISC D FINAL Q
PROCESS1 ;
 F K=1:1:I S FLIP=0 F  S FLIP=$O(^TMP($J,K,FLIP)) Q:'FLIP  D
 .S PRC("SITE")=$P(^TMP($J,K,FLIP),"-"),PRC("CP")=$P(^TMP($J,K,FLIP),"-",2)
 .S (PRCSZ,Z)=PRC("SITE")_"-"_PRC("FY")_"-"_PRC("QTR")_"-"_$P(PRC("CP")," ") D QUE^PRCSP1A
 QUIT
FINAL ;
 N ENDTIME D NOW^%DTC S (ENDTIME,Y)=% D DD^%DT  W !,"Ending processing time: ",Y,!,"Total time for processing: ",$$FMDIFF^XLFDT(ENDTIME,STARTIME,3),!
 W !,"End of processing" K ^TMP($J) Q
RESTART ;
 N NX,NXX,I,J,K,PRC,PRCSZ,Z,FLIP,SITE,%
 W !,"Use this option ONLY if you need to re-run your site running balance.",! S %=1 W !,"Do you wish to continue" D YN^DICN Q:%=0!(%=2)
 D:'$D(DT) DT^DICRW S PRC("FY")=$E(100+$E(DT,2,3)+$E(DT,4),2,3)
 S PRC("QTR")=$E(DT,4,5),PRC("QTR")=$P("2^2^2^3^3^3^4^4^4^1^1^1","^",PRC("QTR"))
 W !,"Okay. What station number should I start from? //" R NX:DTIME Q:'$T!(NX="^")!(+NX=0)  S J=NX-1
 W !,"What control point should I start from? //" R NXX:DTIME Q:'$T!(NXX="^")!(+NXX=0)  S FLIP=NXX-1
 W !,"Looping through control points.."
 D LOOP,PROCESS
 QUIT
LOOP S I=0 F  S J=$O(^PRC(420,"B",J)) Q:'J  S I=I+1,SITE(I)=J
 F K=1:1:I D
 .S:SITE(K)'=NX FLIP=0 F  S FLIP=$O(^PRC(420,SITE(K),1,FLIP)) Q:'FLIP  S FLIP1=$P($G(^PRC(420,SITE(K),1,FLIP,0)),"^") S:FLIP1="" FLIP1=FLIP S ^TMP($J,K,FLIP)=SITE(K)_"-"_FLIP1 W "."
 QUIT

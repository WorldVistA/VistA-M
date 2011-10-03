RTREP1 ;JLU/TROY ISC;RPW/BUF;RT Pull List Retrieval Rates; 2-19-87
 ;;2.0;Record Tracking;**32**;10/22/91 
RTLP ; Request Loop
 S (RTST(1,"c"),RTST(1,"x"),RTST(1,"r"),RTST(1,"n"))=0
 F RTRTN=0:0 S RTRTN=$O(^RTV(190.1,"AP",RTPLN,RTRTN)) Q:+RTRTN'>0  I $D(^RTV(190.1,RTRTN,0)) S RTX=$P(^(0),U,6) F RTX3=0,1,2 S RTST(RTX3,RTX)=RTST(RTX3,RTX)+1
 Q:'RTDSF
 S RTX=RTST(1,"c")+RTST(1,"r")+RTST(1,"n"),RTXP=$S(RTX'=0:RTST(1,"c")*100/RTX,1:"")
 I $Y>(IOSL-5) D HDR,INITS2
 I $D(RTNB) W !,?9,RTNB K RTNB
 W !,$P(^RTV(194.2,RTPLN,0),U),?48,RTX,?63,$J(RTXP,6,2),"%",?81,RTST(1,"c"),?93,RTST(1,"x"),?109,RTST(1,"n"),?124,RTST(1,"r")
 Q
APRT ; Alpha Prnt
 S (RTP1,RTNM)="" F RTNM1=0:0 S RTNM=$O(^TMP($J,RTNM)) D CHK:$P(RTNM,"[")'=RTP1 Q:RTNM=""  F RTPLN=0:0 S RTPLN=$O(^TMP($J,RTNM,RTPLN)) Q:'RTPLN  D RTLP
 Q
DPRT ; Institution Print
 S RTIST="" F RTIST1=0:0 S (RTNB,RTIST)=$O(^TMP($J,RTIST)) Q:RTIST=""  S RTNM="" F RTNM1=0:0 S RTNM=$O(^TMP($J,RTIST,RTNM)) D SS:RTNM="" Q:RTNM=""  F RTPLN=0:0 S RTPLN=$O(^TMP($J,RTIST,RTNM,RTPLN)) Q:'RTPLN  D RTLP
 Q
 ;
PRNT ;Summary Print
 D HDR
 S RTX=RTST(0,"c")+RTST(0,"r")+RTST(0,"n"),RTXP=$S(RTX'=0:RTST(0,"c")*100/RTX,1:"")
 W !!!,"Total Entire Pull List"
 W !!,?$X+5,"#Charged:",?$X+5,"#Cancelled:",?$X+5,"#Not Fillable:",?$X+5,"#Requested:",!,?$X+5,"---------",?$X+5,"-----------",?$X+5,"--------------",?$X+5,"-----------"
 W !,?$X+9,RTST(0,"c"),?$X+14,RTST(0,"x"),?$X+16,RTST(0,"n"),?$X+16,RTST(0,"r")
 W !!!!,"TOTAL REQUESTS=>  ",RTX,!!,"RETRIEVAL RATE=>  ",$J(RTXP,6,2)," %"
 Q
 ;Header
HDR S RTPAGE=RTPAGE+1 W @IOF
 W !,?24 W:IOM=132 ?$X+27 W "*****  PULL LIST STATS  *****",!,RTINE
 W !,"Pull List: ",$S(RTX1=3:RTLN,RTX1=2:"One Day",RTX1=1:"Date Range"),?44 W:IOM=132 ?$X+52
 W "Date Ranges: " W:RTX1'=3 $TR($$FMTE^XLFDT(RTDT1,"5DF")," ","0") W:$D(RTDT2)&(RTX1'=3) " to ",$TR($$FMTE^XLFDT(RTDT2,"5DF")," ","0")
 W !,"Run Date:  ",RTDTT,?44 W:IOM=132 ?$X+52 W "PAGE:  ",RTPAGE,!,RTINE
 Q
INITS2 W !!,?6,"Pull List",?42,"Total Requests",?60,"Retrieval Rate",?78,"#Charged",?90,"Cancelled",?103,"Not Fillable",?119,"#Requested"
 W !,?6,"---------",?42,"--------------",?60,"--------------",?78,"--------",?90,"----------",?103,"-------------",?119,"----------"
 Q
SS S RTX2=RTST(2,"c")+RTST(2,"n")+RTST(2,"r"),RTXP2=$S(RTX2'=0:RTST(2,"c")*100/RTX2,1:"")
 I $Y>(IOSL-5) D HDR,INITS2
 W !,?46,"-----",?63,"---------",?79,"-----",?91,"-----",?107,"-----",?122,"-----"
 W !,?48,RTX2,?63,$J(RTXP2,6,2),"%",?81,RTST(2,"c"),?93,RTST(2,"x"),?109,RTST(2,"n"),?124,RTST(2,"r"),!
RSS F RTI2="c","x","r","n" S RTST(2,RTI2)=0 K RTI2
 Q
 ;
CHK I RTP1="" S RTP1=$P(RTNM,"[") Q
 S RTP1=$P(RTNM,"[")
 D SS
 Q

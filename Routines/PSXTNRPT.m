PSXTNRPT ;BIR/WPB-Routine to Provide Turnaround Reports at Host & Remote Facilities ; 04/08/97   2:06 PM
 ;;2.0;CMOP;**45**;11 Apr 97
REMOTE S FLAG=1
R1 W !! S %DT="AEX",%DT("A")="Enter Begin Date for Report:  ",%DT(0)="-NOW",%DT("B")="TODAY" D ^%DT G:Y<0!($D(DTOUT)) EXIT S BB=Y,BEG=$$FMADD^XLFDT(BB,-1,0,0,0)_".9999"
 W !! S %DT("A")="Enter End Date for Report:  " D ^%DT K %DT G:Y<0!($D(DTOUT)) EXIT S EE=Y,END=EE_".9999"
 K %DT("A"),%DT("B"),%DT(0),Y,X,DTOUT
 I BB>EE W !,"Beginning date must be before ending date." G REMOTE
 Q:$G(FLAG)=0
DEVICE S %ZIS="Q",%ZIS("B")="" D ^%ZIS S PSXLION=ION G:POP EXIT I $G(IOST)["C-" W !,"You must select a printer." G DEVICE
 I $D(IO("Q")) D QUE,EXIT Q
 D:$G(FLAG)=1 REMOTE1
 D:$G(FLAG)=0 HOST1
 G EXIT
QUE S ZTRTN=$S($G(FLAG)=1:"REMOTE1^PSXTNRPT",$G(FLAG)=0:"HOST1^PSXTNRPT",1:""),ZTIO=PSXLION,ZTSAVE("BB")="",ZTSAVE("BEG")="",ZTSAVE("EE")="",ZTSAVE("END")="",ZTDESC="CMOP Turn Around Report"
 S:$G(FLAG)=0 ZTSAVE("SNAME")="",ZTSAVE("SITE")="" D ^%ZTLOAD
 I $D(ZTSK)[0 W !!,"Job Canceled"
 E  W !!,"Job Queued"
 D HOME^%ZIS
 Q
 ;Called by Taskman to begin Turnaround report for Remote
REMOTE1 U IO S (LTT,STT,CNT,CNTA,AVTTM,TURN,TOTTM)=0
 F  S BEG=$O(^PSRX("AR",BEG)) Q:(BEG'>0)!(BEG>END)  S RX=0 F  S RX=$O(^PSRX("AR",BEG,RX)) Q:RX'>0  S FILL="" F  S FILL=$O(^PSRX("AR",BEG,RX,FILL)) Q:FILL=""  D
 .Q:'$O(^PSRX(RX,4,0))
 .S RXTTM=0
 .S XX=0 F  S XX=$O(^PSRX(RX,4,XX)) Q:XX'>0  S:$P($G(^PSRX(RX,4,XX,0)),"^",3)=FILL BAT=$P($G(^PSRX(RX,4,XX,0)),"^",1),STAT=$P(^PSRX(RX,4,XX,0),"^",4)
 .Q:STAT'=1
 .I $G(FILL)>0 S:'$D(^PSRX(RX,1,FILL,0)) CNTA=CNTA+1
 .S TTM=$P($G(^PSX(550.2,BAT,0)),"^",6)
 .S TURN=$$FMDIFF^XLFDT(BEG,TTM,2)
 .S:LTT<TURN LRX=RX S:LTT<TURN LTT=TURN S:STT=0 STT=TURN S:STT>TURN!(STT=TURN) SRX=RX S:STT>TURN STT=TURN S TOTTM=TOTTM+TURN
 .S CNT=CNT+1
 .S:CNT=1 LRX=RX
 G:CNT'>0 RPT1
 S AVTTM=TOTTM/CNT
 S LTT=$P($$STHMS^PSXTNRPT(LTT),"."),STT=$P($$STHMS^PSXTNRPT(STT),"."),AVTTM=$$STHMS^PSXTNRPT($P(AVTTM,"."))
 I IOST["C-" W @IOF
RPT1 W !!!,"TURNAROUND TIME FOR PERIOD"
 W !,$$FMTE^XLFDT(BB,"1P")," - ",$$FMTE^XLFDT(EE,"1P")
 I $G(CNT)=0 W !,"No Rx's completed during this period." G EXIT
 W !!,"Total Rx's Completed   :  ",CNT
 W !,"Maximum turnaround time:  ",LTT,"   Rx:  ",$P(^PSRX(LRX,0),"^",1)
 W !,"Minimum turnaround time:  ",STT,"   Rx:  ",$P(^PSRX(SRX,0),"^",1)
 W !,"Average turnaround time:  ",AVTTM
 I $G(CNTA)>0 W !!,"Number of Rx's missing refill node:  ",CNTA
EXIT W @IOF
 D ^%ZISC
 K AVT,BB,BEG,CMDT,CNT,EE,END,PTR514,SITE,SNAME,ST,TDT,TOTTM,XX,YY,LT,PSXLION,XS,CNTA,DIC,DTOUT,DUOUT,FLAG,AVRTM,AVTTM,BAT,FILL,LRT,LTT,RTURN,RX,RXRTM,TTM,RXTTM,SRT,STAT,STT,TRTM,TURN,X,Y,LRX,SRX,%DT,%ZIS,FLAG
 S:$D(ZTQUEUED) ZTREQ="@"
 Q
HOST S FLAG=0
 D R1 Q:$G(FLAG)=""
 W !! S DIC=552,DIC(0)="AEQMZ",DIC("A")="Enter site:  " D ^DIC K DIC G:$D(DTOUT)!($D(DUOUT))!(Y<0) EXIT S XS=$P(Y,"^",2),SNAME=Y(0,0),FACDA=+Y K X,Y
 S SITE=$$GET1^DIQ(552,FACDA,5) K FACDA
 I SITE="" S SITE=$P(^DIC(4,XS,99),"^",1)
 D DEVICE
 Q
 ;Called by Taskman to begin Turnaround report for HOST
HOST1 U IO S (LT,ST,AVT,CNT,CNTA,TOTTM)=0
 F  S BEG=$O(^PSX(552.4,"AD",BEG)) Q:(BEG'>0)!(BEG>EE)  S XX=0 F  S XX=$O(^PSX(552.4,"AD",BEG,XX)) Q:XX'>0  S YY=0 F  S YY=$O(^PSX(552.4,"AD",BEG,XX,YY)) Q:YY'>0  D
 .S PTR514=$P(^PSX(552.4,XX,0),"^",1)
 .Q:$P($P(^PSX(552.1,PTR514,0),"^",1),"-",1)'=SITE
 .Q:$P($G(^PSX(552.4,XX,1,YY,0)),"^",2)=2
 .Q:$P($G(^PSX(552.4,XX,1,YY,2)),"^",2)'=""
 .S:$P(^PSX(552.4,XX,1,YY,0),"^",10)=2 CNTA=CNTA+1
 .S (TDT,CMDT)=0,CNT=CNT+1
 .S CMDT=$P(^PSX(552.4,XX,1,YY,0),"^",9),TDT=$P(^PSX(552.1,PTR514,0),"^",3)
 .S TT=$$FMDIFF^XLFDT(CMDT,TDT,2) S:TT>LT LRX=$P(^PSX(552.4,XX,1,YY,0),"^",1) S:TT>LT LT=TT S:ST=0 ST=TT S:(TT<ST)!(ST=TT) SRX=$P(^PSX(552.4,XX,1,YY,0),"^",1),ST=TT
 .S TOTTM=TOTTM+TT
 .S:CNT=1 LRX=$P(^PSX(552.4,XX,1,YY,0),"^",1)
 .K TT
 G:CNT'>0 RPT
 S AVT=TOTTM/CNT
RPT I IOST["C-" W @IOF
 W !!!,"TURNAROUND TIME REPORT FOR "_SNAME
 W !,"FOR "_$$FMTE^XLFDT(BB,"1P")," - ",$$FMTE^XLFDT(EE,"1P")
 I $G(CNT)=0 W !!,"No Rx's completed during this time period." G EXIT
 W !!,"Total Rx's Completed   :  ",CNT
 I $G(CNTA)>0 W !,"Number of Rx's not processed at remote:  ",CNTA
 W !,"Maximum turnaround time:  ",$P($$STHMS^PSXTNRPT(LT),"."),"  Rx:  ",LRX
 W !,"Minimum turnaround time:  ",$P($$STHMS^PSXTNRPT(ST),"."),"  Rx:  ",SRX
 W !,"Average turnaround time:  ",$P($$STHMS^PSXTNRPT(AVT),"."),!
 G EXIT
STHMS(X)          ;
 Q:(X<1)!(X="") 0
 N XX,YY,X1,X2,X3,Y1,Y2,Y3,T1,U1,E1,R1,W1
 S XX=X/3600,X1=$P(XX,".",1),X2=X1*3600,X3=X-X2,YY=X3/60,Y1=$P(YY,".",1),Y2=Y1*60,Y3=X3-Y2 S:X1>24 T1=(X1/24),U1=$P(T1,".",1),E1=(X1-(U1*24)),X1=E1
 S R1=$S($G(U1)>0:U1_" days ",1:"")_$S($G(X1)>0:X1_" hrs ",1:"")_$S($G(Y1)>0:Y1_" mins ",1:"")_$S($G(Y3)>0:Y3_" secs",1:"")
 K XX,YY,X1,X2,X3,Y1,Y2,Y3,T1,U1,E1,W1
 Q R1

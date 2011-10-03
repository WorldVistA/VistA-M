RTP6 ;ISC-ALBANY/PKE-kill logic, xref on file 44,.01 ; 9/17/87  20:21 ;
 ;;v 2.0;Record Tracking;;**13**;10/22/91 
 ;
EN K ^TMP("RT F44",$J) S (RTPL,RTPLSAV)=X,RTPLNEW=$P(^SC(DA,0),U,1)
 ;
 D FIND,SET,EX Q
 ;
EX K RTN,RTM,RTPL,RTPLSAV,RTPLNEW,RTPLDAT Q
 ;
FIND F RTN=1:1 S RTPL=$O(^RTV(194.2,"B",RTPL)) Q:$P(RTPL," [",1)]RTPLSAV  Q:RTPL=""  I $P(RTPL," [",1)=RTPLSAV F RTM=0:0 S RTM=$O(^RTV(194.2,"B",RTPL,RTM)) Q:'RTM  D W1 D UTL,KILL
 Q
SET Q:'$D(^TMP("RT F44",$J))
 F RTM=0:0 S RTM=$O(^TMP("RT F44",$J,RTM)) Q:'RTM  S RTPLDAT=^(RTM),RTPLDAT=RTPLNEW_$P(RTPLDAT,RTPLSAV,2) D TST S $P(^RTV(194.2,RTM,0),U)=RTPLDAT,^RTV(194.2,"B",RTPLDAT,RTM)=""
 ;
 I RTN>1 W !!,"Number of Pull Lists renamed = ",RTN-1,!!
 Q
UTL S ^TMP("RT F44",$J,RTM)=RTPL Q
 ;
KILL K ^RTV(194.2,"B",RTPL) Q
 ;
TST ;S ^TMP("RT F44",$J,"NEW",RTM)=RTPLDAT Q
 ;
W1 I RTN=1 W !,"Renameing Pull Lists in file 194.2",!,"." Q
 E  W "." Q
 Q
PULL K RTPULL,RTPULL0,RTDT
 W !!,"Select"_$S('$D(RTIRE):" Pull List: ALL CLINIC LISTS //",1:" a 'RR' Record Retirement Pull List: ") R X:DTIME G PULLQ:'$T!(X["^") S:X=""&('$D(RTIRE)) X="ALL" D UALL I $T S RTPULL="ALL" G RTDT
 G PULLQ:X=""
 S DIC="^RTV(194.2,",DIC(0)="ZEMQI"
 S DIC("S")="I $P(^(0),U,12)="_RTDV_",$P(^(0),U,15)="_+RTAPL_",$P(^(0),U,10)"_$S('$D(RTIRE):"'=3",1:"=3")
 D ^DIC K DIC G PULL:Y<0 S RTPULL=+Y,RTPULL0=Y(0),RTDT=$P($P(Y(0),"^",2),".")
 I $P(Y(0),"^",6)="x" W !!,*7,"This pull list was cancelled by ",$S($D(^VA(200,+$P(Y(0),"^",8),0)):$P(^(0),"^"),1:"UNKNOWN")," on " S Y=$P(Y(0),"^",7) D DT^DIQ W "." G PULL
RTDT W ! I '$D(RTDT) S %DT="EAFX",%DT("A")="Select Date: " D ^%DT K %DT I Y>0 S RTDT=Y D SHOW^RTP41 I 'RTC K RTDT G RTDT
PULLQ I '$D(RTPULL)!('$D(RTDT)) K RTPULL,RTDT,RTPULL0
 K RTC Q
UALL X ^%ZOSF("UPPERCASE")
 S X=Y I X="ALL"!($E(X,1,4)="ALL ")!(X="ALL CLINIC LISTS") Q
 Q

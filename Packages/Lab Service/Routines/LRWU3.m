LRWU3 ;SLC/RWF - COLLECT STARTING AND ENDING DATES FOR REPORTS ; 7/23/87  14:17 ;
 ;;5.2;LAB SERVICE;**153**;Sep 27, 1994
 S U="^",LREND=0,LRSDT=0 S:'$D(DTIME) DTIME=999
A1 W !,"Date to START with: TODAY//" R X:DTIME S:'$T LREND=1 I 'LREND,X["?" W !,"Enter the most recent date you want." S X="?",%DT="E" D ^%DT G A1
 S:X[U LREND=1 G A3:LREND S:X="" X="T" S %DT="E" D ^%DT G A1:Y<1 S LRSDT=Y
 I '$L($G(LREDT)) D
 . N X1,X2
 . S X1=LRSDT,X2=-30 D C^%DTC S LREDT=$$DTF^LRAFUNC1(X)
A2 W !,"Date to END  with: ",$S($D(LREDT):LREDT,1:"LAST"),"//" R X:DTIME S:'$T LREND=1 I 'LREND,X["?" W !,"Enter the oldest date you want.",! S X="?",%DT="E" D ^%DT G A2
 S:X[U LREND=1 G A3:LREND I X="",'$D(LREDT) S LREDT=1000000 W "  (LAST)" G A3
 S:X="" X=LREDT S %DT="E" D ^%DT G A2:Y<1 S LREDT=Y
 I LRSDT<LREDT S X=LRSDT,LRSDT=Y,LREDT=X
A3 S LRSDT=LRSDT+.5 K %DT Q
LRAN ;get first and last LRAN
 S (LRFAN,LRLAN)=0
 S LREND=0
W1 W !,"First Accession number: 1//" R X:DTIME S:'$T LREND=1 S:X[U LREND=1 S:X="" X=1 G W3:LREND S:+X'=X X="?" I X["?" W !,"Enter the first Accession number to use" G W1
 S LRFAN=+X
W2 W !,"Last Accession number: LAST//" R X:DTIME S:'$T LREND=1 S:X[U LREND=1 G W3:LREND S:X="" X=9999999 S:+X'=X X="?" I X["?" W !,"Enter the Last Accession to use." G W2
 S LRLAN=+X I LRFAN>LRLAN W !,"The last Accession number MUST be greater or equal to",!,"  the first Accession number" G LRAN
W3 Q
STAR ;set LRSTAR if list by date instead of accession number
 S LREND=0 F I=0:0 K LRSTAR W !,"Do you wish to list by date (rather than by accession number)" S %=1 D YN^DICN Q:%  W !,"Answer 'Y'es or 'N'o."
 S:%<0 LREND=1 Q:%'=1
 S %DT="AEQ",%DT("A")="Enter earliest date received at lab to list: " D ^%DT G S3:Y<0 S LRSTAR=Y
 S %DT="AEQ",%DT("A")="Enter latest date received at lab to list: " D ^%DT S LAST=Y
 S LRAD=$E(LRSTAR,1,3)-1_"0000" S:LAST'=-1 LRWDTL=$E(LAST,1,3)_"0000",LAST=LAST\1+.99 S:LAST=-1 LRWDTL=$E(DT,1,3)_"0000"
S3 K %DT Q
ADATE ;Get an accession date
 S LREND=0 W !,"  Accession Date: TODAY//" R X:DTIME S:'$T X="^",DTOUT=1 S:X="" X="T" I X[U S Y=-1,LREND=1 Q
 S %DT="EP" D ^%DT G ADHELP:X["?",ADATE:Y=-1
 I $G(LRAA),$D(^LRO(68,+LRAA,0)) S %=$P(^LRO(68,+LRAA,0),U,3),Y=$S("D"[%:Y,%="Y":$E(Y,1,3)_"0000","M"[%:$E(Y,1,5)_"00","Q"[%:$E(Y,1,3)_"0000"+(($E(Y,4,5)-1)\3*300+100),1:Y)
 S LRAD=Y K %DT Q
ADHELP W !,"Enter the date of the accession to be used.  If the accession is done",!,"  on a yearly basis, enter the year, such as ",$E(DT,2,3),!
 G ADATE
 Q

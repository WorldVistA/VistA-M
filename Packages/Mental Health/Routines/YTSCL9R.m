YTSCL9R ;ALB/ASF-SCL90 R SCORING ; 8/17/10 10:51am
 ;;5.01;MENTAL HEALTH;**10,96**;Dec 30, 1994;Build 46
 ;No external references
MAIN ;
 D RD
 D VALIDITY Q:YSVFLAG
 D SS
 D GSI,PST,PSDI
 D TSCORE
 D ^YTSCL9R1 ;graphit
 D BOTTOM^YTSCL9R1 ;graph legend
 D REPT
 D:IOST?1"C-".E SCR^YTREPT Q:YSTOUT!YSUOUT
 D NOTE^YTSCL9R1 ;symptoms of note
 D END
 Q
RD S X=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1)
 Q
SS ;symptom scales
 S (R,S,S(1),S(2),S(3),YSTOTAL)=""
 F YSI=1:1:10 D SS1
 Q
SS1 ;
 S YSK=^YTT(601,YSTEST,"S",YSI,"K",1,0)
 S YSDIV=0,YSMIS=0
 F J=1:2 S YSITEM=$P(YSK,U,J) Q:YSITEM=""  S:$E(X,YSITEM)="X" YSMIS=YSMIS+1 S:$E(X,YSITEM)'="X" YSDIV=YSDIV+1,$P(R,U,YSI)=$P(R,U,YSI)+$E(X,YSITEM),YSTOTAL=YSTOTAL+$E(X,YSITEM)
 ;divide by number of non omitted in scale
 S:YSDIV>0 $P(R,U,YSI)=$J($P(R,U,YSI)/YSDIV,0,2)
 ;set tscore to 0 if  more than 40% ommitted
 I YSMIS/(YSMIS+YSDIV)>.4 S $P(S(1),U,YSI)=0,$P(S(2),U,YSI)=0,$P(S(3),U,YSI)=0
 Q
GSI ;global severity index
 I YSTOTAL=0 S $P(R,U,11)=$J(0,0,2) Q  ;-->out ASF 8/17/2010
 S $P(R,U,11)=$J(YSTOTAL/(90-($L(X,"X")-1)),0,2)
 Q
PST ;positive symptom total
 S $P(R,U,13)=($L(X,4)-1)+($L(X,3)-1)+($L(X,2)-1)+($L(X,1)-1)
 Q
PSDI ;positive symptom distress index
 I YSTOTAL=0 S $P(R,U,12)=$J(0,0,2) Q  ;-->out ASF 8/17/2010
 S $P(R,U,12)=$J(YSTOTAL/$P(R,U,13),0,2)
 Q
VALIDITY ;
 S YSVFLAG=0
 I $L(X,"X")>19  W !!,"Administration invalid: More than 18 items were omitted",!! S YSVFLAG=1 Q
 I YSAGE<18 W !!,"Norms for this age group not available",!! S YSVFLAG=1 Q
 I $L(X,4)=91!($L(X,3)=91)!($L(X,2)=91)!($L(X,1)=91)!($L(X,0)=91) W !!,"Administration invalid: all questions were answered the same",!! S YSVFLAG=1 Q
 Q
TSCORE ; 1=outpatient, 2=nonpatients, 3= inpatients
 F YSNORM=1,2,3 D TS1,TPST,EXTREME
 Q
TS1 F YSI=1:1:9,11,12 D LKUP
 Q
LKUP ;
 S YSRAW=+$P(R,U,YSI)
 S N=0 F  S N=$O(^YTT(601,YSTEST,YSSEX,YSNORM,1,N)) Q:N'>0  S YSROW=^(N,0),YSVALUE=+YSROW I YSVALUE=YSRAW!(YSVALUE>YSRAW) D LKUP1 Q
 Q
LKUP1 ;
 Q:$P(S(YSNORM),U,YSI)=0  ;already taged invalid
 S YSLKP=$S(YSI>9:YSI-1,1:YSI)
 S YSTNOW=$P(YSROW,U,YSLKP+1)
 Q:'+YSTNOW  ;its an extreme
 I +YSVALUE=+$P(R,U,YSI) S $P(S(YSNORM),U,YSI)=YSTNOW Q
 IF YSRAW<YSVALUE D:N>1 TRANS
 Q
TRANS ;
 Q:N=1
 S YSROWP=^YTT(601,YSTEST,YSSEX,YSNORM,1,N-1,0)
 S YSVOLD=+YSROWP,YSTOLD=$P(YSROWP,U,YSLKP+1)
 Q:'+YSTOLD  ;its an extreme
 S YST=((YSTNOW-YSTOLD)/(YSVALUE-YSVOLD))*(YSRAW-YSVOLD)+YSTOLD
 S $P(S(YSNORM),U,YSI)=$J(YST,0,0)
 Q
TPST ; tscores for pst
 Q:$P(R,U,13)=0  ;-->out ASF 8/17/10
 S YSROW=^YTT(601,YSTEST,YSSEX,4,1,$P(R,U,13),0)
 S $P(S(YSNORM),U,13)=$P(YSROW,U,YSNORM+1)
 Q
EXTREME ;
 F YSI=1:1:9,11,12 D EX1
 Q
EX1 ;
 Q:$P(S(YSNORM),U,YSI)'=""
 S YSRAW=$P(R,U,YSI),X=$S(YSRAW>1.2:2,1:1)
 S $P(S(YSNORM),U,YSI)=$P(^YTT(601,YSTEST,YSSEX,YSNORM+4,1,X,0),U,YSI)
 Q
REPT ;
 S X=$P(^YTT(601,YSTEST,"P"),U),A=$P(^("P"),U,2),B=$P(^("P"),U,3),L1=58-A\2,L2=L1+A+4 S:A<9 A=9
 D DTA^YTREPT W !!?(72-$L(X)\2),X,!!!?3,"S C A L E",?37,"RAW   Outpatients  Nonpatients  Inpatients"
 F YSI=1:1:9,11,12,13 D REPT1
 Q
REPT1 ;
 S YSRS=$P(R,U,YSI),S1=$P(S(1),U,YSI),S2=$P(S(2),U,YSI),S3=$P(S(3),U,YSI)
 D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 W !?3,$P($P(^YTT(601,YSTEST,"S",YSI,0),U,2),";",2),?37,$S(YSI=13:$J(YSRS,4,0),1:$J(YSRS,4,2)),$J(S1,8,0),$J(S2,13,0),$J(S3,13,0)
 W:YSI=9 !!
 Q
END K L1,L2,N,R,S,X,S1,S2,S3,YSDIV,YSI,YSITEM,YSK,YSLKP,YSLV,YSMIS,YSNORM,YSNS,YSRAW,YSROW,YSROWP,YSRS,YST,YSTNOW,YSTOLD,YSTOTAL,YSVALUE,YSVFLAG,YSVOLD
 Q
MULT ;multiple scoring returns Outpt norms
 D ENPT^YSUTL Q:YSAGE<18
 D RD
 D SS
 D GSI,PST,PSDI
 D TSCORE
 S S=S(1) ;change to 2 or 3 for non and inPt
 Q

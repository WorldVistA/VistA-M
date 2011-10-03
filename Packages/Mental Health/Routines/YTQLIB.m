YTQLIB ;ASF/ALB MHQ LIBRARY FUNCTIONS ; 4/4/07 2:00pm
 ;;5.01;MENTAL HEALTH;**85**;Dec 30, 1994;Build 48
 Q
TSLIST(YSDATA) ;list tests and surveys
 N YSTESTN,YSTEST,N
 K YSDATA
 S N=1,YSDATA(N)="[DATA]"
 S YSTEST="" F  S YSTEST=$O(^YTT(601.71,"B",YSTEST)) Q:YSTEST=""  D
 . S YSTESTN=$O(^YTT(601.71,"B",YSTEST,0))
 . S N=N+1
 . S YSDATA(N)=YSTESTN_U_YSTEST_U_$$GET1^DIQ(601.71,YSTESTN_",",18)
 Q
 ;
NEW(YSFILEN) ;Adding New Entries - return an internal number - EXTRINSIC FUNCTION
 ;if $D YSPROG then National and pointers less than 100,000 else pointers greater than 100,000
 N MHQ2X,YS
 K YSPROG
 S:$D(^XUSEC("YSPROG",DUZ)) YSPROG=1
 S YS=$P($G(^YTT(YSFILEN,0)),U,3) S:YS<1 YS=1
 I $D(YSPROG) S YS=$S(YS<100000:YS,1:1)
 I '$D(YSPROG) S YS=$S(YS>100000:YS,1:100000)
 F MHQ2X=YS:1 I '$D(^YTT(YSFILEN,MHQ2X)) L ^YTT(YSFILEN,MHQ2X):0 Q:$T
 Q MHQ2X
 ;
ADMCK(YSDATA,YS) ;check administration
 N G,K,YSA,YSAD,YSCANS,YSCOMP,YSCTREF,YSDFN,YSDG,YSDS,YSIEN,YSINS,YSK,YSQN
 S N=1
 S YSDATA(1)="[ERROR]"
 S YSAD=$G(YS("AD"))
 I YSAD'?1N.N S YSDATA(2)="bad admin #" D SAY Q  ;-->out
 I '$D(^YTT(601.84,YSAD,0)) S YSDATA(2)="bad admin ref" D SAY Q  ;-->out
 S G=^YTT(601.84,YSAD,0)
 S YSDFN=$P(G,U,2) I '$D(^DPT(YSDFN,0)) S YSDATA(2)="bad pt ref" D SAY Q  ;-->out
 S YSINS=$P(G,U,3) I '$D(^YTT(601.71,YSINS)) S YSDATA(2)="test not found" D SAY Q  ;-->out
 S YSDG=$P(G,U,4) I YSDG'?7N.NP  S YSDATA(2)="date given bad" D SAY Q  ;-->out
 S YSDS=$P(G,U,5) I YSDG'?7N.NP  S YSDATA(2)="date SAVED bad" D SAY Q  ;-->out
 S YSCOMP=$P(G,U,9)
 S YSDATA(1)="[DATA]"
 I YSCOMP'="Y" S YSDATA(2)="incomplete" D SAY Q  ;-->out
 D SAY
 ;loop thru answers to this admin
 S YSQN=0,YSDATA(1)="[ERROR]"
 F  S YSQN=$O(^YTT(601.85,"AC",YSAD,YSQN)) Q:YSQN'>0  S YSIEN=0 F  S YSIEN=$O(^YTT(601.85,"AC",YSAD,YSQN,YSIEN)) Q:YSIEN'>0  D
 . S YSA=$G(^YTT(601.85,YSIEN,0)),YSCANS=$P(YSA,U,4)
 . I '$D(^YTT(601.76,"AF",YSINS,YSQN)) S YSDATA(2)="question not in battery" D SAYQ Q  ;-->out
 . S YSCTREF=$P(^YTT(601.72,YSQN,2),U,3)
 . S K=0,YSK=0
 . I YSCANS?1N.N F  S K=$O(^YTT(601.751,"ACT",YSCANS,K)) Q:(YSK)!(K'>0)  I $P(^YTT(601.751,K,0),U,1)=YSCTREF S YSK=1
 . I YSK=0 S YSDATA(2)="bad choice" D SAYQ Q
 . S YSDATA(1)="[DATA]" K YSDATA(2) D SAYQ
 Q
SAY W !,N,"  ",YSAD,"  ",YSDATA(1),"  ",$G(YSDATA(2)) Q
SAYQ W !?10,$G(YSDATA(1)),"  ",YSAD,"  ",YSQN,"  ",YSA,"  ctype: ",YSCTREF,"  Cans: ",YSCANS Q

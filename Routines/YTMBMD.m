YTMBMD ;ALB/ASF-MBMD ; 2/6/04 9:09am
 ;;5.01;MENTAL HEALTH;**76,83**;Dec 30, 1994
MAIN ;
 N A,B,G,I,L1,L2,N,X,YSANS,YSDAS,YSDAS1,YSIN,YSSID,YSTOUT,YSUOUT,YSVFLAG
 D PTVAR^YSLRP
 D RD
 D VALIDITY ;Q:YSVFLAG
 D RAW
 D PS1
 D RPA
 D HPA
 D HPA1
 D:YSTY["*" REPT
 Q
RD S X=^YTD(601.2,YSDFN,1,YSTEST,1,YSED,1)
 Q
VALIDITY ;check if ok to score
 S YSVFLAG=0
 I $L(X,"X")>11 S YSVFLAG=1 Q
 I ($E(X,106)="T")&($E(X,124)="T") S YSVFLAG=1 Q
 I (YSAGE<18)!(YSAGE>85) S YSVFLAG=1 Q
 Q
RAW ; raw scores
 S R="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 S N=0 F  S N=$O(^YTT(601,YSTEST,"S",N)) Q:N'>0  D
 . S G=^YTT(601,YSTEST,"S",N,"K",1,0),I=1
 . F  S YSIN=$P(G,U,I),YSANS=$E($P(G,U,I+1),1),YSWT=$P($P(G,U,I+1),";",2),I=I+2 Q:YSIN=""  S:$E(X,YSIN)=YSANS $P(R,U,N)=$P(R,U,N)+YSWT
 Q
PS1 ; untransformed prevelence scores
 S S="0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0^0"
 F I=11:1:39 S $P(S,U,I)=$P(^YTT(601,YSTEST,"S",I,YSSEX),U,$P(R,U,I)+1)
 S X=$P(R,U,2) S $P(S,U,2)=$S(X<9:"L",X=9:"M",X=10:"H",1:0) ;scale X ASF 1/30/04
 S X=$P(R,U,3) S $P(S,U,3)=$S(X<10:"L",X<13:"M",X>12:"H",1:0) ;scale Y ASF 1/30/04
 S X=$P(R,U,4) S $P(S,U,4)=$S(X<5:"L",X=5:"M",X>5:"H",1:0) ;scale Z ASF 1/30/04
 F I=5:1:10 S X=$P(R,U,I) S $P(S,U,I)=$S(X=0:"L",X=1:"M",X>1:"H",1:0) ;indicators ASF 1/30/04
 Q
RPA ;Response Pattern Adjustment
 S YSDAS=0
 I ($P(S,U,2)="H")&($P(S,U,3)="H")&($P(S,U,4)'="H") S YSDAS=10
 I ($P(S,U,2)'="H")&($P(S,U,3)="H")&($P(S,U,4)'="H") S YSDAS=10
 I ($P(S,U,2)="H")&($P(S,U,3)'="H")&($P(S,U,4)'="H") S YSDAS=-5
 I ($P(S,U,2)="H")&($P(S,U,3)'="H")&($P(S,U,4)="H") S YSDAS=-10
 I ($P(S,U,2)'="H")&($P(S,U,3)'="H")&($P(S,U,4)="H") S YSDAS=-10
 F I=11,12,13,14,15,27,28,29,30,31,32,33,34,35,36,37,38,39 S $P(S,U,I)=$P(S,U,I)+YSDAS
 Q
HPA ;High Point Adjustment COPING
 S N=0 F I=16:1:26 S:$P(S,U,I)>59 N=N+1
 S YSDAS=$S(N>9:-10,N>7:-5,N>4:0,N>2:5,N>0:10,1:15)
 F I=16:1:26 S $P(S,U,I)=$P(S,U,I)+YSDAS
 Q
HPA1 ;high point AA-EE, a-m
 S N=0
 F I=11,12,13,14,15,27,28,29,30,31,32,33,34,35,36,37,38,39 S:$P(S,U,I)>59 N=N+1
 S YSDAS=$S(N>16:-15,N>14:-10,N>12:-5,N>7:0,N>5:5,N>2:10,1:15)
 S YSDAS1=$S(N>12:0,N>7:5,N>5:10,N>2:15,1:20)
 F I=11,12,13,14,15,27,28,29,30,31,32,33,34,35,36,37 S $P(S,U,I)=$P(S,U,I)+YSDAS
 F I=38,39 S $P(S,U,I)=$P(S,U,I)+YSDAS1
 Q
REPT ;reports
 S (YSTOUT,YSUOUT)=""
 S X=$P(^YTT(601,YSTEST,"P"),U),A=$P(^("P"),U,2),B=$P(^("P"),U,3),L1=58-A\2,L2=L1+A+4 S:A<9 A=9
 D DTA^YTREPT
 W !,?(72-$L(X)\2),X,!
 W !?50,$S(YSVFLAG:"*** Invalid Profile ***",1:"Valid Profile")
 F I=2:1:10 D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 . W:I=2 !,"Response Patterns" ;ASF 1/30/04 ABOVE LINE ALSO
 . W:I=5 !,"Negative Health Habits"
 . W !,?4,$P(^YTT(601,YSTEST,"S",I,0),U,2),?25 D LIKELY
 D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 F I=11:1:39 D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 . W:I=11 !,"Psychiatric Indications"
 . W:I=16 !,"Coping Styles"
 . W:I=27 !,"Stress Moderators"
 . W:I=33 !,"Treatment Prognostics"
 . W:I=38 !,"Management Guides"
 . S YSSID=$P(^YTT(601,YSTEST,"S",I,0),U,2)
 . W !,$P(YSSID," ")
 . W ?5,$J($P(R,U,I),2),"  ",$S($P(S,U,I)'<0:$J($P(S,U,I),3),1:"  0")," "
 . D CHART
 . W ?52,$P(YSSID," ",2,99)
 D NOTEWOR
 Q
LIKELY ;
 N X
 S X=$P(S,U,I)
 W $S(X="L":"unlikely problem",X="M":"possible problem",X="H":"likely problem",1:"????")
 Q
CHART ;
 N X
 S X=$P(S,U,I)
 W $E("***************************************************************",1,$J(X/3,0,0))
 Q
NOTEWOR ;note worthy responses
 D RD
 W !!?10,"*** Noteworthy Responses ***"
 F I=1,14,28,66,6,117,131,157,3,20,41,62,5,10,103,116,143,49 D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 .W:I=1 !!?4,"Panic Susceptibility"
 .W:I=6 !!?4,"Disorientation"
 .W:I=3 !!?4,"Medical Anxiety"
 .W:I=5 !!?4,"Adherence Problems"
 .W:I=49 !!?4,"Suicidal Tendencies"
 . W:$E(X,I)="T" !,$J(I,3,0),". ",^YTT(601,YSTEST,"Q",I,"T",1,0)
 I (($E(X,49)="T")&($E(X,58)="T"))!(($E(X,161)="T")&($E(X,58)="T")) W !," 58. ",^YTT(601,YSTEST,"Q",58,"T",1,0)
 I (($E(X,49)="T")&($E(X,161)="T"))!(($E(X,161)="T")&($E(X,58)="T")) W !,"161. ",^YTT(601,YSTEST,"Q",161,"T",1,0)

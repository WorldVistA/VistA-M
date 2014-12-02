YTMBMD1 ;ALB/ASF-MBMD ; 2/14/12 12:50pm
 ;;5.01;MENTAL HEALTH;**105**;Dec 30, 1994;Build 76
 ;No external references
PSB ; bariatric untransformed prevalence scores
 F I=40:1:68 S $P(S,U,I)=$P(^YTT(601,YSTEST,"S",I,YSSEX),U,$P(R,U,I)+1)
 Q
RPAB ;bariatric Response Pattern Adjustment
 S YSDAS=0
 I ($P(S,U,2)="H")&($P(S,U,3)="H")&($P(S,U,4)'="H") S YSDAS=10
 I ($P(S,U,2)'="H")&($P(S,U,3)="H")&($P(S,U,4)'="H") S YSDAS=10
 I ($P(S,U,2)="H")&($P(S,U,3)'="H")&($P(S,U,4)'="H") S YSDAS=-5
 I ($P(S,U,2)="H")&($P(S,U,3)'="H")&($P(S,U,4)="H") S YSDAS=-10
 I ($P(S,U,2)'="H")&($P(S,U,3)'="H")&($P(S,U,4)="H") S YSDAS=-10
 F I=40,41,42,43,44,56,57,58,59,60,61,62,63,64,65,66,67,68 S $P(S,U,I)=$P(S,U,I)+YSDAS
 Q
HPAB ;High Point Adjustment COPING
 S N=0 F I=45:1:55 S:$P(S,U,I)>59 N=N+1
 S YSDAS=$S(N>9:-10,N>7:-5,N>4:0,N>2:5,N>0:10,1:15)
 F I=45:1:55 S $P(S,U,I)=$P(S,U,I)+YSDAS
 Q
HPA1B ;high point AA-EE, a-m
 S N=0
 F I=40,41,42,43,44,56,57,58,59,60,61,62,63,64,65,66,67,68 S:$P(S,U,I)>59 N=N+1
 S YSDAS=$S(N>16:-15,N>14:-10,N>12:-5,N>7:0,N>5:5,N>2:10,1:15)
 S YSDAS1=$S(N>12:0,N>7:5,N>5:10,N>2:15,1:20)
 F I=40,41,42,43,44,56,57,58,59,60,61,62,63,64,65,66 S $P(S,U,I)=$P(S,U,I)+YSDAS
 F I=67,68 S $P(S,U,I)=$P(S,U,I)+YSDAS1
 Q
REPTB ;bariatric reports
 S (YSTOUT,YSUOUT)=""
 S X=$P(^YTT(601,YSTEST,"P"),U),A=$P(^("P"),U,2),B=$P(^("P"),U,3),L1=58-A\2,L2=L1+A+4 S:A<9 A=9
 D DTA^YTREPT
 W !,?(72-$L(X)\2),X,!
 W !?50,$S(YSVFLAG:"*** Invalid Profile ***",1:"Valid Profile")
 W !,"*** Bariatric Norms ***"
 F I=2:1:10 D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 . W:I=2 !,"Response Patterns" ;ASF 1/30/04 ABOVE LINE ALSO
 . W:I=5 !,"Negative Health Habits"
 . W !,?4,$P(^YTT(601,YSTEST,"S",I,0),U,2),?25 D LIKELY
 D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 F I=40:1:68 D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 . W:I=40 !,"Psychiatric Indications"
 . W:I=45 !,"Coping Styles"
 . W:I=56 !,"Stress Moderators"
 . W:I=62 !,"Treatment Prognostics"
 . W:I=67 !,"Management Guides"
 . S YSSID=$P(^YTT(601,YSTEST,"S",I,0),U,2)
 . W !,$P(YSSID," ")
 . W ?5,$J($P(R,U,I),2),"  ",$S($P(S,U,I)'<0:$J($P(S,U,I),3),1:"  0")," "
 . D CHART
 . W ?52,$P(YSSID," ",2,99)
 Q
LIKELY ;
 N X
 S X=$P(S,U,I)
 W $S(X="L":"unlikely problem",X="M":"possible problem",X="H":"likely problem",1:"????")
 Q
CHART ;
 N X
 S X=$P(S,U,I)
 ;W $E("***************************************************************",1,$J(X/3,0,0))
 W $E("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX",1,$J(X/3,0,0))
 Q
PERCENT ;Paint score percentiles
 F I=69:1:97 S $P(S,U,I)=$P(^YTT(601,YSTEST,"S",I,YSSEX),U,$P(R,U,I)+1)

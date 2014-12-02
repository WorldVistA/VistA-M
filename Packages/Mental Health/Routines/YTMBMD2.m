YTMBMD2 ;ALB/ASF-MBMD ; 2/14/12 1:26pm
 ;;5.01;MENTAL HEALTH;**105**;Dec 30, 1994;Build 76
 ;No external references
PERCENT ; bariatric untransformed prevalence scores
 F I=69:1:97 S $P(S,U,I)=$P(^YTT(601,YSTEST,"S",I,YSSEX),U,$P(R,U,I)+1)
 Q
PAINREP ; pain pt report
 S (YSTOUT,YSUOUT)=""
 S X=$P(^YTT(601,YSTEST,"P"),U),A=$P(^("P"),U,2),B=$P(^("P"),U,3),L1=58-A\2,L2=L1+A+4 S:A<9 A=9
 D DTA^YTREPT
 W !,?(72-$L(X)\2),X,!
 W !?50,$S(YSVFLAG:"*** Invalid Profile ***",1:"Valid Profile")
 W !,"*** Pain Patient Percentiles ***"
 F I=2:1:10 D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 . W:I=2 !,"Response Patterns" ;ASF 1/30/04 ABOVE LINE ALSO
 . W:I=5 !,"Negative Health Habits"
 . W !,?4,$P(^YTT(601,YSTEST,"S",I,0),U,2),?25 D LIKELY
 D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 F I=69:1:97 D  D:IOST?1"C-".E&($Y>21) SCR^YTREPT Q:YSTOUT!YSUOUT
 . W:I=69 !,"Psychiatric Indications"
 . W:I=74 !,"Coping Styles"
 . W:I=85 !,"Stress Moderators"
 . W:I=91 !,"Treatment Prognostics"
 . W:I=96 !,"Management Guides"
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
